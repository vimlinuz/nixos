import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland

import "../widgets/"

PanelWindow {
    id: bar

    anchors {
        left: true
        top: true
        bottom: true
    }

    implicitWidth: 40
    color: "transparent"

    Rectangle {
        id: background
        anchors.fill: parent

        color: "#bb000000"

        // color: "#000000"
        // opacity: 0.80
        radius: 8

        border.width: 1
        border.color: "#606060"

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 4
            spacing: 6

            // Top section
            ColumnLayout {
                Layout.alignment: Qt.AlignTop
                spacing: 6

                Workspaces { Layout.fillWidth: true }
            }

            // Spacer between top and center (visualizer lives here)
            Visualizer {
                Layout.fillWidth: true
                Layout.fillHeight: true
                opacity: active ? 1.0 : 0.0
            }

            // Center section
            ColumnLayout {
                Layout.alignment: Qt.AlignVCenter
                spacing: 6

                Clock { Layout.fillWidth: true }
            }

            // Spacer between center and bottom (visualizer lives here)
            Visualizer {
                Layout.fillWidth: true
                Layout.fillHeight: true
                opacity: active ? 1.0 : 0.0
            }

            // Bottom section
            ColumnLayout {
                Layout.alignment: Qt.AlignBottom
                spacing: 6

                Tray { Layout.fillWidth: true }
                // Network { Layout.fillWidth: true }
                Brightness { Layout.fillWidth: true }
                Volume { Layout.fillWidth: true }
                Microphone { Layout.fillWidth: true }
                Battery { Layout.fillWidth: true }
                Notifications { Layout.fillWidth: true }
            }
        }
    }
}
