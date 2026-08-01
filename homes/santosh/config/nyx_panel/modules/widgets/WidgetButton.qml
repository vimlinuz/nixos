import QtQuick
import QtQuick.Layouts

import "../../services" as Services

Rectangle {
    id: root

    property alias text: label.text
    property color normalColor: Services.Theme.visual
    property color hoverColor: Services.Theme.visual
    property color activeColor: Services.Theme.visual

    // Background opacity only (keeps text/icons bright).
    property real normalOpacity: 0.40
    property real hoverOpacity: 0.45
    property real activeOpacity: 0.70

    // Text/icon dimming on hover.
    property real normalTextOpacity: 1.0
    property real hoverTextOpacity: 0.70

    property bool active: false

    signal leftClicked()
    signal rightClicked()
    signal wheelUp()
    signal wheelDown()

    signal hoverEntered()
    signal hoverExited()

    radius: 0
    color: "transparent"
    opacity: 1

    implicitWidth: 24
    implicitHeight: 24

    property alias label: label

    Rectangle {
        id: bg
        anchors.fill: parent
        radius: root.radius
        color: root.active ? root.activeColor : root.normalColor
        opacity: root.active ? root.activeOpacity : root.normalOpacity
    }

    Text {
        id: label
        anchors.centerIn: parent
        color: Services.Theme.fg
        opacity: root.normalTextOpacity
        font.family: "JetBrains Mono Nerd Font"
        font.pixelSize: 14
        font.bold: root.active
        visible: label.text.length > 0
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton | Qt.RightButton

        onEntered: {
            bg.opacity = root.hoverOpacity
            label.opacity = root.hoverTextOpacity
            root.hoverEntered();
        }

        onExited: {
            bg.opacity = root.active ? root.activeOpacity : root.normalOpacity
            label.opacity = root.normalTextOpacity
            root.hoverExited();
        }

        onClicked: (mouse) => {
            if (mouse.button === Qt.LeftButton) root.leftClicked();
            if (mouse.button === Qt.RightButton) root.rightClicked();
        }

        onWheel: (wheel) => {
            if (wheel.angleDelta.y > 0) root.wheelUp();
            if (wheel.angleDelta.y < 0) root.wheelDown();
        }
    }
}
