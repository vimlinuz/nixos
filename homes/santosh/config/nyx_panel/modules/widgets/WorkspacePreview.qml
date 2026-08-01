import QtQuick

import Quickshell
import Quickshell.Wayland

import "../../services" as Services

// Floating list of the windows in a workspace, shown next to the
// workspace buttons while hovering them.
PanelWindow {
    id: root

    required property var workspaceId
    required property real panelY

    signal entered()
    signal exited()
    signal dismissRequested()

    visible: workspaceId >= 0
    color: "transparent"
    focusable: false
    exclusionMode: ExclusionMode.Ignore

    anchors {
        left: true
        top: true
    }

    margins {
        left: 32
        top: panelY
    }

    implicitWidth: 200
    implicitHeight: listColumn.implicitHeight + 12

    Rectangle {
        anchors.fill: parent
        radius: 6
        color: Services.Theme.bgInactive
        opacity: 0.96
        border.width: 1
        border.color: Services.Theme.fgBright

        Column {
            id: listColumn
            anchors.top: parent.top
            anchors.topMargin: 6
            anchors.left: parent.left
            anchors.leftMargin: 6
            anchors.right: parent.right
            anchors.rightMargin: 6
            spacing: 2

            Repeater {
                model: Services.Niri.windows

                Item {
                    required property var model
                    visible: Number(model.workspaceId) === Number(root.workspaceId)
                    width: listColumn.width
                    height: 22

                    Rectangle {
                        anchors.fill: parent
                        color: "#ffffff"
                        opacity: rowMouse.containsMouse ? 0.18 : 0
                    }

                    Image {
                        id: winIcon
                        anchors.left: parent.left
                        anchors.leftMargin: 4
                        anchors.verticalCenter: parent.verticalCenter
                        width: 16
                        height: 16
                        source: model.iconPath ? "file://" + model.iconPath : ""
                        sourceSize.width: 16
                        sourceSize.height: 16
                        visible: model.iconPath !== ""
                        smooth: true
                    }

                    Text {
                        anchors.left: winIcon.right
                        anchors.leftMargin: 6
                        anchors.right: parent.right
                        anchors.rightMargin: 4
                        anchors.verticalCenter: parent.verticalCenter
                        text: model.title.length > 0 ? model.title : (model.appId || "?")
                        elide: Text.ElideRight
                        font.family: "JetBrains Mono Nerd Font"
                        font.pixelSize: 11
                        color: Services.Theme.fgBright
                    }

                    MouseArea {
                        id: rowMouse
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor

                        onClicked: {
                            Services.Niri.focusWindow(model.id);
                            root.dismissRequested();
                        }

                        onEntered: root.entered()
                        onExited: root.exited()
                    }
                }
            }
        }
    }
}
