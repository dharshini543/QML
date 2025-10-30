// import QtQuick 2.15

// Rectangle {
//     width: parent.width
//     height: 30
//     color: ListView.isCurrentItem ? "teal" : "black"
//     Row
//     {
//         spacing :8
//         Rectangle {
//             id: rect1
//             width: 25
//             height: 25
//             color: "White"

//             Image {
//                 width: 15
//                 height: 15
//                 anchors.centerIn: parent
//                 source: "Downloads/check-mark.png"
//                 visible: checkstate
//             }
//             MouseArea {
//                 id: checkboxMouseArea
//                 width:parent.width
//                 height:parent.height
//                 onClicked:
//                 {

//                     checkstate = !checkstate
//                 }
//             }

//         }
//         Text {
//             anchors.verticalCenter: parent.verticalCenter
//             leftPadding: 5
//             color: "white"
//             text: COUNTRYNAME
//             font.bold: currentText === COUNTRYNAME ? true: false
//             font.pixelSize: 18
//         }


//     }
//     Image {
//         anchors.right: parent.right
//         anchors.rightMargin: 5
//         width:30
//         height:30
//         source: COUNTRYFLAG
//         fillMode: Image.PreserveAspectFit
//     }

// }

import QtQuick 2.15

Rectangle {
    width: parent.width
    height: 30
    property bool isChecked: false

    color: ListView.isCurrentItem ? "teal" : "black"

    Row {
        spacing: 8
        Rectangle {
            width: 25
            height: 25
            color: "white"

            Image {
                width: 15
                height: 15
                anchors.centerIn: parent
                source: "Downloads/check-mark.png"
                visible: isChecked
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    isChecked = !isChecked
                }
            }
        }

        Text {
            anchors.verticalCenter: parent.verticalCenter
            color: "white"
            text: COUNTRYNAME
            font.pixelSize: 18
        }
    }

    Image {
        anchors.right: parent.right
        anchors.rightMargin: 5
        width: 30
        height: 30
        source: COUNTRYFLAG
        fillMode: Image.PreserveAspectFit
    }
}



// import QtQuick 2.15

// Rectangle {
//     width: parent.width
//     height: 35
//     color: "black"
//     property bool isChecked: false

//     Row {
//         spacing: 8
//         anchors.verticalCenter: parent.verticalCenter

//         Rectangle {
//             width: 25
//             height: 25
//             color: "white"
//             Image {
//                 width: 15
//                 height: 15
//                 anchors.centerIn: parent
//                 source: "Downloads/check-mark.png"
//                 visible: isChecked
//             }
//             MouseArea {
//                 anchors.fill: parent
//                 onClicked: isChecked = !isChecked
//             }
//         }

//         Text {
//             text: COUNTRYNAME
//             color: "white"
//             anchors.verticalCenter: parent.verticalCenter
//             font.pixelSize: 16
//         }

//         Image {
//             anchors.right: parent.right
//             anchors.rightMargin: 10
//             width: 30
//             height: 30
//             source: COUNTRYFLAG
//             fillMode: Image.PreserveAspectFit
//         }
//     }
// }
