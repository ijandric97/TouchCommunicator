import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

import "../../libraries/Base64.js" as Base64;
import "../../libraries/Utils.js" as Utils;

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
            width: parent.height - 80
            height: parent.height - 80
            source: item.icon ? "data:image/png;base64," +  Base64.btoa(Utils.qByteArrayToString(item.icon)) : "";
            color: "transparent"
        }
        font {
            pixelSize: 20
            bold: true
        }

        onPressed: {
            // We have pressed the button start the timer
            communicatorButtonTimer.start();
        }
        onReleased: {
            // We have released the button before the timer has finished, reset the timer
            communicatorButtonTimer.stop();
        }
        Timer {
            id:  communicatorButtonTimer
            interval: appSettings.waitTime
            running: false
            repeat: false
            onTriggered: {
                communicatorButtonTimer.stop();
                appActivities.traverseDown(itemIndex);
            }
        }
    }
}
