import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland

import "../../services" as Services

// Calendar popup, opened by clicking the Clock in the bar.
// Ported from Caelestia's dashboard calendar (modules/dashboard/dash/Calendar.qml),
// simplified to nyx_panel's plain style.
PanelWindow {
    id: root

    visible: Services.Calendar.panelVisible

    anchors {
        left: true
        top: true
    }

    margins.left: 44
    margins.top: root.topMargin

    // Vertically centered next to the clock in the bar.
    readonly property int topMargin: root.screen ? Math.max(0, Math.round((root.screen.height - root.implicitHeight) / 2)) : 0

    readonly property int gridH: 6 * root.cellH + 5 * root.spacing
    readonly property int navH: 24
    readonly property int weekH: 18

    implicitWidth: 248
    implicitHeight: root.padding * 2 + root.navH + 4 + root.weekH + 4 + root.gridH

    color: "transparent"
    exclusionMode: ExclusionMode.Ignore
    focusable: true

    readonly property int calMonth: Services.Calendar.month
    readonly property int calYear: Services.Calendar.year
    readonly property int todayDay: new Date().getDate()

    readonly property int cellW: 30
    readonly property int cellH: 28
    readonly property int spacing: 2
    readonly property int padding: 10

    readonly property string monthTitle: Qt.formatDate(new Date(root.calYear, root.calMonth, 1), "MMMM yyyy")

    // Weekday short label, locale-aware, ordered Sunday..Saturday.
    function weekLabel(i: int): string {
        return Qt.formatDate(new Date(2024, 0, 7 + i), "ddd").charAt(0);
    }

    // 42 cells (6x7) so the grid never jumps between months.
    function cells(): var {
        const firstDay = new Date(root.calYear, root.calMonth, 1).getDay();
        const daysInMonth = new Date(root.calYear, root.calMonth + 1, 0).getDate();
        const arr = [];
        for (let i = 0; i < 42; i++) {
            const day = i - firstDay + 1;
            arr.push({ day: day >= 1 && day <= daysInMonth ? day : 0 });
        }
        return arr;
    }

    // Auto-close when the cursor leaves the window (same as power menu / notif center).
    readonly property Timer closeTimer: Timer {
        interval: 250
        onTriggered: Services.Calendar.hide()
    }

    HoverHandler {
        onHoveredChanged: if (!hovered) root.closeTimer.start()
    }

    Rectangle {
        anchors.fill: parent
        color: "#bb000000"
        radius: 12
    }

    Rectangle {
        anchors.fill: parent
        color: "transparent"
        radius: 12
        border.width: 1
        border.color: "#606060"
    }

    ColumnLayout {
        id: content
        anchors.fill: parent
        anchors.margins: root.padding
        spacing: 4

        // Month navigation
        RowLayout {
            Layout.fillWidth: true
            spacing: 4

            MouseArea {
                id: prevBtn
                Layout.preferredWidth: 24
                Layout.preferredHeight: 24
                cursorShape: Qt.PointingHandCursor
                onClicked: Services.Calendar.prevMonth()

                Text {
                    anchors.centerIn: parent
                    text: "\uf104"
                    font.family: "JetBrains Mono Nerd Font"
                    font.pixelSize: 14
                    color: "#f0f0f0"
                }
            }

            Item {
                Layout.fillWidth: true
                Layout.preferredHeight: 24

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: Services.Calendar.goToday()

                    Text {
                        anchors.centerIn: parent
                        text: root.monthTitle
                        font.family: "JetBrains Mono Nerd Font"
                        font.pixelSize: 13
                        font.bold: true
                        color: "#ffffff"
                    }
                }
            }

            MouseArea {
                id: nextBtn
                Layout.preferredWidth: 24
                Layout.preferredHeight: 24
                cursorShape: Qt.PointingHandCursor
                onClicked: Services.Calendar.nextMonth()

                Text {
                    anchors.centerIn: parent
                    text: "\uf105"
                    font.family: "JetBrains Mono Nerd Font"
                    font.pixelSize: 14
                    color: "#f0f0f0"
                }
            }
        }

        // Weekday header
        Row {
            Layout.alignment: Qt.AlignHCenter
            spacing: root.spacing

            Repeater {
                model: 7

                delegate: Text {
                    required property int index

                    width: root.cellW
                    height: 18
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: root.weekLabel(index)
                    font.family: "JetBrains Mono Nerd Font"
                    font.pixelSize: 10
                    color: (index === 0 || index === 6) ? "#a0a0a0" : "#8888aa"
                }
            }
        }

        // Day grid
        Grid {
            Layout.alignment: Qt.AlignHCenter
            columns: 7
            spacing: root.spacing

            Repeater {
                model: root.cells()

                delegate: Item {
                    required property var modelData

                    width: root.cellW
                    height: root.cellH

                    readonly property int day: modelData.day
                    readonly property bool inMonth: day > 0
                    readonly property bool isToday: {
                        const now = new Date();
                        return root.calMonth === now.getMonth() && root.calYear === now.getFullYear() && day === root.todayDay;
                    }
                    readonly property bool isWeekend: inMonth && (new Date(root.calYear, root.calMonth, day).getDay() === 0 || new Date(root.calYear, root.calMonth, day).getDay() === 6)

                    Rectangle {
                        anchors.fill: parent
                        anchors.margins: 1
                        radius: 6
                        color: parent.isToday ? "#606060" : "transparent"
                        visible: parent.inMonth
                    }

                    Text {
                        anchors.centerIn: parent
                        text: parent.day > 0 ? parent.day : ""
                        font.family: "JetBrains Mono Nerd Font"
                        font.pixelSize: 11
                        font.bold: parent.isToday
                        color: parent.inMonth ? (parent.isToday ? "#000000" : (parent.isWeekend ? "#a0a0a0" : "#f0f0f0")) : "transparent"
                    }
                }
            }
        }
    }

    // Global mouse: middle-click = go to today, wheel = change month.
    // Only accepts middle button, so left-clicks still reach the nav buttons above.
    MouseArea {
        anchors.fill: content
        acceptedButtons: Qt.MiddleButton
        onWheel: (wheel) => {
            if (wheel.angleDelta.y > 0) Services.Calendar.prevMonth();
            else if (wheel.angleDelta.y < 0) Services.Calendar.nextMonth();
        }
        onClicked: (mouse) => {
            if (mouse.button === Qt.MiddleButton) Services.Calendar.goToday();
        }
    }
}
