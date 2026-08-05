pragma Singleton

import QtQuick

// Global configuration and feature flags.
Item {
    // Kill switch: when true, the visualizer does no work.
    property bool disableVisualizer: false

    // Visualizer rendering knobs.
    property int visualizerBins: 20             // line segments per wave
    property real visualizerGain: 1.0            // FFT amplitude scale (raw cava peak is 0..1000)
    property real visualizerThreshold: 0.01      // level above which audio counts as "active"
    property int visualizerLineThickness: 1
    property string visualizerColor: ""          // wave color override; empty = vague gradient
}
