import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls

Window {
    width: 500
    height: 800
    visible: true
    title: qsTr("WiFi")

    Loader
    {
        anchors.fill: parent
        source: "WiFi.qml"
    }


}
