import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    id:root
    width: 600
    height: 600
    visible: true
    title: qsTr("Hello World")

    Rectangle{
        id:r1
        x:75
        width: 100
        height: 100
        color: "red"
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
    }
    Rectangle{
        id:r2
        width: r1.width
        height: r1.height
        color: "blue"
        anchors.left: r1.right
        anchors.verticalCenter: parent.verticalCenter
    }
    // if (r1.width changed())
    // {
    //     r2.width = r1.width;
    // }

    Rectangle{
        id:r3
        width: r2.width
        height: r2.width
        color: "yellow"
        anchors.left: r2.right
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.verticalCenter: parent.verticalCenter
    }
}
