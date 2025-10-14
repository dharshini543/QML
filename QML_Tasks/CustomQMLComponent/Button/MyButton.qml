import QtQuick 2.15

Rectangle
{
    id:button
    width:120
    height:30
    radius :5
    color:  "grey"
    border.color: "#353839"

    signal clicked()
    signal doubleClicked()
    signal positionChanged()
    signal pressAndHold()
    signal pressed()
    signal released()
    signal wheel()

    property alias buttonText : text.text
    property alias textColor : text.color
    property alias textFontBold : text.font.bold
    property alias textFontFamily : text.font.family

    Text
    {
        id:text
        text: "Button"
        color: "white"
        font.bold: false
        font.family:  "Arial"
        anchors.centerIn: parent
    }

    MouseArea
    {
        id:onClickedMouseArea
        anchors.fill: button
        onClicked:
        {
            button.clicked()
        }
        onDoubleClicked:
        {
            button.doubleClicked()

        }
        onPositionChanged:
        {
            button.positionChanged()
        }
        onPressAndHold:
        {
            button.pressAndHold()
        }
        onPressed:
        {
            button.pressed()
        }
        onReleased:
        {
            button.released()
        }
        onWheel:
        {
            button.wheel()
        }
    }

}
