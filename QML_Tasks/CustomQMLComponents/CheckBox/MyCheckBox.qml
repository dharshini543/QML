import QtQuick 2.15

Rectangle
{
    width: 50
    height: 40
    color: "blue"

    property bool check: false

    Image {
        id: image
        width: 20
        height: 20
        anchors.centerIn: parent
        source: "qrc:/Downloads/check-mark.png"
        visible: check ? true: false
    }
    MouseArea{
        anchors.fill: parent
        onClicked: {
            check = !check
        }
    }
}
