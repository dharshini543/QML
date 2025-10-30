import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle
{
    id: root
    color: "#1e1e1e"
    anchors.fill: parent

    signal backButtonClicked()
    // property alias searchFieldText:searchFieldEdit.text

    Row{
        width: parent.width
        height: 50
        spacing: 20
        anchors.top: parent.top
        anchors.topMargin: 15
        Rectangle
        {
            width: 35
            height: 35
            anchors.left: parent.left
            color: "#2d2d2d"
            radius: 20
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            border.color: "white"
            Text {
                id: backArrow
                text: qsTr("<<")
                color: "white"
                font.bold: true
                font.pixelSize: 15
                anchors.centerIn: parent
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    backButtonClicked()
                    WiFiModel.refreshModel()
                }
            }
        }
        Rectangle {
            id:searchField
            width: parent.width - 100
            height: 50
            radius: 10
            color: "#2b2b2b"
            anchors.centerIn: parent

            TextField {
                id: searchFieldEdit
                anchors.fill: parent
                anchors.margins: 0
                placeholderText: "Search"
                color: "white"
                font.pixelSize: 18
                background: null
                onTextChanged: {
                    WiFiModel.filterByName(text)
                }
            }
        }
        Image {
            id: rotation
            width: 25
            height: 25
            anchors.verticalCenter: parent.verticalCenter
            source: "qrc:/Downloads/circular-arrows.png"
            anchors.right: parent.right
            anchors.rightMargin: 15

            NumberAnimation on rotation {
                id: imageRotation
                from: 0
                to: 360
                duration: 2500
                loops: Animation.Infinite
                running: true
            }
        }
    }

    ListView {
        id: filteredList
        anchors.top: parent.top
        anchors.topMargin: 75
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 10
        clip: true
        spacing: 8
        model: WiFiModel
        delegate: myComponent
    }
    Component
    {
        id: myComponent

        Rectangle
        {
            id: delegateRect
            width: filteredList.width
            height: 60
            radius: 10
            color: {
                if(WiFiStatus == "connected")
                {
                    wifiStatus.color = "#CBF3BB"
                    wifiStatus.font.bold = true
                    delegateRect.color = "#252526"
                    wifiImage.source = "qrc:/Downloads/WiFiRange100.png"
                }
                else
                    return "#252526"
            }
            border.color: "#3a3a3a"
            opacity: 0
            y: 20

            SequentialAnimation
            {
                running: true
                PauseAnimation { duration: Math.max(0, index * 500) }
                ParallelAnimation {
                    PropertyAnimation { target: delegateRect; property: "opacity"; from: 0; to: 1; duration: 250 }
                    PropertyAnimation { target: delegateRect; property: "y"; from: delegateRect.y + 20; to: delegateRect.y; duration: 250 }
                }
            }

            Row {
                id: row
                spacing: 20
                anchors.fill: parent
                anchors.margins: 15

                Image {
                    id: wifiImage
                    width: 26
                    height: 26
                    anchors.verticalCenter: parent.verticalCenter
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
                    anchors.verticalCenter: parent.verticalCenter
                    color: "#ffffff"
                    font.pixelSize: 16
                }
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

            Rectangle {
                id: swipeRectangle
                width: 160
                height: 40
                radius: 20
                anchors.centerIn: parent
                color: "transparent"
                visible: WiFiStatus !== "connected"
                z: 10

                Rectangle {
                    id: trackRect
                    anchors.fill: parent
                    radius: parent.radius
                    color: "#3A5FCD"
                    opacity: 0.3
                }

                Rectangle {
                    id: fillRect
                    width: handleRect.x + handleRect.width / 2
                    height: trackRect.height
                    radius: parent.radius
                    color: "#3A5FCD"
                }

                Rectangle {
                    id: handleRect
                    x: 0
                    width: 50
                    height: parent.height
                    radius: 15
                    color: "white"
                    border.color: "black"
                    z: 2

                    Text {
                        anchors.centerIn: parent
                        text: "→"
                        font.pixelSize: 18
                        color: "black"
                        font.bold: true
                    }

                    MouseArea {
                        id: handleMouse
                        anchors.fill: parent
                        drag.target: handleRect
                        drag.axis: Drag.XAxis
                        drag.minimumX: 0
                        drag.maximumX: swipeRectangle.width - handleRect.width
                        cursorShape: Qt.PointingHandCursor

                        onPositionChanged: {
                            fillRect.width = handleRect.x + handleRect.width / 2
                        }

                        onReleased: {
                            if (handleRect.x >= drag.maximumX - 5)
                            {
                                if (WiFiStatus === "connected")
                                {
                                    wifiImage.source = "qrc:/Downloads/WiFiRange100.png"
                                    wifi.enabled = false
                                }
                                else if (WiFiStatus === "saved")
                                {
                                    var ok = WiFiModel.connectToNetwork(WiFiName, WiFiPassword)
                                    if (ok)
                                    {
                                        console.log("WiFi connected successfully")
                                        // backButtonClicked()
                                        // searchFieldText = ""
                                    }
                                    else
                                    {
                                        console.log("Incorrect Password")
                                    }
                                }
                                else
                                {
                                    myPopup.open()
                                }
                            }
                            resetAnim.start()
                        }
                    }
                }

                PropertyAnimation {
                    id: resetAnim
                    target: handleRect
                    property: "x"
                    to: 0
                    duration: 300
                    easing.type: Easing.OutQuad
                    onRunningChanged: fillRect.width = handleRect.x + handleRect.width / 2
                }
            }

            MyPopup {
                id: myPopup
                // onConnectedSuccessfully:{
                //     searchFieldText : ""
                // }
            }
        }
    }
}





























