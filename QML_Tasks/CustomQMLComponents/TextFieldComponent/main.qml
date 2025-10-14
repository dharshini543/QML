import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    MyTextField
    {
        anchors.right: parent.right
        backgroundColor: "black"
        placeholderText: "Enter text...."
        placeholderColor: "#888"
        textColor: "white"
        radius: 10
    }
}
