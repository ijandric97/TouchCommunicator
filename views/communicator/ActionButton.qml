import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

import "../../libraries/Base64.js" as Base64;
import "../../libraries/Utils.js" as Utils;

Item {
	property var item

    Layout.fillHeight: true
    Layout.fillWidth: true    

    Button {
        anchors.fill: parent
        text: qsTr(item.title);
        display: AbstractButton.TextUnderIcon;
        icon {
            source: item.icon ? item.icon : "";
            color: "transparent"
        }

        onPressed: {
            // We have pressed the button start the timer
            actionButtonTimer.start();
        }
        onReleased: {
            // We have released the button before the timer has finished, reset the timer
            actionButtonTimer.stop();
        }
        Timer {
            id:  actionButtonTimer
            interval: appSettings.waitTime
            running: false
            repeat: false
            onTriggered: {
                actionButtonTimer.stop();
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
