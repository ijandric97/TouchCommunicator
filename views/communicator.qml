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

        // Render main items
        Repeater {
            id: activityRepeater
            model: appActivities.items; // We are creating dummy component to preserve the grid look

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

        // Action buttons should always be at the top left corner since it is the hardest one to reach probably?
        Repeater {
            id: activityActionsRepeater
            model: appActivities.getActionButtons();

            ActivityActionButton {
                item: modelData
            }

            Component.onCompleted: {
                // Append the elements to the grid instead of repeater
                while (children.length) {
                    children[0].parent = activityGrid;
                }
            }
        }

        // Padding Repeater
        Repeater {
            id: activityDummyRepeater
            model: appActivities.getDummyCount()

            Item {
                Layout.fillHeight: true
                Layout.fillWidth: true
            }

            Component.onCompleted: {
                // Append the elements to the grid instead of repeater
                while (children.length) {
                    children[0].parent = activityGrid;
                }
            }
        }
    }

    Component.onCompleted: {
        appActivities.loadActivities();
    }
}
