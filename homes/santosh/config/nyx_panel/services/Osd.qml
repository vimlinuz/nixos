pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire

// On-screen display for volume, microphone and brightness.
// Volume/mic are event-driven via Pipewire (instant response); brightness
// has no native service, so it is polled at a fast interval.
Item {
    id: root
    visible: false
    width: 0
    height: 0

    // Guards against showing the OSD while the initial binding is applied
    // at startup (Pipewire fills in the real values right after creation).
    property bool ready: false

    property bool osdVisible: false
    property string active: "volume" // "volume" | "mic" | "brightness"
    property real sinkVolume: Pipewire.defaultAudioSink?.audio?.volume ?? 0
    property bool sinkMuted: !!Pipewire.defaultAudioSink?.audio?.muted
    property real sourceVolume: Pipewire.defaultAudioSource?.audio?.volume ?? 0
    property bool sourceMuted: !!Pipewire.defaultAudioSource?.audio?.muted
    property real brightness: 0

    readonly property string sinkIcon: root.sinkMuted ? "\uf6a9" : "\uf028"
    readonly property string sourceIcon: root.sourceMuted ? "\uf131" : "\uf130"
    readonly property string brightnessIcon: "\uf185"

    // Event-driven: react instantly whenever Pipewire reports a change.
    onSinkVolumeChanged: if (root.ready) { root.active = "volume"; root.show(); }
    onSinkMutedChanged: if (root.ready) { root.active = "volume"; root.show(); }
    onSourceVolumeChanged: if (root.ready) { root.active = "mic"; root.show(); }
    onSourceMutedChanged: if (root.ready) { root.active = "mic"; root.show(); }

    // Arm only after Pipewire's initial sync so the OSD doesn't flash at startup.
    Timer {
        interval: 2000
        running: true
        onTriggered: root.ready = true
    }

    // Nodes must be explicitly tracked or their audio params (volume/mute)
    // are never fetched from Pipewire.
    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink, Pipewire.defaultAudioSource].filter(n => n)
    }

    Timer {
        id: hideTimer
        interval: 1200
        onTriggered: root.osdVisible = false
    }

    function show(): void {
        root.osdVisible = true;
        hideTimer.restart();
    }

    function pauseHide(): void {
        hideTimer.stop();
    }

    function resumeHide(): void {
        hideTimer.restart();
    }

    // Brightness: no native service, so poll at a fast interval.
    Timer {
        id: brightTimer
        interval: 150
        repeat: true
        running: true
        triggeredOnStart: true
        onTriggered: brightProc.running = true
    }

    Process {
        id: brightProc
        command: ["sh", "-lc", "brightnessctl i | grep -oP '\\(\\d+(?=%)' | tr -d '('"]

        stdout: StdioCollector {
            onStreamFinished: {
                const pct = parseFloat((this.text ?? "").trim());
                if (!isNaN(pct) && Math.abs(pct / 100 - root.brightness) > 0.005) {
                    root.brightness = pct / 100;
                    root.active = "brightness";
                    root.show();
                }
            }
        }

        stderr: StdioCollector {
            onStreamFinished: {}
        }
    }
}
