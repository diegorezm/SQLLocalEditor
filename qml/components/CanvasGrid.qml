import QtQuick
import SQLLocalEditor

Canvas {
    id: root
    anchors.fill: parent

    property real gridSize: 24
    property real dotSize: 1.5

    onPaint: {
        var ctx = getContext("2d");
        ctx.clearRect(0, 0, width, height);

        ctx.fillStyle = Theme.muted;

        for (var x = 0; x < width; x += gridSize) {
            for (var y = 0; y < height; y += gridSize) {
                ctx.beginPath();
                ctx.arc(x, y, dotSize, 0, Math.PI * 2);
                ctx.fill();
            }
        }
    }
}
