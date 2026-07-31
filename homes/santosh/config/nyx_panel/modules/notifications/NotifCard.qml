import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Notifications

// Popup notification card. `modelData` is a Notifs wrapper object.
Rectangle {
    id: root

    required property var modelData

    width: 300
    radius: 10
    color: "#000000"
    border.width: 1
    border.color: root.critical ? "#f38ba8" : "#404060"
    opacity: 0

    readonly property bool critical: modelData.notification.urgency === NotificationUrgency.Critical
    readonly property int bodyFormat: /[<*_`#\[\]]/.test(modelData.notification.body) ? Text.MarkdownText : Text.PlainText

    readonly property string relativeTime: {
        const diff = Math.max(0, Date.now() - modelData.time.getTime());
        const m = Math.floor(diff / 60000);
        if (m < 1) return "now";
        if (m < 60) return m + "m";
        const h = Math.floor(m / 60);
        if (h < 24) return h + "h";
        return Math.floor(h / 24) + "d";
    }

    Component.onCompleted: fadeIn.start()

    NumberAnimation {
        id: fadeIn
        target: root
        property: "opacity"
        to: 1
        duration: 200
        easing.type: Easing.OutCubic
    }

    MouseArea {
        id: cardMouse
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        acceptedButtons: Qt.LeftButton | Qt.MiddleButton

        // Pause expiry while hovered.
        onEntered: modelData.timer.stop()
        onExited: if (modelData.popup) modelData.timer.start()

        onClicked: (mouse) => {
            if (mouse.button === Qt.MiddleButton) {
                modelData.close();
                return;
            }
            const actions = modelData.notification.actions;
            if (actions.length === 1) {
                actions[0].invoke();
            } else if (actions.length === 0) {
                modelData.close();
            }
        }

        ColumnLayout {
            id: content
            anchors.fill: parent
            anchors.margins: 10
            spacing: 5

            RowLayout {
                Layout.fillWidth: true
                spacing: 6

                IconImage {
                    Layout.preferredWidth: 18
                    Layout.preferredHeight: 18
                    source: root.modelData.notification.appIcon
                    visible: root.modelData.notification.appIcon.length > 0
                    enabled: false
                }

                Text {
                    Layout.preferredWidth: 18
                    visible: root.modelData.notification.appIcon.length === 0
                    text: "\uf0f3"
                    font.family: "JetBrains Mono Nerd Font"
                    font.pixelSize: 12
                    color: root.critical ? "#f38ba8" : "#b4befe"
                    horizontalAlignment: Text.AlignHCenter
                }

                Text {
                    Layout.fillWidth: true
                    text: root.modelData.notification.appName
                    elide: Text.ElideRight
                    font.family: "JetBrains Mono Nerd Font"
                    font.pixelSize: 10
                    color: "#8888aa"
                }

                Text {
                    text: root.relativeTime
                    font.family: "JetBrains Mono Nerd Font"
                    font.pixelSize: 9
                    color: "#666688"
                }

                Text {
                    text: "\uf00d"
                    font.family: "JetBrains Mono Nerd Font"
                    font.pixelSize: 10
                    color: "#8888aa"

                    MouseArea {
                        anchors.fill: parent
                        anchors.margins: -5
                        cursorShape: Qt.PointingHandCursor
                        onClicked: root.modelData.close()
                    }
                }
            }

            Text {
                Layout.fillWidth: true
                text: root.modelData.notification.summary
                font.family: "JetBrains Mono Nerd Font"
                font.pixelSize: 12
                font.bold: true
                color: root.critical ? "#f38ba8" : "#ffffff"
                wrapMode: Text.Wrap
                maximumLineCount: 2
                elide: Text.ElideRight
            }

            Text {
                Layout.fillWidth: true
                text: root.modelData.notification.body
                textFormat: root.bodyFormat
                font.family: "JetBrains Mono Nerd Font"
                font.pixelSize: 10
                color: "#c0c0d0"
                wrapMode: Text.Wrap
                maximumLineCount: 3
                elide: Text.ElideRight
                visible: root.modelData.notification.body.length > 0
            }

            RowLayout {
                Layout.fillWidth: true
                visible: root.modelData.notification.actions.length > 0
                spacing: 6

                Repeater {
                    model: root.modelData.notification.actions

                    Rectangle {
                        required property var modelData
                        Layout.fillWidth: true
                        implicitHeight: 24
                        radius: 6
                        color: "#26263f"

                        Text {
                            anchors.centerIn: parent
                            text: parent.modelData.text
                            font.family: "JetBrains Mono Nerd Font"
                            font.pixelSize: 10
                            color: "#b4befe"
                            elide: Text.ElideRight
                        }

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: parent.modelData.invoke()
                        }
                    }
                }
            }
        }
    }

    implicitHeight: content.implicitHeight + 20
}
