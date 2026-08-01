import QtQuick
import Quickshell

import "../../services" as Services

WidgetButton {
    id: root

    // Match Waybar icons:
    // - wifi connected: \uf1eb
    // - ethernet connected: \udb80\ude00
    // - disconnected: \udb82\udd2e
    text: {
        if (!Services.Network.connected) return " ";
        if (Services.Network.primaryType === "ethernet") return "󰈀 ";
        return "\uf1eb";
    }
    label.font.pixelSize: 12

    // Match Waybar disconnected look.
    label.color: Services.Network.connected ? Services.Theme.fg : Services.Theme.error

    onLeftClicked: Quickshell.execDetached(["sh", "-lc", "nm-connection-editor"])
}
