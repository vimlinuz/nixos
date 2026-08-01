import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland

import "../../services" as Services

// On-screen display, top-center. Shows volume / mic / brightness levels
// whenever any of them changes, then auto-hides.
PanelWindow {
    id: root

    visible: Services.Osd.osdVisible

    anchors.top: true
    margins.top: 12

    implicitWidth: content.implicitWidth + 20
    implicitHeight: content.implicitHeight + 16

    color: "transparent"
    exclusionMode: ExclusionMode.Ignore
    focusable: false

    // Pause the hide timer while hovered.
    HoverHandler {
        onHoveredChanged: {
            if (hovered) Services.Osd.pauseHide()
            else Services.Osd.resumeHide()
        }
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

    ColumnLayout {
        id: content
        anchors.fill: parent
        anchors.leftMargin: 8
        anchors.rightMargin: 12
        anchors.topMargin: 4
        anchors.bottomMargin: 4
        spacing: 6

        // Speaker volume
        RowLayout {
            Layout.fillWidth: true
            spacing: 8
            visible: Services.Osd.active === "volume"

            Text {
                Layout.preferredWidth: 24
                horizontalAlignment: Text.AlignHCenter
                text: Services.Osd.sinkIcon
                font.family: "JetBrains Mono Nerd Font"
                font.pixelSize: 14
                color: Services.Osd.sinkMuted ? Services.Theme.muted : Services.Theme.fg
            }

            Bar { Layout.fillWidth: true; value: Services.Osd.sinkVolume }

            Text {
                Layout.preferredWidth: 44
                horizontalAlignment: Text.AlignRight
                text: Math.round(Services.Osd.sinkVolume * 100) + "%"
                font.family: "JetBrains Mono Nerd Font"
                font.pixelSize: 14
                color: Services.Theme.fg
            }
        }

        // Microphone volume
        RowLayout {
            Layout.fillWidth: true
            spacing: 8
            visible: Services.Osd.active === "mic"

            Text {
                Layout.preferredWidth: 24
                horizontalAlignment: Text.AlignHCenter
                text: Services.Osd.sourceIcon
                font.family: "JetBrains Mono Nerd Font"
                font.pixelSize: 14
                color: Services.Osd.sourceMuted ? Services.Theme.muted : Services.Theme.fg
            }

            Bar { Layout.fillWidth: true; value: Services.Osd.sourceVolume }

            Text {
                Layout.preferredWidth: 44
                horizontalAlignment: Text.AlignRight
                text: Math.round(Services.Osd.sourceVolume * 100) + "%"
                font.family: "JetBrains Mono Nerd Font"
                font.pixelSize: 14
                color: Services.Theme.fg
            }
        }

        // Brightness
        RowLayout {
            Layout.fillWidth: true
            spacing: 8
            visible: Services.Osd.active === "brightness"

            Text {
                Layout.preferredWidth: 24
                horizontalAlignment: Text.AlignHCenter
                text: Services.Osd.brightnessIcon
                font.family: "JetBrains Mono Nerd Font"
                font.pixelSize: 14
                color: Services.Theme.fg
            }

            Bar { Layout.fillWidth: true; value: Services.Osd.brightness }

            Text {
                Layout.preferredWidth: 44
                horizontalAlignment: Text.AlignRight
                text: Math.round(Services.Osd.brightness * 100) + "%"
                font.family: "JetBrains Mono Nerd Font"
                font.pixelSize: 14
                color: Services.Theme.fg
            }
        }
    }

    component Bar: Item {
        required property real value

        implicitWidth: 240
        implicitHeight: 5

        Rectangle {
            anchors.fill: parent
            radius: height / 2
            color: Services.Theme.fg
            opacity: 0.15
        }

        Rectangle {
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            width: Math.max(8, parent.width * Math.min(1, Math.max(0, value)))
            height: parent.height
            radius: height / 2
            color: Services.Theme.fg
        }
    }
}
