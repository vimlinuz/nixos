import QtQuick

import "../../services" as Services
import "./" as Widgets

Widgets.WidgetButton {
    id: root

    property var now: new Date()

    text: ""

    implicitWidth: 26
    implicitHeight: 110

    onLeftClicked: Services.Calendar.toggle()

    readonly property int paddingX: 2
    readonly property int paddingTop: 6
    readonly property int paddingBottom: 6

    Column {
        anchors {
            fill: parent
            leftMargin: root.paddingX
            rightMargin: root.paddingX
            topMargin: root.paddingTop
            bottomMargin: root.paddingBottom
        }
        spacing: 1

        Text {
            text: {
                let h = root.now.getHours();
                h = h % 12;
                if (h === 0) h = 12;
                return String(h).padStart(2, "0");
            }
            color: "#ffffff"
            font.family: "JetBrains Mono Nerd Font"
            font.pixelSize: 16
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            width: parent.width
        }

        Text {
            text: String(root.now.getMinutes()).padStart(2, "0")
            color: "#ffffff"
            font.family: "JetBrains Mono Nerd Font"
            font.pixelSize: 16
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            width: parent.width
        }

        Rectangle {
            width: parent.width
            height: 2
            color: "#ffffff"
            opacity: 0.25
        }

        Text {
            text: Qt.formatDateTime(root.now, "ddd")
            color: "#ffffff"
            font.family: "JetBrains Mono Nerd Font"
            font.pixelSize: 11
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            width: parent.width
        }

        Text {
            text: Qt.formatDateTime(root.now, "d")
            color: "#ffffff"
            font.family: "JetBrains Mono Nerd Font"
            font.pixelSize: 11
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            width: parent.width
        }

        Text {
            text: Qt.formatDateTime(root.now, "MMM")
            color: "#ffffff"
            font.family: "JetBrains Mono Nerd Font"
            font.pixelSize: 11
            font.bold: true
            horizontalAlignment: Text.AlignHCenter
            width: parent.width
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: root.now = new Date()
    }
}
