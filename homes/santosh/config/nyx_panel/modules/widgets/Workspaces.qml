import QtQuick
import QtQuick.Layouts

import "../../services" as Services

ColumnLayout {
    id: root
    spacing: 4

    property var hoveredWsId: -1
    property real hoveredWsY: 0

    Component.onCompleted: {
        if (Services.Niri.workspaces) Services.Niri.workspaces.maxCount = 10;
    }

    Timer {
        id: hideTimer
        interval: 300
        onTriggered: root.hoveredWsId = -1
    }

    Repeater {
        id: wsRepeater
        model: Services.Niri.workspaces

        WidgetButton {
            id: wsBtn
            required property var model
            implicitWidth: 25
            label.font.pixelSize: 16

            property int thisWsId: model.id
            property bool isActiveWs: model.isActive

            visible: model.isActive || model.activeWindowId !== 0

            text: model.isActive ? "" : "\udb82\udee3"
            active: model.isActive

            onLeftClicked: Services.Niri.focusWorkspaceById(model.id)

            onHoverEntered: {
                hideTimer.stop();
                root.hoveredWsId = model.id;
                root.hoveredWsY = wsBtn.mapToGlobal(0, 0).y;
            }

            onHoverExited: hideTimer.start()
        }
    }

    property int activeWsId: {
        for (var i = 0; i < wsRepeater.count; i++) {
            var d = wsRepeater.itemAt(i);
            if (d && d.isActiveWs) return d.thisWsId;
        }
        return -1;
    }

    Rectangle {
        Layout.fillWidth: true
        height: 3
        color: Services.Theme.fgBright
        opacity: 0.25
    }

    Flow {
        Layout.fillWidth: true
        spacing: 4

        Repeater {
            model: Services.Niri.windows

                Item {
                required property var model
                visible: model.workspaceId === root.activeWsId
                implicitWidth: 24
                implicitHeight: 24

                Rectangle {
                    id: iconBg
                    anchors.fill: parent
                    radius: 0
                    color: model.isFocused ? Services.Theme.visual : ""
                    opacity: 0.55
                }

                Rectangle {
                    anchors.fill: iconBg
                    radius: 0
                    color: Services.Theme.fg
                    opacity: mouseArea.containsMouse ? 0.12 : 0
                }

                Image {
                    anchors.centerIn: parent
                    source: model.iconPath ? "file://" + model.iconPath : ""
                    sourceSize.width: 18
                    sourceSize.height: 18
                    visible: model.iconPath !== ""
                    smooth: true
                }

                Text {
                    anchors.centerIn: parent
                    visible: model.iconPath === ""
                    text: model.appId ? model.appId.charAt(0).toUpperCase() : "?"
                    font.family: "JetBrains Mono Nerd Font"
                    font.pixelSize: 18
                    font.bold: true
                    color: Services.Theme.fg
                }

                MouseArea {
                    id: mouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor

                    onClicked: Services.Niri.focusWindow(model.id)

                    Text {
                        id: tooltip
                        anchors {
                            left: parent.right
                            leftMargin: 6
                            verticalCenter: parent.verticalCenter
                        }
                        visible: mouseArea.containsMouse
                        text: model.title
                        font.family: "JetBrains Mono Nerd Font"
                        font.pixelSize: 11
                        color: Services.Theme.fg
                        style: Text.Sunken
                        styleColor: "#000000"
                        padding: 4

                        Rectangle {
                            anchors.fill: parent
                            radius: 0
                            color: Services.Theme.bgInactive
                            opacity: 0.92
                            z: -1
                        }
                    }
                }
            }
        }
    }

    WorkspacePreview {
        workspaceId: root.hoveredWsId
        panelY: root.hoveredWsY

        onEntered: hideTimer.stop()
        onExited: hideTimer.start()
        onDismissRequested: root.hoveredWsId = -1
    }
}
