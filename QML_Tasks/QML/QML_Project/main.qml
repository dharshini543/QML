import QtQuick 2.15
import QtQuick.Window 2.15

Window
{
    id:root
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")
    x:200

    Rectangle{
        id: r1
        x:200;
        width: 400;
        height: 400;
        color: "blue"
        Rectangle{
            id:r2
            width: r1.width/3;
            height: r1.height/3;
            color: "green"
        }
        Rectangle{
            id:r3
            width: r2.width;
            height: r2.height;
            color: "yellow"
        }
    }
}
