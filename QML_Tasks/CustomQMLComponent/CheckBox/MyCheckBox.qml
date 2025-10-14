import QtQuick 2.15

Row{

spacing: 30

property bool check: false
property  alias  text: text.text
Rectangle
{
    width: 50
    height: 40
    color: "blue"

    Image {
        id: image
        width: 20
        height: 20
        anchors.centerIn: parent
        source: "qrc:/Downloads/check-mark.png"
        visible: check
    }
    MouseArea{
        anchors.fill: parent
        onClicked: {
            check = !check
        }
    }
}
Text {
    id: text
    text: qsTr("text")
}
}
