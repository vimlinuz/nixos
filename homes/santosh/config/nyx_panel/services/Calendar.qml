pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

// Calendar popup state (displayed month/year + visibility).
Item {
    id: root
    visible: false
    width: 0
    height: 0

    property bool panelVisible: false

    property int month: new Date().getMonth()
    property int year: new Date().getFullYear()

    function toggle(): void {
        root.panelVisible = !root.panelVisible;
    }

    function show(): void {
        root.panelVisible = true;
    }

    function hide(): void {
        root.panelVisible = false;
    }

    function prevMonth(): void {
        if (root.month === 0) {
            root.month = 11;
            root.year -= 1;
        } else {
            root.month -= 1;
        }
    }

    function nextMonth(): void {
        if (root.month === 11) {
            root.month = 0;
            root.year += 1;
        } else {
            root.month += 1;
        }
    }

    function goToday(): void {
        const now = new Date();
        root.month = now.getMonth();
        root.year = now.getFullYear();
    }

    IpcHandler {
        target: "calendar"
        enabled: true

        function toggle(): void {
            root.toggle();
        }

        function prev(): void {
            root.prevMonth();
        }

        function next(): void {
            root.nextMonth();
        }

        function today(): void {
            root.goToday();
        }
    }
}
