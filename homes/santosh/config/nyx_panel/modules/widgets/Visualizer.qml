import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

import "../../services" as Services

// Full-height audio "wave" visualizer.
//
// Drives from scripts/pw-peak.sh, which prints one float amplitude per line.
Item {
    id: root

    // When disabled, do not poll or animate.
    readonly property bool enabled: !Services.Config.disableVisualizer

    // Audio is considered active if there are active playback streams.
    // This is a cheap, reliable proxy that doesn’t need DSP.
    property bool active: false

    // "Wave" intensity while active (0..1). Purely cosmetic.
    property real level: 0.0
    property real threshold: 0.5

    // How many line segments vertically.
    property int bins: 10

    // Thickness of each segment.
    property int lineThickness: 1

    // Animation phase.
    property real phase: 0.0

    // Internal ring buffer for the wave.
    property var history: []

    onEnabledChanged: {
        if (root.enabled) return;
        root.active = false;
        root.level = 0.0;
        root.phase = 0.0;
        root.history = [];
    }

    function pushSample(v) {
        const nv = Math.max(0, Math.min(1.2, v));
        if (history.length === 0) {
            history = Array(bins).fill(nv);
        } else {
            history.shift();
            history.push(nv);
        }
    }

    // Cosmetic movement: phase + smoothed noise, stable and "wavy".
    Timer {
        interval: 16
        repeat: true
        running: root.enabled
        onTriggered: {
            if (!root.active) {
                root.level = 0.0;
                root.phase = 0.0;
                root.pushSample(0.0);
                return;
            }

            // Advance the shape.
            root.phase += 0.20;

            // Smooth random walk amplitude.
            const step = (Math.random() - 0.5) * 0.10;
            root.level = Math.max(0.10, Math.min(1.0, root.level + step));
            root.pushSample(root.level);
        }
    }

    function refreshActive() {
        if (!root.enabled) return;
        activeProc.running = true;
    }

    Timer {
        interval: 300
        repeat: true
        running: root.enabled
        triggeredOnStart: true
        onTriggered: root.refreshActive()
    }

    Process {
        id: activeProc
        command: ["sh", "-lc", "wpctl status | rg -q '\\[active\\]' && echo 1 || echo 0"]

        stdout: StdioCollector {
            onStreamFinished: {
                root.active = (this.text ?? "").trim() === "1";
            }
        }

        stderr: StdioCollector { onStreamFinished: {} }
    }

    Rectangle {
        anchors.fill: parent
        radius: 0
        color: Services.Theme.bg
        opacity: 0.20
        border.width: 1
        border.color: Services.Theme.border
    }

    // Vertical stack of horizontal bars; looks like a wave through time.
    opacity: (root.enabled && root.active) ? 1.0 : 0.0

    // Keep taking layout space even when hidden.
    // (We hide via opacity in the parent layout.)
    visible: true

    Item {
        id: wave
        anchors.fill: parent
        anchors.margins: 3

        Repeater {
            model: root.bins

            Rectangle {
                required property int index

                height: root.lineThickness
                radius: root.lineThickness
                color: Services.Theme.accentAlt
                opacity: 0.90

                // Evenly distribute lines vertically.
                y: (wave.height - height) * (index / Math.max(1, root.bins - 1))

                // Width depends on a sine wave + history amplitude.
                width: {
                    const base = (root.history.length === root.bins) ? root.history[index] : 0.0;
                    const s = (Math.sin(root.phase + index * 0.35) + 1.0) * 0.5; // 0..1
                    const v = Math.min(1.0, 0.15 + base * 0.85) * (0.35 + s * 0.65);
                    return Math.max(2, wave.width * v);
                }

                x: (wave.width - width) * 0.5
            }
        }
    }
}
