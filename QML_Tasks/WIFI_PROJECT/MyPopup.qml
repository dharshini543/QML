import QtQuick 2.15
import QtQuick.Controls

Popup {
    id: myPopup
    modal: true
    focus: true
    closePolicy: Popup.NoAutoClose
    width: 400
    height: 230
    anchors.centerIn: Overlay.overlay

    signal connectedSuccessfully()

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
                color: "white"

                property bool showPassword: false
                echoMode: passwordEdit.showPassword ? TextInput.Normal : TextInput.Password
                rightPadding: 20

                Rectangle {
                    id: eyeiconContainer
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    width: 28
                    height: 28
                    color: "transparent"

                    Image {
                        id: eyeIcon
                        anchors.centerIn: parent
                        width: 20
                        height: 20
                        source: passwordEdit.showPassword
                                ? "qrc:/Downloads/eye_open.png"
                                : "qrc:/Downloads/eye_closed.png"

                        MouseArea {
                            anchors.fill: parent
                            onClicked:
                            {
                                passwordEdit.showPassword = !passwordEdit.showPassword
                            }
                        }
                    }
                }
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
                        {
                            console.log("WiFi connected successfully")
                            connectedSuccessfully()
                        }
                        else
                            console.log("Incorrect Password")
                        myPopup.close()
                    }
                }
            }
        }
    }
}
