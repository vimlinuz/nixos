import QtQuick
import Quickshell
import Quickshell.Services.Pipewire

WidgetButton {
    id: root

    // Nerd Font icons (override if you want different glyphs)
    property string enabledIcon: "󰍬"
    property string disabledIcon: "󰍭"

    readonly property var source: Pipewire.defaultAudioSource
    readonly property bool sourceMuted: !!root.source?.audio?.muted
    readonly property real sourceVolume: root.source?.audio?.volume ?? 0

    // Nodes must be explicitly tracked or their audio params (volume/mute)
    // are never fetched from Pipewire.
    PwObjectTracker {
        objects: [root.source].filter(n => n)
    }

    text: root.sourceMuted ? root.disabledIcon : root.enabledIcon

    function setSourceVolume(v: real): void {
        if (root.source?.ready && root.source?.audio) {
            root.source.audio.muted = false;
            root.source.audio.volume = Math.max(0, Math.min(1.0, v));
        }
    }

    onLeftClicked: {
        Quickshell.execDetached(["sh", "-lc", "pavucontrol --tab=4"])
    }

    onRightClicked: {
        if (root.source?.ready && root.source?.audio) {
            root.source.audio.muted = !root.source.audio.muted;
        }
    }

    onWheelUp: root.setSourceVolume(root.sourceVolume + 0.05)
    onWheelDown: root.setSourceVolume(root.sourceVolume - 0.05)
}
