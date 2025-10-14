import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: rect1
    width: 200
    height: 40
    color: "black"
    border.color: "black"
    border.width: 1
    anchors.centerIn: parent

    property alias backgroundColor: rect1.color
    property alias textColor: textInput.color
    property alias placeholderColor: placeholder.color
    property alias placeholderText: placeholder.text

    TextInput {
        id: textInput
        anchors.fill: parent
        anchors.margins: 8
        color: "white"
        font.pointSize: 13
        focus: false
        clip:true

        MouseArea {
            anchors.fill: parent
            onClicked: {
                textInput.focus = true
                rect1.border.color = "orange"
            }
        }
    }

    Text {
        id: placeholder
        text: "Enter text..."
        color: "#888"
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 8
        visible: textInput.text.length === 0
        font.pointSize: 13
    }

}

