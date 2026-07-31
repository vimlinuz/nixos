import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Wayland

import "../../services" as Services

PanelWindow {
    id: panel

    visible: Services.Power.menuVisible

    anchors {
        left: true
        bottom: true
    }

    margins.left: 44
    margins.bottom: 4

    implicitWidth: menuWidth
    implicitHeight: headerHeight + headerGap + rows.implicitHeight + 16

    color: "transparent"
    exclusionMode: ExclusionMode.Ignore
    focusable: true

    readonly property int menuWidth: 170
    readonly property int rowHeight: 34
    readonly property int headerHeight: 20
    readonly property int headerGap: 6

    property int selectedIndex: 0

    IpcHandler {
        target: "power"
        enabled: true

        function toggle(): void {
            Services.Power.toggle();
        }

        function show(): void {
            Services.Power.show();
        }

        function hide(): void {
            Services.Power.hide();
        }
    }

    // Keyboard: j/k or Up/Down navigate, Enter executes, Escape closes.
    Item {
        id: keyHandler
        focus: panel.visible

        Keys.onPressed: function(event) {
            if (event.key === Qt.Key_J || event.key === Qt.Key_Down) {
                selectNext();
                event.accepted = true;
            } else if (event.key === Qt.Key_K || event.key === Qt.Key_Up) {
                selectPrev();
                event.accepted = true;
            } else if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                execSelected();
                event.accepted = true;
            } else if (event.key === Qt.Key_Escape) {
                Services.Power.hide();
                event.accepted = true;
            }
        }
    }

    Connections {
        target: Services.Power
        function onMenuVisibleChanged(): void {
            if (Services.Power.menuVisible) {
                panel.selectedIndex = 0;
                keyHandler.forceActiveFocus();
            }
        }
    }

    function selectNext(): void {
        panel.selectedIndex = Math.min(panel.selectedIndex + 1, Services.Power.actions.length - 1);
    }

    function selectPrev(): void {
        panel.selectedIndex = Math.max(panel.selectedIndex - 1, 0);
    }

    function execSelected(): void {
        const actions = Services.Power.actions;
        if (panel.selectedIndex >= 0 && panel.selectedIndex < actions.length) {
            Services.Power.execAction(actions[panel.selectedIndex].name);
        }
    }

    // Background
    Rectangle {
        anchors.fill: parent
        color: "#000000"
        opacity: 0.88
        radius: 12
    }

    Rectangle {
        anchors.fill: parent
        color: "transparent"
        radius: 12
        border.width: 1
        border.color: "#404060"
    }

    // Content
    Item {
        anchors.fill: parent
        anchors.margins: 8

        Column {
            id: menuCol
            anchors.fill: parent
            spacing: 2

            // Header
            Text {
                text: "Power Menu"
                width: parent.width
                height: panel.headerHeight
                color: "#8888aa"
                font.family: "JetBrains Mono Nerd Font"
                font.pixelSize: 10
                font.letterSpacing: 1
                verticalAlignment: Text.AlignVCenter
                leftPadding: 4
            }

            Item { height: panel.headerGap; width: 1 }

            // Rows
            Column {
                id: rows
                width: parent.width
                spacing: 2

                Repeater {
                    model: Services.Power.actions

                    Item {
                        id: row
                        required property int index
                        required property var modelData

                        width: panel.menuWidth
                        height: panel.rowHeight

                        readonly property bool isSelected: index === panel.selectedIndex
                        readonly property bool isHovered: mouseArea.containsMouse
                        readonly property bool isDanger: modelData.danger === true

                        Rectangle {
                            anchors.fill: parent
                            radius: 6
                            color: row.isSelected ? "#3a3a5a" : "transparent"
                            opacity: row.isSelected ? 0.9 : 0.0
                        }

                        Text {
                            id: rowIcon
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: 12
                            width: 18
                            horizontalAlignment: Text.AlignHCenter
                            text: row.modelData.icon
                            font.family: "JetBrains Mono Nerd Font"
                            font.pixelSize: 14
                            color: row.isSelected ? (row.isDanger ? "#f38ba8" : "#b4befe") : (row.isDanger ? "#f38ba8" : "#e0e0e0")
                        }

                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: rowIcon.right
                            anchors.leftMargin: 8
                            text: row.modelData.label
                            font.family: "JetBrains Mono Nerd Font"
                            font.pixelSize: 12
                            font.bold: row.isSelected
                            color: row.isSelected ? "#ffffff" : "#e0e0e0"
                        }

                        MouseArea {
                            id: mouseArea
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor

                            onEntered: panel.selectedIndex = row.index
                            onClicked: Services.Power.execAction(row.modelData.name)
                        }
                    }
                }
            }
        }
    }
}
