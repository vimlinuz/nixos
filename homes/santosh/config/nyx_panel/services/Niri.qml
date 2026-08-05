pragma Singleton
import QtQuick
import Niri 0.1

// Wraps the Niri 0.1 plugin. The plugin's Niri type cannot hold child
// objects (no default property), so we host the connection + a window
// registry Repeater inside a plain Item and forward the API.
Item {
    id: root

    Niri {
        id: niri

        Component.onCompleted: connect()

        onConnected: console.info("Connected to niri")
        onErrorOccurred: function(error) {
            console.error("Niri error:", error)
        }
    }

    readonly property alias windows: niri.windows
    readonly property alias workspaces: niri.workspaces
    readonly property alias focusedWindow: niri.focusedWindow

    function connect(): bool {
        return niri.connect();
    }

    function isConnected(): bool {
        return niri.isConnected();
    }

    function focusWorkspace(index: int): var {
        return niri.focusWorkspace(index);
    }

    function focusWorkspaceById(id: var): var {
        return niri.focusWorkspaceById(id);
    }

    function focusWorkspaceByName(name: string): var {
        return niri.focusWorkspaceByName(name);
    }

    function focusWindow(id: var): var {
        return niri.focusWindow(id);
    }

    // JS mirror of open windows ({ id, appId }). The C++ WindowModel is not
    // indexable from JS, so we keep our own copy in sync with a Repeater.
    property var windowRegistry: ({})

    Repeater {
        model: niri.windows

        delegate: Item {
            required property var model
            property int windowId: model.id
            property string windowAppId: model.appId

            Component.onCompleted: {
                root.windowRegistry[String(windowId)] = { id: windowId, appId: windowAppId };
                console.log("[niri] registered window", windowId, windowAppId);
            }
            Component.onDestruction: {
                delete root.windowRegistry[String(windowId)];
            }
        }
    }

    // Focus the window of the app that sent a notification, switching to its
    // workspace if needed (niri's focus-window does the switch). Returns true
    // if a matching window was focused.
    function focusApp(notification: var): bool {
        console.log("[focusApp] called, notification:", notification && notification.appName, "/", notification && notification.desktopEntry);
        console.log("[focusApp] registry:", JSON.stringify(root.windowRegistry));
        if (!notification) return false;

        const keys = [];
        if (notification.desktopEntry) keys.push(notification.desktopEntry);
        if (notification.appName) keys.push(notification.appName);
        console.log("[focusApp] keys:", JSON.stringify(keys));
        if (keys.length === 0) return false;

        const lowerKeys = keys.map(k => k.toLowerCase());

        for (const idStr of Object.keys(root.windowRegistry)) {
            const w = root.windowRegistry[idStr];
            if (!w) continue;
            const appId = (w.appId || "").toLowerCase();
            if (!appId) continue;

            // Exact app_id match first.
            if (lowerKeys.includes(appId)) {
                console.log("[focusApp] exact match", w.id, w.appId, "-> focusWindow");
                niri.focusWindow(w.id);
                return true;
            }
            // Fallback: substring match (e.g. appId "com.discordapp.Discord" vs "discord").
            for (const key of lowerKeys) {
                if (appId.includes(key) || key.includes(appId)) {
                    console.log("[focusApp] substring match", w.id, w.appId, "<->", key, "-> focusWindow");
                    niri.focusWindow(w.id);
                    return true;
                }
            }
        }
        console.log("[focusApp] no window matched");
        return false;
    }
}
