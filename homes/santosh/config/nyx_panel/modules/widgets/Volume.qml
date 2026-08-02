import QtQuick
import Quickshell
import Quickshell.Services.Pipewire

WidgetButton {
    id: root

    // Nerd Font icons (override if you want different glyphs)
    property string unmutedIcon: "󰕾"
    property string mutedIcon: "󰝟"

    readonly property var sink: Pipewire.defaultAudioSink
    readonly property bool muted: !!root.sink?.audio?.muted
    readonly property real volume: root.sink?.audio?.volume ?? 0

    // Nodes must be explicitly tracked or their audio params (volume/mute)
    // are never fetched from Pipewire.
    PwObjectTracker {
        objects: [root.sink].filter(n => n)
    }

    text: root.muted ? root.mutedIcon : root.unmutedIcon
    active: root.muted

    function setVolume(v: real): void {
        if (root.sink?.ready && root.sink?.audio) {
            root.sink.audio.muted = false;
            root.sink.audio.volume = Math.max(0, Math.min(1.0, v));
        }
    }

    onLeftClicked: {
        Quickshell.execDetached(["sh", "-lc", "pavucontrol"])
    }

    onRightClicked: {
        if (root.sink?.ready && root.sink?.audio) {
            root.sink.audio.muted = !root.sink.audio.muted;
        }
    }

    onWheelUp: root.setVolume(root.volume + 0.05)
    onWheelDown: root.setVolume(root.volume - 0.05)
}
