import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Notifications

import "../../services" as Services

// Popup notification card. `modelData` is a Notifs wrapper object.
Rectangle {
    id: root

    required property var modelData

    // modelData is transiently null while the delegate is instantiated;
    // unwrap defensively so no binding throws.
    readonly property var notif: modelData ? modelData.notification : null

    width: 340
    height: implicitHeight
    radius: 10
    color: Services.Theme.bgPanel
    border.width: 1
    border.color: root.critical ? Services.Theme.error : Services.Theme.border
    opacity: 0

    readonly property bool critical: root.notif && root.notif.urgency === NotificationUrgency.Critical
    readonly property int bodyFormat: root.notif && /[<*_`#\[\]]/.test(root.notif.body) ? Text.MarkdownText : Text.PlainText

    // Prefer the desktop-entry icon, fall back to the notification's image
    // hint (e.g. `notify-send -i /path/to.png`), then the bell glyph.
    readonly property string iconSource: {
        if (!root.notif) return "";
        if (root.notif.appIcon.length > 0) return "image://icon/" + root.notif.appIcon;
        if (root.notif.image.length > 0) return root.notif.image;
        return "";
    }
    readonly property bool hasIcon: root.iconSource.length > 0
    property bool expanded: false
    property bool moved: false

    readonly property string relativeTime: {
        if (!root.modelData) return "";
        const diff = Math.max(0, Date.now() - root.modelData.time.getTime());
        const m = Math.floor(diff / 60000);
        if (m < 1) return "now";
        if (m < 60) return m + "m";
        const h = Math.floor(m / 60);
        if (h < 24) return h + "h";
        return Math.floor(h / 24) + "d";
    }

    // Fraction of the popup timeout remaining (1 = full countdown left).
    readonly property real popupFraction: root.modelData ? root.modelData.popupFraction : 1

    // Grow/shrink smoothly when expanding and collapsing.
    Behavior on height {
        NumberAnimation { duration: 240; easing.type: Easing.OutCubic }
    }

    // Slide in from the right edge of the screen while fading in.
    Component.onCompleted: {
        root.x = root.width;
        entranceAnim.start();
    }

    ParallelAnimation {
        id: entranceAnim
        NumberAnimation {
            target: root
            property: "x"
            to: 0
            duration: 380
            easing.type: Easing.OutQuint
        }
        NumberAnimation {
            target: root
            property: "opacity"
            to: 1
            duration: 240
            easing.type: Easing.OutCubic
        }
    }

    // Fling off to the right/left after a drag past the threshold.
    NumberAnimation {
        id: dismissAnim
        target: root
        property: "x"
        duration: 280
        easing.type: Easing.InCubic
        onStopped: modelData.setPopup(false)
    }

    // Spring back if the drag did not go far enough.
    NumberAnimation {
        id: springBack
        target: root
        property: "x"
        to: 0
        duration: 300
        easing.type: Easing.OutBack
    }

    MouseArea {
        id: cardMouse
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        acceptedButtons: Qt.LeftButton | Qt.MiddleButton
        preventStealing: true

        drag.target: root
        drag.axis: Drag.XAxis

        property int startY

        // Pause expiry while hovered and grant a fresh countdown so the
        // popup never disappears while it is being read.
        onEntered: {
            modelData.timer.stop();
            modelData.popupStart = new Date();
        }
        onExited: if (modelData.popup) modelData.resetPopupExpiry()

        onPressed: (event) => {
            modelData.timer.stop();
            root.moved = false;
            startY = event.y;
            if (event.button === Qt.MiddleButton) modelData.close();
        }
        onPositionChanged: (event) => {
            if (!pressed) return;
            if (drag.active) {
                root.moved = true;
                return;
            }
            const diffY = event.y - startY;
            if (Math.abs(diffY) > 20) {
                root.expanded = diffY > 0;
                root.moved = true;
            }
        }
        onReleased: (event) => {
            if (!containsMouse) modelData.resetPopupExpiry();
            if (Math.abs(root.x) > root.width * 0.4) {
                dismissAnim.to = root.x > 0 ? root.width * 2 : -root.width * 2;
                dismissAnim.start();
            } else if (root.x !== 0) {
                springBack.start();
            }
        }
        onClicked: (mouse) => {
            if (mouse.button === Qt.MiddleButton) return;
            if (root.moved) return;
            // Capture before invoking: the action may close the notification.
            const notif = modelData.notification;
            if (notif.actions.length === 1) notif.actions[0].invoke();
            // Jump to the app that sent this notification, switching
            // workspace if needed.
            Services.Niri.focusApp(notif);
            // Any left click dismisses the popup; the notification stays in the center history.
            modelData.setPopup(false);
        }

        RowLayout {
            id: content
            anchors.fill: parent
            anchors.margins: 10
            spacing: 10

            // App icon, left side of the card, top-aligned with the title line.
            Item {
                Layout.preferredWidth: 36
                Layout.preferredHeight: 36
                Layout.alignment: Qt.AlignTop

                IconImage {
                    anchors.centerIn: parent
                    width: 24
                    height: 24
                    source: root.iconSource
                    visible: root.hasIcon
                    enabled: false
                }

                Text {
                    anchors.centerIn: parent
                    visible: !root.hasIcon
                    text: "\uf0f3"
                    font.family: "JetBrains Mono Nerd Font"
                    font.pixelSize: 16
                    color: root.critical ? Services.Theme.error : Services.Theme.accent
                }
            }

            ColumnLayout {
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignTop
                spacing: 4

                RowLayout {
                    Layout.fillWidth: true
                    spacing: 6

                    // Title: bold, dominant element next to the icon.
                    Text {
                        Layout.fillWidth: true
                        text: root.notif ? root.notif.summary : ""
                        font.family: "JetBrains Mono Nerd Font"
                        font.pixelSize: 12
                        font.bold: true
                        color: root.critical ? Services.Theme.error : Services.Theme.fgBright
                        wrapMode: Text.Wrap
                        maximumLineCount: 2
                        elide: Text.ElideRight
                    }

                    // App name + age, top right, quiet.
                    Text {
                        Layout.alignment: Qt.AlignVCenter
                        Layout.maximumWidth: 130
                        text: root.notif ? root.notif.appName : ""
                        elide: Text.ElideRight
                        font.family: "JetBrains Mono Nerd Font"
                        font.pixelSize: 9
                        color: Services.Theme.comment
                    }

                    Text {
                        Layout.alignment: Qt.AlignVCenter
                        text: root.relativeTime
                        font.family: "JetBrains Mono Nerd Font"
                        font.pixelSize: 9
                        color: Services.Theme.comment
                    }

                    // Close button, top right corner.
                    Text {
                        Layout.alignment: Qt.AlignVCenter
                        text: "\uf00d"
                        font.family: "JetBrains Mono Nerd Font"
                        font.pixelSize: 10
                        color: Services.Theme.muted

                        MouseArea {
                            anchors.fill: parent
                            anchors.margins: -5
                            cursorShape: Qt.PointingHandCursor
                            onClicked: if (root.modelData) root.modelData.close()
                        }
                    }
                }

                // Body under the title.
                Text {
                    Layout.fillWidth: true
                    text: root.notif ? root.notif.body : ""
                    textFormat: root.bodyFormat
                    font.family: "JetBrains Mono Nerd Font"
                    font.pixelSize: 10
                    color: Services.Theme.fg
                    wrapMode: Text.Wrap
                    maximumLineCount: root.expanded ? 999 : 3
                    elide: Text.ElideRight
                    visible: root.notif && root.notif.body.length > 0
                }

                // Action buttons, bottom of the card, only when expanded.
                RowLayout {
                    Layout.fillWidth: true
                    visible: root.expanded && root.notif && root.notif.actions.length > 0
                    spacing: 6

                    Repeater {
                        model: root.notif ? root.notif.actions : []

                        Rectangle {
                            required property var modelData
                            Layout.fillWidth: true
                            implicitHeight: 24
                            radius: 6
                            color: Services.Theme.line

                            Text {
                                anchors.centerIn: parent
                                text: parent.modelData ? parent.modelData.text : ""
                                font.family: "JetBrains Mono Nerd Font"
                                font.pixelSize: 10
                                color: Services.Theme.accent
                                elide: Text.ElideRight
                            }

                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: if (parent.modelData) parent.modelData.invoke()
                            }
                        }
                    }
                }
            }
        }
    }

    // Countdown line: spans the card (inset past the rounded corners) and
    // depletes as the popup approaches expiry. Anchored to the right only —
    // setting left+right would force the width to fill the anchors and kill
    // the popupFraction binding.
    Rectangle {
        id: timeoutFill
        anchors {
            right: parent.right
            bottom: parent.bottom
            rightMargin: 10
        }
        height: 2
        width: (parent.width - 20) * root.popupFraction
        radius: 1
        color: root.critical ? Services.Theme.error : Services.Theme.warning

        Behavior on width {
            NumberAnimation { duration: 200; easing.type: Easing.Linear }
        }
    }

    implicitHeight: content.implicitHeight + 20
}
