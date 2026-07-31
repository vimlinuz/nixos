import QtQuick
import Quickshell

import "../../services" as Services

WidgetButton {
    text: Services.Notifs.dnd ? "\uf1f6" : "\uf0f3"
    label.font.pixelSize: 13
    label.color: Services.Notifs.dnd ? "#8888aa" : "#f0f0f0"

    onLeftClicked: {
        Services.Notifs.hidePopups();
        Services.Notifs.toggleCenter();
    }
    onRightClicked: Services.Notifs.toggleDnd()
}
