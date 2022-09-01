import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

import "../scripts/Base64.js" as Base64;
import "../scripts/Utils.js" as Utils;

Item {
	property var item

    Layout.fillHeight: true
    Layout.fillWidth: true    

    Button {
        anchors.fill: parent
        text: qsTr(item.title);
        display: AbstractButton.TextUnderIcon;
        icon {
            source: "";
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
				if (item.index === -1) {
                    appActivities.traverseUp();
                } else if (item.index === -2) {
                    appActivities.previousPage();
                } else if (item.index === -3) {
                    appActivities.nextPage();
                }
            }
        }
    }
}
