import QtQuick
import SQLLocalEditor

Rectangle {
    id: fab
    anchors.bottom: parent.bottom
    anchors.right: parent.right
    anchors.margins: 24
    width: 44
    height: 44
    radius: 22
    color: fabHover.containsMouse ? Theme.accentSoft : Theme.accent

    Behavior on color {
        ColorAnimation {
            duration: 150
        }
    }

    Text {
        anchors.centerIn: parent
        text: "+"
        color: Theme.base
        font.pixelSize: 22
        font.bold: true
        font.family: Theme.fontMono
    }

    HoverHandler {
        id: fabHover
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            let cx = (parent.parent.width / 2) - 110 + (tableCount * 20);
            let cy = (parent.parent.height / 2) - 80 + (tableCount * 20);
            schemaModel.addTable("new_table", cx, cy);
            tableCount++;
        }
    }
}
