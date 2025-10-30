import QtQuick 2.15

Rectangle {
    width: parent.width
    height: 35
    color: "black"

    signal selectAllChanged(bool checked)
    property bool checked: false

    Row {
        spacing: 8
        anchors.verticalCenter: parent.verticalCenter
        Rectangle {
            width: 25
            height: 25
            color: "white"
            Image {
                width: 15
                height: 15
                anchors.centerIn: parent
                source: "Downloads/check-mark.png"
                visible: checked
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    checked = !checked
                    selectAllChanged(checked)
                }
            }
        }

        Text {
            text: "Select All"
            color: "white"
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 16
        }
    }
}
