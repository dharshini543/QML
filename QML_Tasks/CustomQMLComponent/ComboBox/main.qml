import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    width: 640
    height: 600
    visible: true
    title: qsTr("Hello World")

    MyComboBox{
        color: "lightBlue"
        defaultText:"Country"
        textColor: "black"
        imageWidth: 15
        imageHeight: 15
        imageSource:"qrc:/Downloads/greenRect"
        customModel: Country
    }
}
