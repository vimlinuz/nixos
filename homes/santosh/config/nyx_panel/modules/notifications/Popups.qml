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

    implicitWidth: 300
    implicitHeight: popupColumn.implicitHeight

    color: "transparent"
    exclusionMode: ExclusionMode.Ignore
    focusable: true

    // Escape hides all popups; the key handler takes focus while popups are shown.
    Item {
        id: keyHandler
        focus: root.visible

        Keys.onPressed: (event) => {
            if (event.key === Qt.Key_Escape) {
                Services.Notifs.hidePopups();
                event.accepted = true;
            }
        }
    }

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
