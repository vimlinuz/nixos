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

    // Incremental model mirroring `popups`, so the popup ListView can animate
    // insertions/removals/reordering with move and displaced transitions.
    property ListModel popupsModel: ListModel {}

    property bool dnd: false
    property bool centerVisible: false

    // Max simultaneous popups on screen. Newest wins; when the stack is full,
    // new notifications skip the popup and land only in the center history so
    // the popup stack can never overflow the screen.
    property int maxPopups: 4

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
            console.log("[notifs] received appName=", notif.appName, "desktopEntry=", notif.desktopEntry, "actions=", notif.actions.length);
            notif.tracked = true;
            const obj = notifComp.createObject(root, {
                notification: notif,
                popup: false,
                time: new Date(),
                popupTimeout: root.popupTimeout,
                removeNotif: root.remove
            });
            root.list = [obj, ...root.list];
            const fits = !root.dnd && !root.centerVisible && root.popups.length < root.maxPopups;
            obj.setPopup(fits);
        }
    }

    onDndChanged: if (root.dnd) root.popups.forEach(n => n.setPopup(false))
    onCenterVisibleChanged: if (root.centerVisible) root.popups.forEach(n => n.setPopup(false))

    function toggleCenter(): void {
        root.centerVisible = !root.centerVisible;
    }

    function showCenter(): void {
        root.centerVisible = true;
    }

    function hideCenter(): void {
        root.centerVisible = false;
    }

    function toggleDnd(): void {
        root.dnd = !root.dnd;
    }

    function hidePopups(): void {
        root.popups.forEach(n => n.setPopup(false));
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

            // Countdown anchor for the popup expiry. `time` is when the
            // notification arrived (used for relative timestamps); this is
            // reset whenever a card is hovered so the popup stays alive
            // while the user reads it.
            property date popupStart: new Date()

            // 0..1 fraction of the popup timeout remaining; drives the
            // countdown line on the card.
            property real popupFraction: 1

            // 100ms ticker; smooths the countdown line and expires the
            // popup after popupTimeout. Stopped imperatively while the
            // popup is hovered.
            readonly property Timer timer: Timer {
                interval: 100
                repeat: true
                running: notif.popup
                onTriggered: {
                    if (!notif.popup) return;
                    if (notif.notification.urgency === NotificationUrgency.Critical) return;
                    notif.popupFraction = Math.max(0, 1 - (Date.now() - notif.popupStart.getTime()) / notif.popupTimeout);
                    if (Date.now() - notif.popupStart.getTime() >= notif.popupTimeout) {
                        notif.setPopup(false);
                    }
                }
            }

            // Keep the popup model in sync with the popup flag.
            function setPopup(v: bool): void {
                if (notif.popup === v) return;
                notif.popup = v;
                if (v) {
                    notif.popupStart = new Date();
                    notif.popupFraction = 1;
                    root.popupsModel.insert(0, { wrapper: notif });
                } else {
                    for (let i = 0; i < root.popupsModel.count; i++) {
                        if (root.popupsModel.get(i).wrapper === notif) {
                            root.popupsModel.remove(i);
                            break;
                        }
                    }
                }
            }

            // Give the card a fresh full timeout once the mouse leaves.
            function resetPopupExpiry(): void {
                notif.popupStart = new Date();
                notif.timer.start();
            }

            readonly property Connections conn: Connections {
                target: notif.notification
                function onClosed(): void {
                    notif.setPopup(false);
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
