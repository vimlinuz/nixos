pragma Singleton

import QtQuick
import Quickshell

// Power/session actions and menu visibility state.
Item {
    id: root
    visible: false
    width: 0
    height: 0

    property bool menuVisible: false

    readonly property var actions: [
        { name: "shutdown", icon: "\uf011", label: "Shutdown", command: "systemctl poweroff", danger: true },
        { name: "reboot",    icon: "\uf021", label: "Reboot",    command: "systemctl reboot" },
        { name: "sleep",     icon: "\uf186", label: "Sleep",     command: "systemctl suspend" },
        { name: "hibernate", icon: "\uf236", label: "Hibernate", command: "systemctl hibernate" },
        { name: "logout",    icon: "\uf08b", label: "Log Out",   command: "niri msg action quit" },
        { name: "lock",      icon: "\uf023", label: "Lock",      command: "hyprlock" }
    ]

    function toggle(): void {
        menuVisible = !menuVisible;
    }

    function show(): void {
        menuVisible = true;
    }

    function hide(): void {
        menuVisible = false;
    }

    function execAction(name: string): void {
        const actions = root.actions;
        for (let i = 0; i < actions.length; i++) {
            if (actions[i].name === name) {
                root.hide();
                Quickshell.execDetached(["sh", "-lc", actions[i].command]);
                return;
            }
        }
    }
}
