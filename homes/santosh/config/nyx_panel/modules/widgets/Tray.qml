import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray

ColumnLayout {
    id: root

    spacing: 4

    Repeater {
        model: SystemTray.items

        delegate: WidgetButton {
            id: btn

            required property var modelData

            Layout.fillWidth: true

            text: ""

            IconImage {
                anchors.centerIn: parent
                implicitWidth: 14
                implicitHeight: 14
                source: modelData.icon

                enabled: false
            }

            QsMenuAnchor {
                id: menuAnchor
                anchor.item: btn

                anchor.edges: Edges.Right | Edges.Top
                anchor.gravity: Edges.Right | Edges.Bottom
                anchor.margins.right: 6
            }

            onLeftClicked: modelData.activate()
            onRightClicked: {
                if (!modelData.menu) return;
                menuAnchor.menu = modelData.menu;
                if (!menuAnchor.visible) menuAnchor.open();
            }

            onWheelUp: modelData.scroll(120, false)
            onWheelDown: modelData.scroll(-120, false)
        }
    }
}
