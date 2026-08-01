import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland

import "../../services" as Services
import "." as Notifications

// Live popup stack, top-right corner.
PanelWindow {
    id: root

    visible: Services.Notifs.popupsModel.count > 0

    anchors {
        top: true
        right: true
    }

    margins.top: 10
    margins.right: 10

    implicitWidth: 340
    implicitHeight: popupList.contentHeight

    color: "transparent"
    exclusionMode: ExclusionMode.Ignore
    // Never keyboard-focusable: a notification appearing must not steal focus
    // from the active window. Pointer clicks still work — layer-shell surfaces
    // receive pointer events regardless of keyboard interactivity.
    focusable: false

    ListView {
        id: popupList
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        interactive: false
        spacing: 8
        clip: false

        model: Services.Notifs.popupsModel

        // Glide remaining popups into place when one leaves.
        move: Transition {
            NumberAnimation { properties: "y"; duration: 220; easing.type: Easing.OutCubic }
        }
        displaced: Transition {
            NumberAnimation { properties: "y"; duration: 220; easing.type: Easing.OutCubic }
        }

        delegate: Item {
            id: row
            required property var wrapper
            width: popupList.width
            height: card.height

            // Slide the card off screen before it is actually removed.
            SequentialAnimation {
                id: exitAnim
                ParallelAnimation {
                    NumberAnimation {
                        target: card
                        property: "x"
                        to: card.x >= 0 ? row.width * 2 : -row.width * 2
                        duration: 280
                        easing.type: Easing.InCubic
                    }
                    NumberAnimation {
                        target: card
                        property: "opacity"
                        to: 0
                        duration: 200
                    }
                }
                onStopped: row.ListView.delayRemove = false
            }

            ListView.onRemove: {
                row.ListView.delayRemove = true;
                exitAnim.start();
            }

            Notifications.NotifCard {
                id: card
                width: row.width
                height: card.implicitHeight
                modelData: row.wrapper
            }
        }
    }
}
