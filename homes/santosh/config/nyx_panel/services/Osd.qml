pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

// On-screen display for volume, microphone and brightness.
// Polls wpctl/brightnessctl and flashes the OSD panel whenever a value changes.
Item {
    id: root
    visible: false
    width: 0
    height: 0

    property bool osdVisible: false
    property string active: "volume" // "volume" | "mic" | "brightness"
    property real sinkVolume: 0
    property bool sinkMuted: false
    property real sourceVolume: 0
    property bool sourceMuted: false
    property real brightness: 0

    readonly property string sinkIcon: root.sinkMuted ? "\uf6a9" : "\uf028"
    readonly property string sourceIcon: root.sourceMuted ? "\uf131" : "\uf130"
    readonly property string brightnessIcon: "\uf185"

    Timer {
        id: pollTimer
        interval: 400
        repeat: true
        running: true
        triggeredOnStart: true
        onTriggered: {
            sinkProc.running = true;
            sourceProc.running = true;
            brightProc.running = true;
        }
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

    function wpctlVolume(out: string): real {
        const m = out.match(/Volume:\s*([\d.]+)/);
        return m ? parseFloat(m[1]) : 0;
    }

    Process {
        id: sinkProc
        command: ["sh", "-lc", "wpctl get-volume @DEFAULT_AUDIO_SINK@"]

        stdout: StdioCollector {
            onStreamFinished: {
                const out = (this.text ?? "").trim();
                const muted = out.includes("MUTED");
                const vol = root.wpctlVolume(out);
                if (muted !== root.sinkMuted || Math.abs(vol - root.sinkVolume) > 0.001) {
                    root.sinkMuted = muted;
                    root.sinkVolume = vol;
                    root.active = "volume";
                    root.show();
                }
            }
        }

        stderr: StdioCollector {
            onStreamFinished: {}
        }
    }

    Process {
        id: sourceProc
        command: ["sh", "-lc", "wpctl get-volume @DEFAULT_AUDIO_SOURCE@"]

        stdout: StdioCollector {
            onStreamFinished: {
                const out = (this.text ?? "").trim();
                const muted = out.includes("MUTED");
                const vol = root.wpctlVolume(out);
                if (muted !== root.sourceMuted || Math.abs(vol - root.sourceVolume) > 0.001) {
                    root.sourceMuted = muted;
                    root.sourceVolume = vol;
                    root.active = "mic";
                    root.show();
                }
            }
        }

        stderr: StdioCollector {
            onStreamFinished: {}
        }
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
