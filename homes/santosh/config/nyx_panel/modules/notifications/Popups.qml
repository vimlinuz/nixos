import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland

import "../../services" as Services
import "." as Notifications

// Live popup stack, top-right corner.
PanelWindow {
    id: root

    visible: Services.Notifs.popups.length > 0

    anchors {
        top: true
        right: true
    }

    margins.top: 10
    margins.right: 10

    implicitWidth: 340
    implicitHeight: popupColumn.implicitHeight

    color: "transparent"
    exclusionMode: ExclusionMode.Ignore
    // Never keyboard-focusable: a notification appearing must not steal focus
    // from the active window. Pointer clicks still work — layer-shell surfaces
    // receive pointer events regardless of keyboard interactivity.
    focusable: false

    Column {
        id: popupColumn
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        spacing: 8

        Repeater {
            model: Services.Notifs.popups

            Notifications.NotifCard {
                width: root.implicitWidth
            }
        }
    }
}
