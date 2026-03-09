import QtQuick
import QtQuick.Controls.Basic
import SQLLocalEditor

Button {
    id: root

    // "default" | "secondary" | "ghost" | "outline"
    property string variant: "default"
    property string label: "Button"

    text: label

    // Derived colors based on variant — just like a cva() in React
    readonly property color bgColor: {
        switch (variant) {
        case "secondary":
            return Theme.muted;
        case "ghost":
            return "transparent";
        case "outline":
            return "transparent";
        default:
            return Theme.accent;
        }
    }

    readonly property color fgColor: {
        switch (variant) {
        case "secondary":
            return Theme.textPrimary;
        case "ghost":
            return Theme.textSecondary;
        case "outline":
            return Theme.accent;
        default:
            return Theme.base;
        }
    }

    readonly property color borderColor: {
        switch (variant) {
        case "outline":
            return Theme.accent;
        case "ghost":
            return "transparent";
        default:
            return "transparent";
        }
    }

    contentItem: Text {
        text: root.text
        color: root.hovered ? Qt.lighter(root.fgColor, 1.2) : root.fgColor
        font.family: Theme.fontMono
        font.pixelSize: 13
        font.bold: variant === "default"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    HoverHandler {
        cursorShape: Qt.PointingHandCursor
    }

    background: Rectangle {
        radius: Theme.radiusSm
        color: root.hovered ? Qt.lighter(root.bgColor, 1.3) : root.bgColor
        border.color: root.borderColor
        border.width: variant === "outline" ? 1 : 0

        Behavior on color {
            ColorAnimation {
                duration: 100
            }
        }
    }

    leftPadding: 16
    rightPadding: 16
    topPadding: 8
    bottomPadding: 8
}
