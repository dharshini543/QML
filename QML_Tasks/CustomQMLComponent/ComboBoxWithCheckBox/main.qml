import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    width: 640
    height: 480
    visible: true
    color: "#222"
    title: "Country Selector"

    MyComboCheckBox {
        anchors.centerIn: parent
        customModel: Country
    }
}
