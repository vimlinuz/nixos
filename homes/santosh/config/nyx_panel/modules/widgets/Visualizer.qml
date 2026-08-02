import QtQuick
import Quickshell

import "../../services" as Services

// Full-height audio "wave" visualizer.
// Rendering only: data comes from the shared Services.AudioVis singleton,
// so multiple instances never spawn duplicate capture pipelines.
Item {
    id: root

    readonly property bool enabled: Services.AudioVis.enabled

    // Whether audio is currently playing (drives fade in/out from LeftBar).
    property bool active: Services.AudioVis.active

    // Thickness of each segment.
    property int lineThickness: Services.Config.visualizerLineThickness

    // Wave color; falls back to the theme accent if left empty in Config.
    readonly property color waveColor: Services.Config.visualizerColor
        ? Services.Config.visualizerColor
        : Services.Theme.accentAlt

    Rectangle {
        anchors.fill: parent
        radius: 0
        color: Services.Theme.bg
        opacity: 0.20
        border.width: 1
        border.color: Services.Theme.border
    }

    // Vertical stack of horizontal bars; looks like a wave through time.
    opacity: (root.enabled && Services.AudioVis.active) ? 1.0 : 0.0

    // Keep taking layout space even when hidden.
    // (We hide via opacity in the parent layout.)
    visible: true

    Item {
        id: wave
        anchors.fill: parent
        anchors.margins: 3

        Repeater {
            model: Services.AudioVis.bins

            Rectangle {
                required property int index

                height: root.lineThickness
                radius: root.lineThickness
                color: root.waveColor
                opacity: 0.90

                // Evenly distribute lines vertically.
                y: (wave.height - height) * (index / Math.max(1, Services.AudioVis.bins - 1))

                // Width follows the real amplitude history.
                width: {
                    const h = Services.AudioVis.history;
                    const base = (h.length === Services.AudioVis.bins) ? h[index] : 0.0;
                    return Math.max(2, wave.width * Math.min(1.0, base));
                }

                x: (wave.width - width) * 0.5
            }
        }
    }
}
