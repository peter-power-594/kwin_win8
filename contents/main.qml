/********************************************************************
Copyright (C) 2014 Demitrius Belai <demitriusbelai@terra.com.br>

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*********************************************************************/
import QtQuick 1.1
import org.kde.kwin.decoration 0.1

Decoration {
    ColorHelper {
        id: colorHelper
    }
    DecorationOptions {
        id: options
        deco: decoration
    }
    id: root
    alpha: false
    property real buttonSize: (borders.top - 1) / 3.0 * 2.0
    property real topHeight: decoration.maximized ? maximizedBorders.top : borders.top
    property alias titleAlignment: caption.horizontalAlignment
    Rectangle {
        color: "black"
        opacity: 0.0352941176471
        visible: !decoration.maximized
        anchors {
            fill: parent
        }
        border {
            width: decoration.maximized ? 0 : 1
            //color: colorHelper.shade(options.titleBarColor, ColorHelper.DarkShade)
            color: "black"
        }
    }
    Rectangle {
        color: "black"
        opacity: 0.0862745098039
        visible: !decoration.maximized
        anchors {
            fill: parent
            bottomMargin: 1
            topMargin: 1
            leftMargin: 1
            rightMargin: 1
        }
        border {
            width: decoration.maximized ? 0 : 1
            //color: colorHelper.shade(options.titleBarColor, ColorHelper.DarkShade)
            color: "black"
        }
    }
    Rectangle {
        color: options.titleBarColor
        //color: "#4d8ce3"
        anchors {
            fill: parent
            bottomMargin: decoration.maximized ? 0 : 2
            topMargin: decoration.maximized ? 0 : 2
            leftMargin: decoration.maximized ? 0 : 2
            rightMargin: decoration.maximized ? 0 : 2
        }
        // outer Border
        border {
            width: decoration.maximized ? 0 : 1
            color: colorHelper.shade(options.titleBarColor, ColorHelper.MidShade)
            //color: "#3b6bae"
        }
        Item {
            id: top
            anchors {
                left: parent.left
                right: parent.right
                top: parent.top
                topMargin: decoration.maximized ? 0 : 1
                leftMargin: decoration.maximized ? 0 : root.borders.right
                rightMargin: decoration.maximized ? 0 : root.borders.left
            }
            height: decoration.maximized ? root.maximizedBorders.top : root.borders.top
            MouseArea {
                acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
                anchors.fill: parent
                onDoubleClicked: decoration.titlebarDblClickOperation()
                onPressed: {
                    if (mouse.button == Qt.LeftButton) {
                        mouse.accepted = false;
                    } else {
                        decoration.titlePressed(mouse.button, mouse.buttons);
                    }
                }
                onReleased: decoration.titleReleased(mouse.button, mouse.buttons)
            }

            Item {
                id: titleRow
                anchors {
                    left: parent.left
                    right: parent.right
                    top: parent.top
                    topMargin: 0
                }
                ButtonGroup {
                    id: leftButtonGroup
                    spacing: 1
                    explicitSpacer: root.buttonSize
                    menuButton: menuButtonComponent
                    //appMenuButton: appMenuButtonComponent
                    minimizeButton: minimizeButtonComponent
                    maximizeButton: maximizeButtonComponent
                    //keepBelowButton: keepBelowButtonComponent
                    //keepAboveButton: keepAboveButtonComponent
                    //helpButton: helpButtonComponent
                    //shadeButton: shadeButtonComponent
                    //allDesktopsButton: stickyButtonComponent
                    closeButton: closeButtonComponent
                    buttons: options.titleButtonsLeft
                    anchors {
                        top: parent.top
                        left: parent.left
                    }
                }
                Text {
                    id: caption
                    textFormat: Text.PlainText
                    anchors {
                        top: parent.top
                        left: leftButtonGroup.right
                        right: rightButtonGroup.left
                        rightMargin: 5
                        leftMargin: 5
                        topMargin: (root.topHeight - caption.implicitHeight) / 2
                        //bottomMargin: 3
                    }
                    color: options.fontColor
                    text: decoration.caption
                    font: options.titleFont
                    //style: root.titleShadow ? Text.Raised : Text.Normal
                    //styleColor: colorHelper.shade(color, ColorHelper.ShadowShade)
                    //elide: Text.ElideMiddle
                }
                ButtonGroup {
                    id: rightButtonGroup
                    spacing: 1
                    explicitSpacer: root.buttonSize
                    menuButton: menuButtonComponent
                    //appMenuButton: appMenuButtonComponent
                    minimizeButton: minimizeButtonComponent
                    maximizeButton: maximizeButtonComponent
                    //keepBelowButton: keepBelowButtonComponent
                    //keepAboveButton: keepAboveButtonComponent
                    //helpButton: helpButtonComponent
                    //shadeButton: shadeButtonComponent
                    //allDesktopsButton: stickyButtonComponent
                    closeButton: closeButtonComponent
                    buttons: options.titleButtonsRight
                    anchors {
                        top: parent.top
                        right: parent.right
                    }
                }
            }
        }
        Item {
            id: innerBorder
            anchors.fill: parent

            Rectangle {
                anchors {
                    left: parent.left
                    right: parent.right
                }
                height: 1
                y: top.height - 1
                visible: decoration.maximized
                color: colorHelper.shade(options.titleBarColor, ColorHelper.MidShade)
                //color: "#356cb7"
            }

            Rectangle {
                anchors {
                    fill: parent
                    leftMargin: root.borders.left - 1
                    rightMargin: root.borders.right
                    topMargin: root.borders.top - 1
                    bottomMargin: root.borders.bottom
                }
                border {
                    width: 1
                    color: colorHelper.shade(options.titleBarColor, ColorHelper.MidShade)
                    //color: "#356cb7"
                }
                visible: !decoration.maximized
                //color: "white"
                color: options.titleBarColor
            }
        }
    }
    Component {
        id: minimizeButtonComponent
        Button {
            width: root.buttonSize / 4.0 * 5.0
            height: root.buttonSize
            image: "imgs/minimize.svg"
            imageHover: "imgs/minimize_hover.svg"
            buttonType: "I"
        }
    }
    Component {
        id: maximizeButtonComponent
        Button {
            width: root.buttonSize / 4.0 * 5.0
            height: root.buttonSize
            image: !decoration.maximized ? "imgs/maximize.svg" : "imgs/restore.svg"
            imageHover: !decoration.maximized ? "imgs/maximize_hover.svg" : "imgs/restore_hover.svg"
            buttonType: "A"
        }
    }
    Component {
        id: closeButtonComponent
        Rectangle {
            id: closeButtonRect
            color: "#c75050"
            width: root.buttonSize / 4.0 * 9.0
            height: root.buttonSize
            Behavior on color {
                ColorAnimation { from: "#e04343"; duration: 500 }
            }            
            Image {
                x: parent.width / 2 - width / 2
                y: parent.height / 2 - height / 2
                source: "imgs/close.svg"
                width: parent.height / 2
                height: parent.height / 2
                sourceSize.width: width
                sourceSize.height: height
                smooth: false
            }
            DecorationButton {
                id: button
                function colorize() {
                    closeButtonRect.color = button.hovered ? "#e04343" : "#c75050";
                }
                buttonType: "X"
                anchors.fill: parent
                onHoveredChanged: colorize()
            }
        }
    }
    Component {
        id: menuButtonComponent
        Item {
            height: root.topHeight
            width: root.buttonSize
            MenuButton {
                width: root.buttonSize
                height: root.buttonSize
                anchors {
                    /*topMargin: titleRow.normalHeight - root.buttonSize*/
                    bottom: parent.bottom
                    bottomMargin: (root.topHeight - root.buttonSize) / 2
                }
            }
        }
    }
    Component.onCompleted: {
        borders.setBorders(8);
        borders.setTitle(31);
        maximizedBorders.setTitle(23);
        root.titleAlignment = Text.AlignHCenter;
    }
}
