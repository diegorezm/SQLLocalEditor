import QtQuick
import SQLLocalEditor

Rectangle {
    id: root

    property string tableName: "users"

    width: 220
    height: 160
    radius: Theme.radiusMd
    color: Theme.nodeBg
    border.color: Theme.nodeBorder
    border.width: 1

    // bring to front when clicked

    DragHandler {
        id: dragHandler
    }

    MouseArea {
        anchors.fill: parent
        onClicked: root.z = 1
        cursorShape: pressed ? Qt.ClosedHandCursor : Qt.OpenHandCursor
    }

    // header
    Rectangle {
        id: header
        width: parent.width
        height: 38
        radius: Theme.radiusMd
        color: Theme.nodeHeader

        // square off bottom corners
        Rectangle {
            anchors.bottom: parent.bottom
            width: parent.width
            height: Theme.radiusMd
            color: Theme.nodeHeader
        }

        Text {
            anchors.centerIn: parent
            text: root.tableName
            color: Theme.accent
            font.family: Theme.fontMono
            font.pixelSize: 13
            font.bold: true
        }
    }
}
