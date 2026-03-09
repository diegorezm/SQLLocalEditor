import QtQuick
import "components"

Window {
    width: 1200
    height: 800
    visible: true
    title: qsTr("SQLLocalEditor")
    color: Theme.base

    Column {
        anchors.fill: parent
        Navbar {
            id: navbar
        }

        Item {
            width: parent.width
            height: parent.height - navbar.height
            CanvasGrid {}

            TableNode {
                x: 100
                y: 100
                tableName: "users"
            }

            TableNode {
                x: 400
                y: 200
                tableName: "orders"
            }
        }
    }
}
