import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle
{
    id: comboBox
    width: 200
    height: 30
    radius: 5
    anchors.left: parent.left
    anchors.top: parent.top
    anchors.margins: 50
    color: "black"

    property var customModel:[]
    property alias imageSource: arrow.source
    property alias imageWidth: arrow.width
    property alias imageHeight: arrow.height
    property alias textColor: selectedText.color
    property string defaultText: "Select Country"

    Text
    {
        id: selectedText
        text: comboBox.defaultText
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.verticalCenter: parent.verticalCenter
        color: "white"
        font.pixelSize: 18
    }

    Image {
        id: arrow
        width: 15
        height: 15
        anchors.right: parent.right
        anchors.rightMargin: 8
        anchors.verticalCenter: parent.verticalCenter
        source: "qrc:/Downloads/shape"
    }

    MouseArea {
        anchors.fill: parent
        onClicked:
        {
            listView.visible = !listView.visible
        }
    }

    MyListView{
        id:listView
        model: comboBox.customModel
        delegate: MyDelegate{

        }
    }

}
