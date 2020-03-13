import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.0
import QtQuick.Layouts 1.3


ApplicationWindow {
    id: app_window
    width: 640
    height: 488
    color: "#ffffff"
    title: "LED Controller"
    visible: true

    Timer {
        id: timer
        function setTimeout(cb, delayTime) {
            timer.interval = delayTime;
            timer.repeat = false;
            timer.triggered.connect(cb);
            timer.triggered.connect(function release () {
                timer.triggered.disconnect(cb);
                timer.triggered.disconnect(release);
            });
            timer.start();
        }
    }

    function setLEDState(st) {
        let colour = Qt.rgba(colour_rect.color.r, colour_rect.color.g, colour_rect.color.b, colour_rect.color.a)
        colour.hsvValue = colour.hsvValue * dial_mult.value
        const colour_str = (colour.toString() + Math.floor(dial_w.value).toString(16).padStart(2, "0")).slice(1)
        console.log("Setting colour to:", colour_str)
        const res_code = con.setLEDState(st, colour_str)
        let msg = "Success"
        if (res_code !== 200) {
            msg = "Error " + res_code.toString()
        }
        console.log(msg)
        window_title.text = msg
        timer.setTimeout(function(){
            window_title.text = qsTr("LED Controller")
        }, 1000)
    }

    Page {
        width: app_window.width
        height: app_window.height

        header: Label {
            id: window_title
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
                clip: false
                Layout.minimumWidth: columnLayout.width
                anchors.rightMargin: 50
                anchors.leftMargin: 50
                anchors.bottomMargin: 50
                anchors.fill: parent
                spacing: 20

                RowLayout {
                    id: rowLayout
                    width: 100
                    height: 100
                    spacing: 20
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                    Button {
                        id: static_button
                        text: qsTr("Static")
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        onClicked: {
                            setLEDState(1)
                        }
                    }

                    Button {
                        id: notify_button
                        text: qsTr("Notify")
                        onClicked: {
                            setLEDState(4)
                        }
                    }

                    Button {
                        id: rainbow_button
                        text: qsTr("Rainbow")
                        onClicked: {
                            setLEDState(2)
                        }
                    }

                    Button {
                        id: fade_button
                        text: qsTr("Fade")
                        onClicked: {
                            setLEDState(3)
                        }
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
                            wheelEnabled: true
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
                            wheelEnabled: true
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
                            wheelEnabled: true
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
                            wheelEnabled: true
                            to: 128
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
                            wheelEnabled: true
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
                            wheelEnabled: true
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
                            wheelEnabled: true
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

                    ColumnLayout {
                        id: columnLayout8
                        width: 100
                        height: 100
                        Dial {
                            id: dial_mult
                            wheelEnabled: true
                            value: 0.1
                            Layout.maximumWidth: 100
                            Layout.maximumHeight: 100
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        }

                        Label {
                            text: qsTr("Multiplier")
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        }
                    }
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Layout.minimumWidth: columnLayout.width
                }

            }

            Rectangle {
                id: colour_rect
                x: 560
                width: 60
                height: app_window.height
                color: "#ff0000"
                clip: true
                anchors.top: parent.top
                anchors.topMargin: -52
                anchors.right: parent.right
                anchors.rightMargin: 0
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









