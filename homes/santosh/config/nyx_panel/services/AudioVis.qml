pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

// Single amplitude source shared by all visualizer instances.
// One long-lived cava-vis.sh process (cava FFT) feeds every wave in the shell.
Item {
    id: root
    visible: false
    width: 0
    height: 0

    readonly property bool enabled: !Config.disableVisualizer

    // Audio is considered active if recent amplitude exceeds the threshold.
    property bool active: false

    // Current amplitude (0..1+).
    property real level: 0.0
    property real threshold: Config.visualizerThreshold
    // FFT bar values (0..1000) are scaled to a visible wave height.
    property real gain: Config.visualizerGain

    // How many line segments vertically.
    property int bins: Config.visualizerBins

    onBinsChanged: root.history = []

    // Internal ring buffer for the wave.
    property var history: []

    function pushSample(v) {
        const nv = Math.max(0, Math.min(1.2, v));
        let next;
        if (history.length === 0) {
            next = Array(bins).fill(nv);
        } else {
            next = history.slice();
            next.shift();
            next.push(nv);
        }
        // Reassign, never mutate in place: QML only notifies on property
        // replacement, so in-place push/shift would freeze the wave.
        history = next;
    }

    function start() {
        if (root.enabled) peakProc.running = true;
    }

    function stop() {
        peakProc.running = false;
        root.active = false;
        root.level = 0.0;
        root.history = [];
    }

    onEnabledChanged: root.enabled ? root.start() : root.stop()

    Component.onCompleted: root.start()

    Process {
        id: peakProc
        command: [Quickshell.shellPath("scripts/cava-vis.sh")]

        stdout: SplitParser {
            onRead: function(line) {
                const parts = line.split(';');
                let peak = 0.0;
                for (let i = 0; i < parts.length; i++) {
                    const v = parseFloat(parts[i]);
                    if (!isNaN(v) && v > peak) peak = v;
                }
                const v = peak / 1000.0 * root.gain;
                root.active = v > root.threshold;
                root.level = v;
                root.pushSample(v);
            }
        }

        stderr: StdioCollector {
            onStreamFinished: {}
        }

        onExited: restartTimer.start()
    }

    Timer {
        id: restartTimer
        interval: 2000
        onTriggered: root.start()
    }
}
