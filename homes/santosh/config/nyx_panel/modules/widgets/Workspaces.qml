import QtQuick
import QtQuick.Layouts

import "../../services" as Services

ColumnLayout {
    id: root
    spacing: 4

    Component.onCompleted: {
        if (Services.Niri.workspaces) Services.Niri.workspaces.maxCount = 10;
    }

    Repeater {
        id: wsRepeater
        model: Services.Niri.workspaces

        WidgetButton {
            required property var model
            implicitWidth: 32
            label.font.pixelSize: 21

            property int thisWsId: model.id
            property bool isActiveWs: model.isActive

            text: model.isActive ? "" : "\udb82\udee3"
            active: model.isActive

            onLeftClicked: Services.Niri.focusWorkspaceById(model.id)
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
        color: "#ffffff"
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
                implicitWidth: 32
                implicitHeight: 28

                Rectangle {
                    id: iconBg
                    anchors.fill: parent
                    radius: 6
                    color: model.isFocused ? "#4a4a6a" : ""
                    opacity: 0.55
                }

                Rectangle {
                    anchors.fill: iconBg
                    radius: 6
                    color: "#ffffff"
                    opacity: mouseArea.containsMouse ? 0.12 : 0
                }

                Image {
                    anchors.centerIn: parent
                    source: model.iconPath ? "file://" + model.iconPath : ""
                    sourceSize.width: 26
                    sourceSize.height: 26
                    visible: model.iconPath !== ""
                    smooth: true
                }

                Text {
                    anchors.centerIn: parent
                    visible: model.iconPath === ""
                    text: model.appId ? model.appId.charAt(0).toUpperCase() : "?"
                    font.family: "JetBrains Mono Nerd Font"
                    font.pixelSize: 26
                    font.bold: true
                    color: "#d0d0e0"
                }

                MouseArea {
                    id: mouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor

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
                        color: "#e0e0f0"
                        style: Text.Sunken
                        styleColor: "#000000"
                        padding: 4

                        Rectangle {
                            anchors.fill: parent
                            radius: 4
                            color: "#1a1a2e"
                            opacity: 0.92
                            z: -1
                        }
                    }
                }
            }
        }
    }
}
