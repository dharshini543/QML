import QtQuick 2.15

ListView {
    id: listView
    width: parent.width
    height: 30 * count
    visible: false
    model: Country
    interactive: true
    clip: true
    anchors.top: comboBox.top
    anchors.topMargin: 0
    delegate: {

    }
}
