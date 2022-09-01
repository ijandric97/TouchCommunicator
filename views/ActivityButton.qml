import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

import "../scripts/Base64.js" as Base64;
import "../scripts/Utils.js" as Utils;

Item {
    property int itemIndex // This cannot be index because that appears to be a registered keyword or something
    property var item

    Layout.fillHeight: true
    Layout.fillWidth: true    

    Button {
        anchors.fill: parent
        text: item.title ? item.title : ""
        Material.background: typeof item.color === "number" ? Material.color(item.color) : undefined
        display: AbstractButton.TextUnderIcon;
        icon {
            source: item.icon ? "data:image/png;base64," +  Base64.btoa(Utils.qByteArrayToString(item.icon)) : "";
            color: "transparent"
        }

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
