#!/usr/bin/env bash
set -euo pipefail

# Stream cava's raw FFT frames of the system mix, one per line.
#
# cava captures the monitor source of the default sink (unlike pw-cat,
# which records silence on DSP hardware). The shell parses the ASCII
# frames directly, so this stays a single long-lived process.
#
# Requires: cava (pipewire input backend).

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

exec cava -p "$SCRIPT_DIR/cava-vis.conf"
