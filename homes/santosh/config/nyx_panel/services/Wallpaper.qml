pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Item {
    id: root
    visible: false
    width: 0
    height: 0

    // Whether the wallpaper panel is currently visible.
    property bool panelVisible: false

    // List of wallpaper file paths (populated on startup).
    property var wallpapers: []

    // Currently active wallpaper path.
    property string currentWallpaper: ""

    // Index of the currently highlighted/selected wallpaper in the list.
    property int selectedIndex: 0

    // Hardcoded wallpaper directory from the nix store flake input.
    property string wallpaperDir: "/nix/store/0dwgg5m249gdbr39q9x24876y2xp6dfi-source/wallpapers"
    function toggle(): void {
        if (panelVisible) {
            hide();
        } else {
            show();
        }
    }

    function show(): void {
        syncSelectedIndex();
        panelVisible = true;
    }

    function hide(): void {
        panelVisible = false;
    }

    // Set selectedIndex to match currentWallpaper in the wallpapers list.
    function syncSelectedIndex(): void {
        if (wallpapers.length === 0 || currentWallpaper === "") return;
        for (let i = 0; i < wallpapers.length; i++) {
            if (wallpapers[i] === currentWallpaper) {
                selectedIndex = i;
                return;
            }
        }
    }

    // Auto-sync when wallpapers list or currentWallpaper finishes loading.
    onWallpapersChanged: syncSelectedIndex()
    onCurrentWallpaperChanged: syncSelectedIndex()

    function selectNext(): void {
        if (wallpapers.length > 0) {
            selectedIndex = Math.min(selectedIndex + 1, wallpapers.length - 1);
        }
    }

    function selectPrev(): void {
        if (wallpapers.length > 0) {
            selectedIndex = Math.max(selectedIndex - 1, 0);
        }
    }

    function applySelected(): void {
        if (wallpapers.length > 0 && selectedIndex >= 0 && selectedIndex < wallpapers.length) {
            setWallpaper(wallpapers[selectedIndex]);
            hide();
        }
    }

    function setWallpaper(filePath: string): void {
        currentWallpaper = filePath;
        Quickshell.execDetached(["sh", "-c",
            "pkill swaybg || true; sleep 0.2; swaybg -m fill -o\\* -i '" + filePath + "' & ln -sf '" + filePath + "' ~/.current_wallpaper"
        ]);
    }

    // Process to scan the wallpaper directory.
    Process {
        id: scanProc
        command: ["sh", "-lc",
            "find '" + root.wallpaperDir + "' -maxdepth 1 -type f \\( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.webp' \\) -printf '%f\\n' 2>/dev/null | sort"
        ]

        stdout: StdioCollector {
            onStreamFinished: {
                const out = (this.text ?? "").trim();
                if (out.length === 0) return;
                const files = out.split("\n");
                const paths = [];
                for (let i = 0; i < files.length; i++) {
                    const f = files[i].trim();
                    if (f.length > 0) {
                        paths.push(root.wallpaperDir + "/" + f);
                    }
                }
                root.wallpapers = paths;
            }
        }
    }

    // Process to read the current wallpaper symlink.
    Process {
        id: currentProc
        command: ["sh", "-lc", "readlink -f ~/.current_wallpaper 2>/dev/null"]

        stdout: StdioCollector {
            onStreamFinished: {
                const out = (this.text ?? "").trim();
                if (out.length > 0) {
                    root.currentWallpaper = out;
                }
            }
        }
    }

    Component.onCompleted: {
        scanProc.running = true;
        currentProc.running = true;
    }
}
