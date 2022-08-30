import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material

Item {
    GridLayout {
        id: activityGrid
        anchors.fill: parent
        anchors.margins: 32
        columnSpacing: 32
        rowSpacing: 16

        columns: appSettings.getColumnCount();
        rows: appSettings.getRowCount();

        Repeater {
            id: activityRepeater
            model: appActivities.items

            ActivityButton {
                itemIndex: index
                item: modelData
            }

            Component.onCompleted: {
                // Append the elements to the grid instead of repeater
                while (children.length) {
                    children[0].parent = activityGrid;
                }
            }
        }
    }
}
