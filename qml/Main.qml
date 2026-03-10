import QtQuick
import SQLLocalEditor
import "components"

Window {
    width: 1200
    height: 800
    visible: true
    title: qsTr("SQLLocalEditor")
    color: Theme.base
    property int tableCount: 0

    Column {
        anchors.fill: parent

        Navbar {
            id: navbar
        }

        Item {
            width: parent.width
            height: parent.height - navbar.height

            CanvasGrid {}

            Repeater {
                model: schemaModel
                delegate: TableNode {
                    tableIndex: index
                    x: model.tableX
                    y: model.tableY
                    tableName: model.name
                    columns: model.columns
                }
            }

            CreateTableButton {}

            Component.onCompleted: {
                schemaModel.addTable("users", 100, 100);
                schemaModel.addTable("orders", 400, 200);
                schemaModel.addColumn(0, "id", 0);
                schemaModel.addColumn(0, "username", 2);
                schemaModel.addColumn(1, "id", 0);
                schemaModel.addColumn(1, "user_id", 0);
            }
        }
    }
}
