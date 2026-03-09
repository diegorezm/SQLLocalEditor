pragma Singleton
import QtQuick

QtObject {
    readonly property color base: "#0e0e10"
    readonly property color surface: "#141416"
    readonly property color overlay: "#1c1c20"
    readonly property color muted: "#26262c"

    readonly property color textPrimary: "#ddd8f0"
    readonly property color textSecondary: "#8a8599"
    readonly property color textDisabled: "#4a4855"

    readonly property color accent: "#a78bdc"
    readonly property color accentDim: "#6b589e"
    readonly property color accentSoft: "#c4aff0"
    readonly property color secondary: "#dc8bb5"
    readonly property color secondaryDim: "#9e5880"

    readonly property color success: "#8bdca0"
    readonly property color warning: "#dcca8b"
    readonly property color error: "#dc8b8b"

    readonly property color nodeBg: "#111113"
    readonly property color nodeBorder: "#2a2a32"
    readonly property color nodeHeader: "#18181e"
    readonly property color wire: "#a78bdc"
    readonly property color wireHover: "#c4aff0"
    readonly property color port: "#6b589e"
    readonly property color portHover: "#a78bdc"

    readonly property string fontMono: "JetBrains Mono"
    readonly property string fontSans: "Inter"

    readonly property int radiusSm: 4
    readonly property int radiusMd: 8
    readonly property int radiusLg: 12
}
