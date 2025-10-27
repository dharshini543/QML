import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: outerRect
    width: 40
    height: 40
    radius: 20
    color: "white"
    border.color: "black"

    Rectangle
    {
        id: innerRect
        width: 24
        height: 24
        radius: 12
        anchors.centerIn: parent
        color: "black"
        visible: false
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            innerRect.visible = !innerRect.visible
        }
    }
}



