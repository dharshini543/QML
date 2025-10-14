import QtQuick 2.15
import QtQuick.Controls

Rectangle {
    id: root
    anchors.fill: parent
    color: "#1e1e1e"

    Text {
        id: header
        text: qsTr("Visible Networks")
        font.bold: true
        font.pixelSize: 22
        color: "#ffffff"
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.top: parent.top
        anchors.topMargin: 20
    }

    ListView {
        id: wifiList
        anchors.top: header.bottom
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 10
        spacing: 8
        clip: true
        model: WiFiModel
        delegate: myComponent
    }

    Component
    {
        id: myComponent

        Rectangle
        {
            id: wifi
            width: wifiList.width
            height: wifiList.height / 12
            radius: 10
            border.color: "#3a3a3a"
            color: {
                if (mouseArea.containsMouse)
                    return "#2d2d2d";
                else
                    return "#252526";
            }

            Text {
                id: wifiStatus
                text: WiFiStatus
                anchors.right: parent.right
                anchors.rightMargin: 20
                anchors.verticalCenter: parent.verticalCenter
                color: "#a0a0a0"
                font.pixelSize: 14
            }
            Row
            {
                id: row
                spacing: 30
                anchors.fill: parent
                anchors.margins: 15

                Image {
                    id: wifiImage
                    width: 26
                    height: 26
                    anchors.verticalCenter: parent.verticalCenter
                    source: {
                        if(SignalStrength == 0)
                            return "qrc:/Downloads/WiFiRange0.png"
                        else if (SignalStrength <= 25)
                            return "qrc:/Downloads/WiFiRange25.png"
                        else if (SignalStrength <= 50)
                            return "qrc:/Downloads/WiFiRange50.png"
                        else if (SignalStrength <= 75)
                            return "qrc:/Downloads/WiFiRange75.png"
                        else
                            return "qrc:/Downloads/WiFiRange100.png"
                    }
                }

                Text {
                    id: wifiName
                    text: WiFiName
                    anchors.verticalCenter: parent.verticalCenter
                    color: "#ffffff"
                    font.pixelSize: 16
                }
            }

            MouseArea
            {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    if (WiFiStatus === "connected")
                    {
                        wifi.enabled = false
                    }
                    else if (WiFiStatus === "saved")
                    {
                        var Ok = WiFiModel.connectToNetwork(WiFiName, WiFiPassword)
                        if (Ok)
                            console.log("WiFi connected successfully")
                        else
                            console.log("Incorrect Password")
                    }
                    else
                    {
                        myPopup.open()
                    }
                }
            }

            Popup {
                id: myPopup
                modal: true
                focus: true
                closePolicy: Popup.NoAutoClose
                width: 400
                height: 230
                anchors.centerIn: Overlay.overlay

                Rectangle
                {
                    anchors.fill: parent
                    color: "#2b2b2b"
                    radius: 8
                    border.color: "#3a3a3a"

                    Column {
                        spacing: 20
                        anchors.centerIn: parent

                        Text {
                            text: qsTr("Authentication required")
                            font.pixelSize: 18
                            color: "#ffffff"
                        }

                        Text {
                            text: qsTr("Password or key required for network: ") + WiFiName
                            font.pixelSize: 14
                            color: "#a0a0a0"
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        TextField {
                            id: passwordEdit
                            width: 300
                            height: 32
                            placeholderText: "Password"
                            color: "#ffffff"
                        }

                        Row {
                            spacing: 10
                            anchors.horizontalCenter: parent.horizontalCenter

                            Button {
                                id: cancelBtn
                                width: 140
                                text: "Cancel"
                                onClicked: myPopup.close()
                            }

                            Button {
                                id: connectBtn
                                width: 140
                                text: "Connect"
                                onClicked: {
                                    var Ok = WiFiModel.connectToNetwork(WiFiName, passwordEdit.text)
                                    if (Ok)
                                        console.log("WiFi connected successfully")
                                    else
                                        console.log("Incorrect Password")
                                    myPopup.close()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
