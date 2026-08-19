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
    // Cap the stack height so a long list scrolls instead of running off the
    // screen; compact while there are only a few popups.
    readonly property int maxHeight: 600
    implicitHeight: flick.height

    color: "transparent"
    exclusionMode: ExclusionMode.Ignore
    // Never keyboard-focusable: a notification appearing must not steal focus
    // from the active window. Pointer clicks still work — layer-shell surfaces
    // receive pointer events regardless of keyboard interactivity.
    focusable: false

    // Plain Column + Repeater instead of a ListView: a Column reflows its
    // children continuously as card heights change, so the stack never leaves
    // gaps between popups (a stock ListView only lays out on model changes,
    // leaving holes when a card's height settles or an exit animation holds
    // its slot). A `Behavior on y` on each row turns that reflow into a glide.
    Flickable {
        id: flick
        width: root.width
        height: Math.min(stack.height, root.maxHeight)
        clip: true

        // The Flickable does not auto-derive content size from its child
        // Column, so bind it explicitly or there is nothing to scroll.
        contentWidth: stack.width
        contentHeight: stack.height

        Column {
            id: stack
            width: flick.width
            height: stack.implicitHeight
            spacing: 8

            Repeater {
                model: Services.Notifs.popupsModel

                Item {
                    id: row
                    required property var wrapper
                    width: stack.width
                    height: card.height
                    implicitHeight: card.height

                    Behavior on y {
                        NumberAnimation { duration: 220; easing.type: Easing.OutCubic }
                    }

                    Notifications.NotifCard {
                        id: card
                        width: row.width
                        modelData: row.wrapper
                    }
                }
            }
        }
    }

    // Thin scrollbar, shown only while the stack overflows. Sits as a
    // sibling of the Flickable so it does not scroll with the content.
    Item {
        anchors.fill: flick
        visible: flick.contentHeight > flick.height

        property real thumbH: Math.max(24, flick.height * flick.height / flick.contentHeight)
        property real thumbY: flick.contentHeight > flick.height
            ? flick.contentY * (flick.height - thumbH) / (flick.contentHeight - flick.height)
            : 0

        Rectangle {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.rightMargin: 1
            width: 3
            radius: 1.5
            color: Services.Theme.line
        }

        Rectangle {
            x: parent.width - 4
            y: parent.thumbY
            width: 3
            height: parent.thumbH
            radius: 1.5
            color: Services.Theme.muted
        }
    }
}
