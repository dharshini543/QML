import QtQuick 2.15

Rectangle
{
    width: listView.width
    height: 30
    color: "black"

    Text {
        id:name
        text: CountryName
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        color: "white"
        font.pixelSize: 18
        font.bold: selectedText.text === text ? true: false
    }

    MouseArea
    {
        anchors.fill: parent
        onClicked: {
            comboBox.defaultText = CountryName
            listView.visible = false
        }
        hoverEnabled: true
        onEntered:
        {
            parent.color ="#EF7722"

        }
        onExited:
        {
            parent.color = "black"
        }
    }
}
