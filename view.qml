/****************************************************************************
**
** Copyright (C) 2019 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the examples of Qt for Python.
**
** $QT_BEGIN_LICENSE:BSD$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** BSD License Usage
** Alternatively, you may use this file under the terms of the BSD license
** as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.0
import QtQuick.Layouts 1.3


ApplicationWindow {
    id: app_window
    width: 640
    height: 488
    visible: true
    Page {
        width: app_window.width
        height: app_window.height

        header: Label {
            color: "#000000"
            text: qsTr("LED Controller")
            font.bold: true
            font.pointSize: 20
            font.family: "Arial"
            renderType: Text.NativeRendering
            horizontalAlignment: Text.AlignHCenter
            padding: 10
        }
        Rectangle {
            id: root
            width: parent.width
            height: parent.height
            color: "#ffffff"

            ColumnLayout {
                id: columnLayout
                Layout.minimumWidth: columnLayout.width
                anchors.rightMargin: 50
                anchors.leftMargin: 50
                anchors.bottomMargin: 50
                anchors.fill: parent
                spacing: 20

                Button {
                    id: set_button
                    text: qsTr("Set Colour")
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    onClicked: {
                        let colour_str = (colour_rect.color.toString() + Math.floor(dial_w.value).toString(16).padStart(2, "0")).slice(1)
                        console.log("Setting colour to:", colour_str)
                        con.setLEDStatic(colour_str)
                    }
                }

                RowLayout {
                    id: row_rgb
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Layout.columnSpan: 4
                    Layout.minimumWidth: columnLayout.width
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    spacing: 0

                    ColumnLayout {
                        id: columnLayout1
                        width: 100
                        height: 100

                        Dial {
                            id: dial_r
                            value: 1
                            Layout.maximumHeight: 100
                            Layout.maximumWidth: 100
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            onValueChanged: {
                                colour_rect.color.r = value
                            }
                        }

                        Label {
                            text: qsTr("Red")
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        }
                    }

                    ColumnLayout {
                        id: columnLayout2
                        width: 100
                        height: 100
                        Dial {
                            id: dial_g
                            Layout.maximumHeight: 100
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            Layout.maximumWidth: 100
                            onValueChanged: {
                                colour_rect.color.g = value
                            }
                        }

                        Label {
                            text: qsTr("Green")
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        }
                    }

                    ColumnLayout {
                        id: columnLayout3
                        width: 100
                        height: 100
                        Dial {
                            id: dial_b
                            Layout.maximumHeight: 100
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            Layout.maximumWidth: 100
                            onValueChanged: {
                                colour_rect.color.b = value
                            }
                        }

                        Label {
                            text: qsTr("Blue")
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        }
                    }

                    ColumnLayout {
                        id: columnLayout4
                        width: 100
                        height: 100
                        Dial {
                            id: dial_w
                            to: 255
                            stepSize: 1
                            Layout.maximumHeight: 100
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            Layout.maximumWidth: 100
                        }

                        Label {
                            text: qsTr("White")
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        }
                    }




                }

                RowLayout {
                    id: row_hsv
                    Layout.fillWidth: true
                    Layout.columnSpan: 4
                    spacing: 0
                    Layout.fillHeight: true
                    ColumnLayout {
                        id: columnLayout5
                        width: 100
                        height: 100
                        Dial {
                            id: dial_h
                            Layout.maximumHeight: 100
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            Layout.maximumWidth: 100
                            onValueChanged: {
                                colour_rect.color.hsvHue = value
                            }
                        }

                        Label {
                            text: qsTr("Hue")
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        }
                    }

                    ColumnLayout {
                        id: columnLayout6
                        width: 100
                        height: 100
                        Dial {
                            id: dial_s
                            value: 1
                            Layout.maximumHeight: 100
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            Layout.maximumWidth: 100
                            onValueChanged: {
                                colour_rect.color.hsvSaturation = value
                            }
                        }

                        Label {
                            text: qsTr("Saturation")
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        }
                    }

                    ColumnLayout {
                        id: columnLayout7
                        width: 100
                        height: 100
                        Dial {
                            id: dial_v
                            value: 1
                            Layout.maximumHeight: 100
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            Layout.maximumWidth: 100
                            onValueChanged: {
                                colour_rect.color.hsvValue = value
                            }
                        }

                        Label {
                            text: qsTr("Value")
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        }
                    }
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Layout.minimumWidth: columnLayout.width
                }

                RowLayout {
                    id: row_colour
                    Layout.fillWidth: true
                    Layout.columnSpan: 4
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    spacing: 0
                    Layout.minimumWidth: columnLayout.width
                    Layout.fillHeight: true

                    Rectangle {
                        id: colour_rect
                        width: 200
                        height: 200
                        color: "#ff0000"
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        onColorChanged: {
                            dial_r.value = color.r
                            dial_g.value = color.g
                            dial_b.value = color.b
                            dial_h.value = color.hsvHue
                            dial_s.value = color.hsvSaturation
                            dial_v.value = color.hsvValue
                        }
                    }
                }

            }

        }
    }
}







