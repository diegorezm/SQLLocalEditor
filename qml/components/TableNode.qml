import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Effects
import SQLLocalEditor

Item {
    id: root
    property string tableName: "DefaultTable"
    property var columns: []
    property int tableIndex: -1

    implicitWidth: 240
    implicitHeight: header.height + columnList.contentHeight + addColumnRow.height + 24

    DragHandler {
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
        border.color: Theme.nodeBorder
        border.width: 1
        clip: true

        MouseArea {
            anchors.fill: parent
            cursorShape: pressed ? Qt.ClosedHandCursor : Qt.OpenHandCursor
            onPressed: root.z = 100
            onReleased: root.z = 1
        }

        // header
        Rectangle {
            id: header
            width: parent.width
            height: 42
            color: Theme.nodeHeader
            radius: Theme.radiusMd

            Rectangle {
                anchors.bottom: parent.bottom
                width: parent.width
                height: 1
                color: Theme.nodeBorder
            }

            // editable table name
            TextInput {
                id: nameInput
                anchors.centerIn: parent
                text: root.tableName
                color: Theme.accent
                font.family: Theme.fontMono
                font.pixelSize: 13
                font.bold: true
                horizontalAlignment: TextInput.AlignHCenter
                selectByMouse: true

                onEditingFinished: {
                    if (text.trim() !== "")
                        schemaModel.renameTable(root.tableIndex, text.trim());
                }
            }
        }

        // columns
        ListView {
            id: columnList
            anchors.top: header.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.topMargin: 4
            height: contentHeight
            model: root.columns
            interactive: false

            delegate: Item {
                width: columnList.width
                height: 32

                // hover background
                Rectangle {
                    anchors.fill: parent
                    color: Theme.muted
                    opacity: rowHover.containsMouse ? 1 : 0
                    Behavior on opacity {
                        NumberAnimation {
                            duration: 100
                        }
                    }
                }

                HoverHandler {
                    id: rowHover
                }

                Row {
                    anchors.fill: parent
                    anchors.leftMargin: 10
                    anchors.rightMargin: 10
                    spacing: 6

                    // pk dot
                    Rectangle {
                        width: 6
                        height: 6
                        radius: 3
                        color: modelData.primaryKey ? Theme.accent : Theme.port
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    // editable column name
                    TextInput {
                        width: 100
                        text: modelData.name
                        color: modelData.primaryKey ? Theme.accentSoft : Theme.textPrimary
                        font.family: Theme.fontMono
                        font.pixelSize: 12
                        selectByMouse: true
                        anchors.verticalCenter: parent.verticalCenter

                        onEditingFinished: {
                            schemaModel.renameColumn(root.tableIndex, index, text.trim());
                        }
                    }

                    // type selector
                    ComboBox {
                        id: typeCombo
                        width: 90
                        anchors.verticalCenter: parent.verticalCenter
                        model: ["INTEGER", "FLOAT", "TEXT", "BOOLEAN", "DATE", "DATETIME", "BLOB"]
                        currentIndex: modelData.type
                        font.family: Theme.fontMono
                        font.pixelSize: 11

                        onActivated: {
                            schemaModel.setColumnType(root.tableIndex, index, currentIndex);
                        }

                        contentItem: Text {
                            text: typeCombo.displayText
                            color: Theme.textDisabled
                            font: typeCombo.font
                            verticalAlignment: Text.AlignVCenter
                            leftPadding: 6
                        }

                        background: Rectangle {
                            color: Theme.overlay
                            radius: Theme.radiusSm
                            border.color: Theme.nodeBorder
                            border.width: 1
                        }
                    }

                    // remove column button
                    Text {
                        text: "✕"
                        color: Theme.error
                        font.pixelSize: 11
                        anchors.verticalCenter: parent.verticalCenter
                        opacity: rowHover.containsMouse ? 1 : 0
                        Behavior on opacity {
                            NumberAnimation {
                                duration: 100
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: schemaModel.removeColumn(root.tableIndex, index)
                        }
                    }
                }
            }
        }

        // add column row
        Item {
            id: addColumnRow
            anchors.top: columnList.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            height: 32

            Rectangle {
                anchors.top: parent.top
                width: parent.width
                height: 1
                color: Theme.nodeBorder
            }

            Text {
                anchors.centerIn: parent
                text: "+ add column"
                color: Theme.textDisabled
                font.family: Theme.fontMono
                font.pixelSize: 11

                Behavior on color {
                    ColorAnimation {
                        duration: 100
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    hoverEnabled: true
                    onEntered: parent.color = Theme.accent
                    onExited: parent.color = Theme.textDisabled
                    onClicked: schemaModel.addColumn(root.tableIndex, "column", 2)
                }
            }
        }
    }
}
