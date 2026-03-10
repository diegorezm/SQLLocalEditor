import QtQuick
import QtQuick.Effects
import SQLLocalEditor

Item {
    id: root
    property string tableName: "DefaultTable"
    implicitWidth: 220
    implicitHeight: 160

    DragHandler {
        id: dragHandler
        target: root
    }

    MultiEffect {
        source: nodeRect
        anchors.fill: nodeRect
        shadowEnabled: true
        shadowBlur: 1.0
        shadowVerticalOffset: 4
        shadowColor: "black"
        opacity: 0.6
    }

    Rectangle {
        id: nodeRect
        anchors.fill: parent
        radius: Theme.radiusMd
        color: Theme.nodeBg

        MouseArea {
            anchors.fill: parent
            cursorShape: pressed ? Qt.ClosedHandCursor : Qt.OpenHandCursor
            onPressed: root.z = 100
            onReleased: root.z = 1
        }

        Rectangle {
            id: header
            width: parent.width
            height: 38
            radius: Theme.radiusMd
            color: Theme.nodeHeader

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
}
