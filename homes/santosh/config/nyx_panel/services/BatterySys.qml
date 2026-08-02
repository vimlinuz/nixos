pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Item {
    id: root
    visible: false
    width: 0
    height: 0

    // Hardcoded for this system.
    property string batPath: "/sys/class/power_supply/BAT0"
    property string adapterPath: "/sys/class/power_supply/ADP0"

    // 0..1 to match the old UPower service expectations.
    property real percentage: 0

    // Raw status string from sysfs: Charging/Discharging/Full/Not charging/Unknown
    property string status: "Unknown"

    readonly property bool available: true

    readonly property bool isCharging: root.status === "Charging"

    // Consider plugged when charging or when AC is connected but status is "Not charging".
    // We infer adapter plugged by reading ADP0 online.
    readonly property bool isPluggedIn: root.isCharging || (root.adapterOnline && (root.status === "Not charging" || root.status === "Full"))

    property bool adapterOnline: false

    property int intervalMs: 10000

    Timer {
        interval: root.intervalMs
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: batProc.running = true
    }

    // One direct read of all three sysfs files (no shell, no fork).
    Process {
        id: batProc
        command: ["cat", root.batPath + "/capacity", root.batPath + "/status", root.adapterPath + "/online"]

        stdout: StdioCollector {
            onStreamFinished: {
                const lines = (this.text ?? "")
                    .trim()
                    .split("\n")
                    .map(l => l.trim())
                    .filter(l => l.length > 0);

                const cap = parseInt(lines[0], 10);
                if (!isNaN(cap)) root.percentage = cap / 100.0;
                if (lines.length > 1) root.status = lines[1];
                if (lines.length > 2) root.adapterOnline = (lines[2] === "1");
            }
        }
    }
}
