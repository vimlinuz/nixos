//@ pragma UseQApplication
import QtQuick
import Quickshell
import Quickshell.Wayland

import "./modules/bar/"
import "./modules/notifications/"
import "./modules/widgets/"
import "./services" as Services

ShellRoot {
    // Ensure singletons are instantiated on startup.
    property var _niri: Services.Niri
    property var _batterySys: Services.BatterySys
    property var _power: Services.Power
    property var _notifs: Services.Notifs
    property var _calendar: Services.Calendar
    property var _osd: Services.Osd
    property var _audioVis: Services.AudioVis
    // property var _network: Services.Network
    // property var _wallpaper: Services.Wallpaper

    LazyLoader {
        active: true
        component: LeftBar {}
    }

    LazyLoader {
        active: true
        component: PowerMenu {}
    }

    LazyLoader {
        active: true
        component: Calendar {}
    }

    LazyLoader {
        active: true
        component: Popups {}
    }

    LazyLoader {
        active: true
        component: Center {}
    }

    LazyLoader {
        active: true
        component: Osd {}
    }

    // LazyLoader {
    //     active: true
    //     component: WallpaperSwitcher {}
    // }
}
