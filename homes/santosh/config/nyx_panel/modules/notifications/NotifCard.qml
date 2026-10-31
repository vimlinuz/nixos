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

    function lerp(a: real, b: real, t: real): real {
        return a + (b - a) * t;
    }

    function mixColor(c1: color, c2: color, t: real): color {
        return Qt.rgba(root.lerp(c1.r, c2.r, t), root.lerp(c1.g, c2.g, t), root.lerp(c1.b, c2.b, t), root.lerp(c1.a, c2.a, t));
    }

    // Accent → warning → error as the popup expires; error for criticals so
    // the whole card (border, bar, pulse) stays consistent with its styling.
    readonly property color timeoutColor: {
        if (root.critical) return Services.Theme.error;
        const f = root.popupFraction;
        if (f >= 0.5) return root.mixColor(Services.Theme.accent, Services.Theme.warning, 2 * (1 - f));
        return root.mixColor(Services.Theme.warning, Services.Theme.error, 2 * (0.5 - f));
    }

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

    // Exit: slide out to the right while fading, keeping its height so the
    // window never resizes mid-animation (resizing the layer-surface each
    // frame throttles the render loop and the exit stutters). Once the
    // animation finishes the card removes itself from the popup model and
    // the rows below glide up to fill the space.
    ParallelAnimation {
        id: exitAnim
        NumberAnimation {
            target: root
            property: "x"
            to: root.width * 2
            duration: 280
            easing.type: Easing.InCubic
        }
        NumberAnimation {
            target: root
            property: "opacity"
            to: 0
            duration: 220
            easing.type: Easing.OutCubic
        }
        onStopped: if (root.modelData && root.modelData.dismissing) root.modelData.setPopup(false)
    }

    // Snap a partially-swiped card back into place after an aborted swipe.
    NumberAnimation {
        id: springBack
        target: root
        property: "x"
        to: 0
        duration: 220
        easing.type: Easing.OutCubic
    }

    // Start the exit when the wrapper requests an animated dismissal.
    Connections {
        target: root.modelData
        function onDismissingChanged(): void {
            if (root.modelData && root.modelData.dismissing) {
                entranceAnim.stop();
                exitAnim.start();
            }
        }
    }

    MouseArea {
        id: cardMouse
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        acceptedButtons: Qt.LeftButton | Qt.MiddleButton
        preventStealing: true

        property int startX
        property int startY
        property bool swiping: false

        // Pause expiry while hovered and grant a fresh countdown so the
        // popup never disappears while it is being read.
        onEntered: {
            modelData.timer.stop();
            modelData.popupStart = new Date();
        }
        onExited: if (modelData.popup) modelData.resetPopupExpiry()

        onPressed: (event) => {
            entranceAnim.stop();
            springBack.stop();
            modelData.timer.stop();
            root.moved = false;
            swiping = false;
            startX = event.x;
            startY = event.y;
            if (event.button === Qt.MiddleButton) modelData.close();
        }
        onPositionChanged: (event) => {
            if (!pressed) return;
            if (drag.active) {
                root.moved = true;
                return;
            }
            const diffX = event.x - startX;
            const diffY = event.y - startY;
            // A horizontal swipe slides the card along (clamped to its width);
            // it wins over the vertical expand/collapse once it is clearly a
            // sideways drag.
            if (Math.abs(diffX) > 10 && Math.abs(diffX) > Math.abs(diffY)) {
                swiping = true;
                root.moved = true;
                root.x = Math.max(0, Math.min(diffX, root.width));
                return;
            }
            if (swiping) return;
            if (Math.abs(diffY) > 20) {
                root.expanded = diffY > 0;
                root.moved = true;
            }
        }
        onReleased: (event) => {
            if (swiping) {
                // Past 30% of the card width: dismiss. Otherwise snap back.
                if (root.x > root.width * 0.3) {
                    modelData.dismissPopup();
                } else {
                    springBack.start();
                }
                return;
            }
            if (!containsMouse) modelData.resetPopupExpiry();
        }
        onClicked: (mouse) => {
            if (mouse.button === Qt.MiddleButton) return;
            if (root.moved) return;
            // Capture before invoking: the action may close the notification.
            const notif = modelData.notification;
            // Any left click dismisses the popup; the notification stays in
            // the center history. Dismiss first so the exit starts even if
            // the action/focus-app closes the notification mid-handler.
            modelData.dismissPopup();
            if (notif.actions.length === 1) notif.actions[0].invoke();
            // Jump to the app that sent this notification, switching
            // workspace if needed.
            Services.Niri.focusApp(notif);
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

    // ---- Timeout countdown: single depleting hairline ----
    // One thin line instead of a row of segmented boxes. Its width is a plain
    // binding on `popupFraction` (ticked every 200 ms by services/Notifs.qml)
    // and the Behavior smooths the steps, so there is no per-frame JS and no
    // continuous animation for the toast's whole lifetime.

    Rectangle {
        id: gaugeTrack
        anchors {
            right: parent.right
            bottom: parent.bottom
            rightMargin: 10
        }
        width: parent.width - 20
        height: 2
        radius: 1
        color: Services.Theme.line

        // Remaining lifetime; the colored line drains toward the right edge.
        Rectangle {
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width * root.popupFraction
            height: parent.height
            radius: 1
            color: root.timeoutColor

            Behavior on width {
                NumberAnimation { duration: 220; easing.type: Easing.Linear }
            }
        }
    }

    // Static border tint, following the countdown color. Deliberately not
    // animated: a breathing border would repaint the whole popup at 60 fps
    // for the toast's entire lifetime.
    Rectangle {
        id: cardPulse
        anchors.fill: parent
        radius: root.radius
        border.width: 1
        border.color: root.timeoutColor
        color: "transparent"
        opacity: 0.14 + 0.10 * (1 - root.popupFraction)
    }

    implicitHeight: content.implicitHeight + 20
}
