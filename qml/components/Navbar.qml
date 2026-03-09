import QtQuick
import QtQuick.Controls.Basic
import SQLLocalEditor

Rectangle {
    id: root
    width: parent.width
    height: 48
    color: Theme.surface

    // bottom border line
    Rectangle {
        anchors.bottom: parent.bottom
        width: parent.width
        height: 1
        color: Theme.nodeBorder
    }

    Item {
        anchors.fill: parent
        anchors.leftMargin: 16
        anchors.rightMargin: 16

        // left — logo + project name
        Row {
            spacing: 10
            anchors.verticalCenter: parent.verticalCenter

            Rectangle {
                width: 24
                height: 24
                radius: 6
                color: Theme.accent
                anchors.verticalCenter: parent.verticalCenter

                Text {
                    text: "S"
                    color: Theme.base
                    font.bold: true
                    font.pixelSize: 13
                    font.family: Theme.fontMono
                    anchors.centerIn: parent
                }
            }

            Text {
                text: "SQLocalEditor"
                color: Theme.textPrimary
                font.family: Theme.fontMono
                font.pixelSize: 13
                font.bold: true
                anchors.verticalCenter: parent.verticalCenter
            }

            // divider
            Rectangle {
                width: 1
                height: 16
                color: Theme.nodeBorder
                anchors.verticalCenter: parent.verticalCenter
            }

            Text {
                text: "untitled.sql"
                color: Theme.textSecondary
                font.family: Theme.fontMono
                font.pixelSize: 12
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        // center — tabs
        Row {
            spacing: 2
            anchors.centerIn: parent

            Repeater {
                model: ["Schema", "Query", "Preview"]

                delegate: Navtab {
                    label: modelData
                    active: modelData === "Schema"
                }
            }
        }

        // right — actions
        Row {
            spacing: 8
            layoutDirection: Qt.RightToLeft
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter

            AppButton {
                variant: "default"
                label: "Export SQL"
            }

            // AppButton {
            //     variant: "outline"
            //     label: "Connect DB"
            // }
        }
    }
}
