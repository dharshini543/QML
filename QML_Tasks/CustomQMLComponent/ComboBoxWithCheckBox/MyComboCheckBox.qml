
import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: comboBox
    width: 250
    height: 30
    color: "black"
    radius: 5
    anchors.centerIn: parent
    property alias iconImageSource: iconImage.source
    property alias  iconImageWidth: iconImage.width
    property alias iconImageheight: iconImage.height

    property var customModel: []
    property string currentText: "Select Country"
    property alias comboBoxText : defaultText.text
    property alias comboTextColor : defaultText.color
    property alias comboFontPixelSize:  defaultText.font.pixelSize
    property bool checkstate: false

    Row
    {
        id:row
        spacing: 8


        Rectangle {
            visible: false

            id: rect1
            width: 25
            height: 25
            color: "white"

            Image {
               id: checkstateImage
                width: 15
                height: 15
                anchors.centerIn: parent
                source: "Downloads/check-mark.png"
                visible: checkstate
            }

            MouseArea {
                id: checkboxMouseArea
                width:parent.width
                height:parent.height
                onClicked:
                {

                    checkstate = !checkstate
                }
            }
        }
        Text {
            id: defaultText
            text: comboBox.currentText
            color: "white"
            anchors.verticalCenter: parent.verticalCenter
            leftPadding: 5
            font.pixelSize: 18
        }
        Image {
            id: flagImage
            anchors.verticalCenter: parent.verticalCenter
            width: 30
            height: 30
            source: ""
            fillMode: Image.PreserveAspectFit
        }

    }

    Image {
        id: iconImage
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin: 5
        width: 18
        height: 16
        source: "Downloads/DownwardArrow"
        fillMode: Image.PreserveAspectFit
    }

    MouseArea {
        anchors.fill: iconImage
        onClicked: {
            myListView.visible = true
        }
    }

    ListView {
        id: myListView
        width: parent.width
        height:600
        model: customModel
        visible: false
        anchors.top: parent.bottom
        clip: true
        delegate: myComponent
    }
    Component
    {
        id:myComponent
        MyDelegate
        {
            MouseArea {

                anchors.fill: parent
                onClicked: {
                    comboBox.currentText = COUNTRYNAME
                    flagImage.source = COUNTRYFLAG
                    myListView.visible = false
                    rect1.visible = true
                }
                hoverEnabled: true
                onEntered: parent.color = "teal"
                onExited: parent.color = "black"
            }
        }
    }
}


