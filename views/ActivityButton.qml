import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

// TODO: Create a nice looking flat button: )
Item {
    id: rootActivityButton
    Layout.fillHeight: true
    Layout.fillWidth: true

    property int itemIndex // This cannot be index because that appears to be a registered keyword or something
    property var item

    Button {
        anchors.fill: parent
        text: item.title
        Material.background: Material.color(item.color)
        Material.foreground: "black"
        onPressed: {
            // We have pressed the button start the timer
            activityButtonTimer.start();
        }
        onReleased: {
            // We have released the button before the timer has finished, reset the timer
            activityButtonTimer.stop();
        }

        Timer {
            id:  activityButtonTimer
            interval: appSettings.waitTime
            running: false
            repeat: false
            onTriggered: {
                activityButtonTimer.stop();
                appActivities.traverseDown(itemIndex);
            }
        }
    }
}
