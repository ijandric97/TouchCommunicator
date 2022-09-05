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
            width: parent.height - 80
            height: parent.height - 80
            source: item.icon ? item.icon : "";
            color: "transparent"
        }
        font {
            pixelSize: 20
            bold: true
        }
        onClicked: {
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
