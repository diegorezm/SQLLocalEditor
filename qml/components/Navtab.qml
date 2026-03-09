import QtQuick
import SQLLocalEditor

Item {
    id: root
    property string label: ""
    property bool active: false

    width: text.width + 24
    height: 48

    // active indicator line at bottom
    Rectangle {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width - 8
        height: 2
        radius: 1
        color: Theme.accent
        opacity: root.active ? 1 : 0

        Behavior on opacity {
            NumberAnimation {
                duration: 150
            }
        }
    }

    Text {
        id: text
        anchors.centerIn: parent
        text: root.label
        color: root.active ? Theme.textPrimary : Theme.textSecondary
        font.family: Theme.fontMono
        font.pixelSize: 13

        Behavior on color {
            ColorAnimation {
                duration: 150
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: root.active = true

        onContainsMouseChanged: {
            if (!root.active)
                text.color = containsMouse ? Theme.textPrimary : Theme.textSecondary;
        }
    }
}
