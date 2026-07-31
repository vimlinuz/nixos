import QtQuick
import Quickshell

import "../../services" as Services

WidgetButton {
    text: "\uf011"
    label.font.pixelSize: 13
    label.color: "#f38ba8"

    onLeftClicked: Services.Power.toggle()
    onRightClicked: Services.Power.toggle()
}
