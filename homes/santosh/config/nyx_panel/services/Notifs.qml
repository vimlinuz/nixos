pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.Notifications

// Native notification daemon + state.
//
// Replaces swaync: Quickshell itself registers as the
// org.freedesktop.Notifications service and all rendering happens here.
Item {
    id: root
    visible: false
    width: 0
    height: 0

    // All active notifications (newest first), each a wrapper QtObject.
    property var list: []
    readonly property var popups: root.list.filter(n => n.popup && !n.closed)
    readonly property var notClosed: root.list.filter(n => !n.closed)

    property bool dnd: false
    property bool centerVisible: false

    // Set when the center is closed by hover-leave/Escape; the next toggle
    // consumes it so the bell can't immediately re-open a just-closed center.
    property bool suppressReopen: false

    // How long a popup stays before it is hidden (critical notifications never expire).
    readonly property int popupTimeout: 5000

    NotificationServer {
        id: server
        keepOnReload: false
        actionsSupported: true
        bodyMarkupSupported: true
        bodyHyperlinksSupported: true
        bodyImagesSupported: true
        imageSupported: true
        persistenceSupported: true

        onNotification: notif => {
            notif.tracked = true;
            const obj = notifComp.createObject(root, {
                notification: notif,
                popup: !root.dnd && !root.centerVisible,
                time: new Date(),
                popupTimeout: root.popupTimeout,
                removeNotif: root.remove
            });
            root.list = [obj, ...root.list];
        }
    }

    onDndChanged: if (root.dnd) root.popups.forEach(n => n.popup = false)
    onCenterVisibleChanged: if (root.centerVisible) root.popups.forEach(n => n.popup = false)

    function toggleCenter(): void {
        if (root.suppressReopen) {
            root.suppressReopen = false;
            return;
        }
        root.centerVisible = !root.centerVisible;
    }

    function showCenter(): void {
        root.suppressReopen = false;
        root.centerVisible = true;
    }

    function hideCenter(): void {
        root.suppressReopen = true;
        root.centerVisible = false;
    }

    function toggleDnd(): void {
        root.dnd = !root.dnd;
    }

    function hidePopups(): void {
        root.popups.forEach(n => n.popup = false);
    }

    function clearAll(): void {
        for (const n of root.list.slice()) n.close();
    }

    function remove(wrapper: var): void {
        root.list = root.list.filter(n => n !== wrapper);
        wrapper.destroy();
    }

    IpcHandler {
        target: "notifs"
        enabled: true

        function toggleCenter(): void {
            root.toggleCenter();
        }

        function toggleDnd(): void {
            root.toggleDnd();
        }

        function clear(): void {
            root.clearAll();
        }

        function isDndEnabled(): bool {
            return root.dnd;
        }

        function hidePopups(): void {
            root.hidePopups();
        }

        function count(): int {
            return root.list.length;
        }
    }

    Component {
        id: notifComp

        QtObject {
            id: notif

            required property var notification
            property bool popup: false
            property bool closed: false
            property date time: new Date()
            property int popupTimeout: 5000
            property var removeNotif: null

            // One-second ticker; expires the popup after popupTimeout.
            // Stopped imperatively while the popup is hovered.
            readonly property Timer timer: Timer {
                interval: 1000
                repeat: true
                running: true
                onTriggered: {
                    if (!notif.popup) return;
                    if (notif.notification.urgency === NotificationUrgency.Critical) return;
                    if (Date.now() - notif.time.getTime() >= notif.popupTimeout) {
                        notif.popup = false;
                    }
                }
            }

            readonly property Connections conn: Connections {
                target: notif.notification
                function onClosed(): void {
                    notif.popup = false;
                    if (notif.closed) return;
                    notif.closed = true;
                    if (notif.removeNotif) notif.removeNotif(notif);
                }
            }

            function close(): void {
                notif.notification.dismiss();
            }
        }
    }
}
