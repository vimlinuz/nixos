import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import Quickshell.Wayland

import "../../services" as Services
import "../widgets/"

// Notification center panel, opened from the bell button in the bar.
PanelWindow {
    id: root

    visible: Services.Notifs.centerVisible

    anchors {
        right: true
        top: true
    }

    margins.right: 12
    margins.top: 4

    implicitWidth: 400
    implicitHeight: 16 + headerH + 6 + 1 + 6 + listH

    color: "transparent"
    exclusionMode: ExclusionMode.Ignore
    // Never keyboard-focusable: niri gives keyboard focus to on-demand layer
    // surfaces when they are shown, so opening the center would steal focus
    // from the active window. Pointer interaction (clicking rows, scrolling)
    // works regardless of keyboard interactivity.
    focusable: false

    // Auto-close when the cursor is away from the window. HoverHandler only
    // fires on hover *changes*, so the timer must also be started when the
    // window appears — otherwise, because the bell sits at the other end of
    // the screen, the center would open and never close again.
    readonly property Timer closeTimer: Timer {
        interval: 2500
        onTriggered: Services.Notifs.hideCenter()
    }

    onVisibleChanged: {
        if (root.visible) root.closeTimer.start();
        else root.closeTimer.stop();
    }

    HoverHandler {
        onHoveredChanged: {
            if (hovered) root.closeTimer.stop();
            else root.closeTimer.start();
        }
    }

    readonly property int headerH: 24
    readonly property int rowH: 34
    readonly property int listMaxH: 600
    readonly property int listH: {
        const count = Services.Notifs.notClosed.length;
        return count === 0 ? 30 : Math.min(count * (root.rowH + 2), root.listMaxH);
    }

    Rectangle {
        anchors.fill: parent
        color: Services.Theme.bgPanel
        radius: 12
    }

    Rectangle {
        anchors.fill: parent
        color: "transparent"
        radius: 12
        border.width: 1
        border.color: Services.Theme.border
    }

    Item {
        anchors.fill: parent
        anchors.margins: 8

        Row {
            id: header
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: root.headerH
            spacing: 4

            Text {
                anchors.verticalCenter: parent.verticalCenter
                width: header.width - dndBtn.width - clearBtn.width - closeBtn.width - 12
                text: Services.Notifs.notClosed.length > 0 ? "Notifications (%1)".arg(Services.Notifs.notClosed.length) : "Notifications"
                font.family: "JetBrains Mono Nerd Font"
                font.pixelSize: 13
                font.bold: true
                color: Services.Theme.fgBright
                elide: Text.ElideRight
                verticalAlignment: Text.AlignVCenter
            }

            WidgetButton {
                id: dndBtn
                width: 26
                height: 26
                text: Services.Notifs.dnd ? "\uf1f6" : "\uf0f3"
                label.font.pixelSize: 14
                label.color: Services.Notifs.dnd ? Services.Theme.muted : Services.Theme.fg
                onLeftClicked: Services.Notifs.toggleDnd()
            }

            WidgetButton {
                id: clearBtn
                width: 26
                height: 26
                text: "\uf1f8"
                label.font.pixelSize: 14
                onLeftClicked: Services.Notifs.clearAll()
            }

            WidgetButton {
                id: closeBtn
                width: 26
                height: 26
                text: "\uf00d"
                label.font.pixelSize: 14
                onLeftClicked: Services.Notifs.hideCenter()
            }
        }

        Rectangle {
            id: separator
            anchors.top: header.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.topMargin: 6
            height: 1
            color: Services.Theme.border
            opacity: 0.6
        }

        Flickable {
            id: flick
            anchors.top: separator.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.topMargin: 6
            clip: true

            Column {
                id: listCol
                width: flick.width
                spacing: 2

                Text {
                    width: flick.width
                    visible: Services.Notifs.notClosed.length === 0
                    text: "No notifications"
                    font.family: "JetBrains Mono Nerd Font"
                    font.pixelSize: 12
                    color: Services.Theme.comment
                    horizontalAlignment: Text.AlignHCenter
                    topPadding: 8
                }

                Repeater {
                    model: Services.Notifs.notClosed

                    delegate: Item {
                        required property var modelData

                        width: listCol.width
                        height: root.rowH

                        Rectangle {
                            anchors.fill: parent
                            radius: 6
                            color: Services.Theme.line
                            opacity: rowMouse.containsMouse ? 0.6 : 0
                            Behavior on opacity { NumberAnimation { duration: 120 } }
                        }

                        // Left click invokes the sole action, middle click dismisses.
                        MouseArea {
                            id: rowMouse
                            anchors.fill: parent
                            hoverEnabled: true
                            acceptedButtons: Qt.LeftButton | Qt.MiddleButton
                            cursorShape: Qt.PointingHandCursor

                            onClicked: (mouse) => {
                                if (mouse.button === Qt.MiddleButton) {
                                    modelData.close();
                                    return;
                                }
                                const actions = modelData.notification.actions;
                                if (actions.length === 1) actions[0].invoke();
                            }
                        }

                        RowLayout {
                            anchors.fill: parent
                            anchors.leftMargin: 6
                            anchors.rightMargin: 6
                            spacing: 6

                            IconImage {
                                Layout.preferredWidth: 20
                                Layout.preferredHeight: 20
                                source: modelData.notification.appIcon
                                visible: modelData.notification.appIcon.length > 0
                                enabled: false
                            }

                            Text {
                                Layout.preferredWidth: 20
                                visible: modelData.notification.appIcon.length === 0
                                text: "\uf0f3"
                                font.family: "JetBrains Mono Nerd Font"
                                font.pixelSize: 13
                                color: Services.Theme.muted
                                horizontalAlignment: Text.AlignHCenter
                            }

                            Text {
                                Layout.fillWidth: true
                                text: modelData.notification.appName + "  " + modelData.notification.summary
                                elide: Text.ElideRight
                                font.family: "JetBrains Mono Nerd Font"
                                font.pixelSize: 12
                                color: Services.Theme.fg
                            }

                            Text {
                                text: "\uf00d"
                                font.family: "JetBrains Mono Nerd Font"
                                font.pixelSize: 11
                                color: Services.Theme.muted

                                MouseArea {
                                    anchors.fill: parent
                                    anchors.margins: -5
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: modelData.close()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
