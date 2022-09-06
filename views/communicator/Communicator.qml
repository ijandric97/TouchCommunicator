import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material

Item {
    MouseArea {
        width: 25
        height: 35
        onPressed: communicatorBackTimer.start();
        onReleased: communicatorBackTimer.stop();
        Timer {
            id: communicatorBackTimer
            interval: appSettings.waitTime
            running: false
            repeat: false
            onTriggered: {
                communicatorBackTimer.stop();
                viewManager.switchToSelector()
            }
        }
    }

    GridLayout {
        id: communicator
        anchors.fill: parent
        anchors.margins: 32
        columnSpacing: 32
        rowSpacing: 16

        columns: appSettings.getColumnCount();
        rows: appSettings.getRowCount();

        // Render main items
        Repeater {
            model: appActivities.items;

            CommunicatorButton {
                itemIndex: index
                item: modelData
            }

            Component.onCompleted: {
                // Append the elements to the grid instead of repeater
                while (children.length) {
                    children[0].parent = communicator;
                }
            }
        }

        // Action buttons should always be at the top left corner since it is the hardest one to reach probably?
        Repeater {
            model: appActivities.getActionButtons();

            ActionButton {
                item: modelData
            }

            Component.onCompleted: {
                // Append the elements to the grid instead of repeater
                while (children.length) {
                    children[0].parent = communicator;
                }
            }
        }

        // Padding Repeater - We are creating dummy component to preserve the grid look
        Repeater {
            model: appActivities.getDummyCount()

            Item {
                Layout.fillHeight: true
                Layout.fillWidth: true
            }

            Component.onCompleted: {
                // Append the elements to the grid instead of repeater
                while (children.length) {
                    children[0].parent = communicator;
                }
            }
        }
    }

    Component.onCompleted: {
        appActivities.loadActivities();
    }
}
