import QtQuick
import Quickshell

import "../../services" as Services

WidgetButton {
    text: "\uf011"
    label.font.pixelSize: 13
    label.color: Services.Theme.fgBright

    onLeftClicked: Services.Power.toggle()
    onRightClicked: Services.Power.toggle()
}
