import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Io

import "../../services" as Services

PanelWindow {
    id: panel

    visible: Services.Wallpaper.panelVisible

    anchors {
        bottom: true
        left: true
        right: true
    }

    margins.left: 44
    margins.bottom: 4
    margins.right: 4

    implicitHeight: 200
    color: "transparent"

    exclusionMode: ExclusionMode.Ignore
    focusable: true

    readonly property int thumbWidth: 300
    readonly property int thumbSpacing: 6
    readonly property int itemStep: thumbWidth + thumbSpacing  // 206
    readonly property int indicatorHeight: 4
    readonly property int indicatorGap: 6  // gap between indicator and thumbnails

    IpcHandler {
        target: "wallpaper"
        enabled: true

        function toggle(): void {
            Services.Wallpaper.toggle();
        }

        function show(): void {
            Services.Wallpaper.show();
        }

        function hide(): void {
            Services.Wallpaper.hide();
        }
    }

    // Keyboard: h/l navigate, Enter applies, Escape closes.
    Item {
        id: keyHandler
        focus: panel.visible

        Keys.onPressed: function(event) {
            if (event.key === Qt.Key_L) {
                Services.Wallpaper.selectNext();
                scrollToSelected();
                event.accepted = true;
            } else if (event.key === Qt.Key_H) {
                Services.Wallpaper.selectPrev();
                scrollToSelected();
                event.accepted = true;
            } else if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                Services.Wallpaper.applySelected();
                event.accepted = true;
            } else if (event.key === Qt.Key_Escape) {
                Services.Wallpaper.hide();
                event.accepted = true;
            }
        }
    }

    function scrollToSelected(): void {
        const idx = Services.Wallpaper.selectedIndex;
        const itemCenter = idx * panel.itemStep + panel.thumbWidth / 2;
        const target = itemCenter - flickable.width / 2;
        const maxScroll = flickable.contentWidth - flickable.width;
        flickable.contentX = Math.max(0, Math.min(target, maxScroll));
    }

    Connections {
        target: Services.Wallpaper
        function onPanelVisibleChanged(): void {
            if (Services.Wallpaper.panelVisible) {
                keyHandler.forceActiveFocus();
                scrollToSelected();
            }
        }
    }

    // Background
    Rectangle {
        anchors.fill: parent
        color: Services.Theme.bg
        opacity: 0.88
        radius: 12
    }

    Rectangle {
        anchors.fill: parent
        color: "transparent"
        radius: 12
        border.width: 1
        border.color: Services.Theme.borderDim
    }

    // Content
    Item {
        anchors.fill: parent
        anchors.margins: 8

        Flickable {
            id: flickable
            anchors.fill: parent
            contentWidth: wallpaperRow.implicitWidth
            contentHeight: height
            clip: true
            boundsBehavior: Flickable.StopAtBounds
            flickableDirection: Flickable.HorizontalFlick

            Behavior on contentX {
                NumberAnimation { duration: 250; easing.type: Easing.OutCubic }
            }

            // ── Indicator bar ──
            // Lives inside the Flickable so it scrolls with the content.
            // x tracks selectedIndex * itemStep, animated independently.
            Rectangle {
                id: indicatorBar
                y: 0
                x: Services.Wallpaper.selectedIndex * panel.itemStep
                width: panel.thumbWidth
                height: panel.indicatorHeight
                radius: 2
                color: Services.Theme.accent
                z: 10

                Behavior on x {
                    NumberAnimation { duration: 250; easing.type: Easing.OutCubic }
                }
            }

            // ── Thumbnail row ──
            Row {
                id: wallpaperRow
                y: panel.indicatorHeight + panel.indicatorGap
                height: parent.height - panel.indicatorHeight - panel.indicatorGap
                spacing: panel.thumbSpacing
                layoutDirection: Qt.LeftToRight

                Repeater {
                    model: Services.Wallpaper.wallpapers

                    Item {
                        width: panel.thumbWidth
                        height: wallpaperRow.height

                        Rectangle {
                            id: wallpaperItem
                            anchors.fill: parent

                            readonly property string filePath: modelData
                            readonly property bool isCurrent: filePath === Services.Wallpaper.currentWallpaper
                            readonly property bool isSelected: index === Services.Wallpaper.selectedIndex
                            readonly property bool isHovered: mouseArea.containsMouse

                            radius: 8
                            color: "transparent"

                            scale: isHovered && !isSelected ? 1.01 : 1.0
                            z: isSelected ? 2 : (isHovered ? 1 : 0)

                            Behavior on scale {
                                NumberAnimation { duration: 150; easing.type: Easing.OutCubic }
                            }

                            // Thumbnail
                            Rectangle {
                                anchors.fill: parent
                                anchors.margins: 2
                                radius: 6
                                clip: true
                                color: Services.Theme.bgInactive

                                Image {
                                    anchors.fill: parent
                                    source: "file://" + wallpaperItem.filePath
                                    fillMode: Image.PreserveAspectCrop
                                    asynchronous: true
                                    sourceSize.width: 300
                                    sourceSize.height: 200
                                    cache: true
                                }

                                // Dim overlay on non-selected items
                                Rectangle {
                                    anchors.fill: parent
                                    radius: 6
                                    color: Services.Theme.bg
                                    opacity: wallpaperItem.isSelected ? 0.0 : 0.4

                                    Behavior on opacity {
                                        NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
                                    }
                                }

                                // Gradient overlay for filename
                                Rectangle {
                                    anchors.bottom: parent.bottom
                                    anchors.left: parent.left
                                    anchors.right: parent.right
                                    height: 36
                                    radius: 6

                                    gradient: Gradient {
                                        GradientStop { position: 0.0; color: "transparent" }
                                        GradientStop { position: 0.5; color: "#60000000" }
                                        GradientStop { position: 1.0; color: "#cc000000" }
                                    }
                                }

                                // Filename
                                Text {
                                    anchors.bottom: parent.bottom
                                    anchors.left: parent.left
                                    anchors.right: parent.right
                                    anchors.margins: 6
                                    anchors.bottomMargin: 4
                                    text: {
                                        const parts = wallpaperItem.filePath.split("/");
                                        const name = parts[parts.length - 1];
                                        const base = name.replace(/\.[^.]+$/, "");
                                        return base.length > 22 ? base.substring(0, 19) + "..." : base;
                                    }
                                    color: Services.Theme.fg
                                    font.family: "JetBrains Mono Nerd Font"
                                    font.pixelSize: 9
                                    elide: Text.ElideRight
                                    horizontalAlignment: Text.AlignHCenter
                                }
                            }

                            // Current wallpaper badge
                            Rectangle {
                                visible: wallpaperItem.isCurrent
                                anchors.top: parent.top
                                anchors.right: parent.right
                                anchors.margins: 6
                                width: 22
                                height: 22
                                radius: 11
                                color: Services.Theme.successDim
                                border.width: 1
                                border.color: Services.Theme.success

                                Text {
                                    anchors.centerIn: parent
                                    text: "󰄬"
                                    color: Services.Theme.success
                                    font.family: "JetBrains Mono Nerd Font"
                                    font.pixelSize: 12
                                    font.bold: true
                                }
                            }

                            MouseArea {
                                id: mouseArea
                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: Qt.PointingHandCursor

                                onClicked: {
                                    Services.Wallpaper.selectedIndex = index;
                                    scrollToSelected();
                                    Services.Wallpaper.setWallpaper(wallpaperItem.filePath);
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
