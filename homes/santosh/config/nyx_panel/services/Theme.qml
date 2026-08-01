pragma Singleton

import QtQuick

// Vague colorscheme (https://github.com/vague-theme/vague.nvim)
// Central palette so the whole panel stays consistent with the theme.
Item {
    // Neutrals
    readonly property color bg: "#141415"
    readonly property color bgInactive: "#1c1c24"
    readonly property color bgPanel: "#bb141415"
    readonly property color line: "#252530"
    readonly property color fg: "#cdcdcd"
    readonly property color fgBright: "#d7d7d7"
    readonly property color muted: "#878787"
    readonly property color comment: "#606079"
    readonly property color border: "#878787"
    readonly property color borderDim: "#606079"

    // Semantic
    readonly property color accent: "#7e98e8"      // hint
    readonly property color accentAlt: "#aeaed1"   // constant
    readonly property color error: "#d8647e"
    readonly property color warning: "#f3be7c"
    readonly property color success: "#7fa563"
    readonly property color successDim: "#407fa563"
    readonly property color visual: "#333738"
    readonly property color keyword: "#6e94b2"
    readonly property color string: "#e8b589"
}
