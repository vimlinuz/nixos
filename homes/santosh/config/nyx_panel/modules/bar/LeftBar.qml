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

    implicitWidth: 30
    color: "transparent"

    Rectangle {
        id: background
        anchors.fill: parent

        color: "#bb000000"

        radius: 0

        border.width: 1
        border.color: "#606060"

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 2
            spacing: 4

            // Top section
            ColumnLayout {
                Layout.alignment: Qt.AlignTop
                Layout.fillWidth: true
                spacing: 4

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
                Layout.fillWidth: true
                spacing: 4

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
                Layout.fillWidth: true
                spacing: 4

                Tray { Layout.alignment: Qt.AlignHCenter }
                Brightness { Layout.alignment: Qt.AlignHCenter }
                Volume { Layout.alignment: Qt.AlignHCenter }
                Microphone { Layout.alignment: Qt.AlignHCenter }
                Battery { Layout.alignment: Qt.AlignHCenter }
                Notifications { Layout.alignment: Qt.AlignHCenter }
                Power { Layout.alignment: Qt.AlignHCenter }
            }
        }
    }
}
