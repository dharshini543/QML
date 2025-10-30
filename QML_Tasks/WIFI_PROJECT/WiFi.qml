// import QtQuick 2.15
// import QtQuick.Controls

// Rectangle {
//     id: root
//     anchors.fill: parent
//     color: "#1e1e1e"

//     signal searchIconClicked()

//     Text {
//         id: header
//         text: qsTr("Visible Networks")
//         font.bold: true
//         font.pixelSize: 22
//         color: "#ffffff"
//         anchors.left: parent.left
//         anchors.leftMargin: 20
//         anchors.top: parent.top
//         anchors.topMargin: 20
//     }
//     Rectangle{
//         width: 20
//         height: 20
//         color: "transparent"
//         anchors.right: parent.right
//         anchors.rightMargin: 20
//         anchors.top: parent.top
//         anchors.topMargin: 20
//         Image {
//             id: searchImage
//             anchors.fill: parent
//             anchors.centerIn: parent
//             source: "qrc:/Downloads/search"
//         }
//         MouseArea{
//             anchors.fill: parent
//             onClicked: {
//                 searchIconClicked()
//             }
//         }
//     }

//     ListView {
//         id: wifiList
//         anchors.top: header.bottom
//         anchors.topMargin: 10
//         anchors.left: parent.left
//         anchors.right: parent.right
//         anchors.bottom: parent.bottom
//         anchors.margins: 10
//         spacing: 8
//         clip: true
//         model: WiFiModel
//         delegate: myComponent
//     }

//     Component
//     {
//         id: myComponent

//         Rectangle
//         {
//             id: wifiNetwork
//             width: wifiList.width
//             height: wifiList.height / 12
//             radius: 10
//             border.color: "#3a3a3a"
//             color: {
//                 if(WiFiStatus == "connected")
//                 {
//                     wifiStatus.color = "orange"
//                     wifiName.font.bold = true
//                     wifiStatus.font.bold = true
//                     wifiImage.source = "qrc:/Downloads/WiFiRange100.png"
//                 }
//                 else if (mouseArea.containsMouse)
//                     return "#2d2d2d";
//                 else
//                     return "#252526";
//             }

//             Text {
//                 id: wifiStatus
//                 text: WiFiStatus
//                 anchors.right: parent.right
//                 anchors.rightMargin: 20
//                 anchors.verticalCenter: parent.verticalCenter
//                 color: "#a0a0a0"
//                 font.pixelSize: 14
//             }

//             Row
//             {
//                 id: row
//                 spacing: 30
//                 anchors.fill: parent
//                 anchors.margins: 15

//                 Image
//                 {
//                     id: wifiImage
//                     width: 26
//                     height: 26
//                     anchors.verticalCenter: parent.verticalCenter
//                     source: {
//                         if(SignalStrength == 0)
//                             return "qrc:/Downloads/WiFiRange0.png"
//                         else if (SignalStrength <= 25)
//                             return "qrc:/Downloads/WiFiRange25.png"
//                         else if (SignalStrength <= 50)
//                             return "qrc:/Downloads/WiFiRange50.png"
//                         else if (SignalStrength <= 75)
//                             return "qrc:/Downloads/WiFiRange75.png"
//                         else
//                             return "qrc:/Downloads/WiFiRange100.png"
//                     }
//                 }

//                 Text {
//                     id: wifiName
//                     text: WiFiName
//                     anchors.verticalCenter: parent.verticalCenter
//                     color: "#ffffff"
//                     font.pixelSize: 16
//                 }
//             }

//             MouseArea
//             {
//                 id: mouseArea
//                 anchors.fill: parent
//                 hoverEnabled: true
//                 onClicked: {
//                     if (WiFiStatus === "connected")
//                     {
//                         wifiNetwork.enabled = false
//                     }
//                     else if (WiFiStatus === "saved")
//                     {
//                         var Ok = WiFiModel.connectToNetwork(WiFiName, WiFiPassword)
//                         if (Ok)
//                             console.log("WiFi connected successfully")
//                         else
//                             console.log("Incorrect Password")
//                     }
//                     else
//                     {
//                         myPopup.open()
//                     }
//                 }
//             }

//             MyPopup{
//                 id:myPopup
//             }
//         }
//     }
// }


































import QtQuick 2.15
import QtQuick.Controls

Rectangle {
    id: root
    anchors.fill: parent
    color: "#1e1e1e"

    signal searchIconClicked()

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
    Rectangle{
        width: 20
        height: 20
        color: "transparent"
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.top: parent.top
        anchors.topMargin: 20
        Image {
            id: searchImage
            anchors.fill: parent
            anchors.centerIn: parent
            source: "qrc:/Downloads/search"
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                searchIconClicked()
            }
        }
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
            id: wifiNetwork
            width: wifiList.width
            height: wifiList.height / 12
            radius: 10
            border.color: "#3a3a3a"
            color: {
                if (WiFiStatus == "connected") {
                    wifiStatus.color = "orange"
                    wifiName.font.bold = true
                    wifiStatus.font.bold = true
                    wifiImage.source = "qrc:/Downloads/WiFiRange100.png"
                } else if (mouseArea.containsMouse)
                    return "#2d2d2d";
                else
                    return "#252526";
            }

            Row {
                id: leftRow
                spacing: 15
                anchors.left: parent.left
                anchors.leftMargin: 15
                anchors.verticalCenter: parent.verticalCenter

                Image {
                    id: wifiImage
                    width: 26
                    height: 26
                    source: {
                        if (SignalStrength == 0)
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
                    color: "#ffffff"
                    font.pixelSize: 16
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }
            }

            Row {
                id: rightRow
                spacing: 20
                anchors.right: parent.right
                anchors.rightMargin: 15
                anchors.verticalCenter: parent.verticalCenter

                Text {
                    id: wifiStatus
                    text: WiFiStatus
                    color: "#a0a0a0"
                    font.pixelSize: 14
                    verticalAlignment: Text.AlignVCenter
                }

                Image {
                    id: lockImage
                    width: 22
                    height: 22
                    anchors.verticalCenter: parent.verticalCenter
                    source: WiFiStatus === "saved" ? "qrc:/Downloads/unlock.png"
                                                   : "qrc:/Downloads/locked.png"
                    visible: WiFiStatus !== "connected"
                }
            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    if (WiFiStatus === "connected") {
                        wifiNetwork.enabled = false
                    } else if (WiFiStatus === "saved") {
                        var ok = WiFiModel.connectToNetwork(WiFiName, WiFiPassword)
                        if (ok)
                            console.log("WiFi connected successfully")
                        else
                            console.log("Incorrect Password")
                    } else {
                        myPopup.open()
                    }
                }
            }

            MyPopup
            {
                id: myPopup
            }
        }

    }
}


