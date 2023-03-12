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
        onClicked: appActivities.traverseDown(itemIndex, true);

		Button {
			anchors.top: parent.top
			anchors.left: parent.left
			anchors.bottom: parent.bottom
			text: qsTr("EDIT")
			font {
				pixelSize: 13
			}
            onClicked: {
                appActivities.setEditItem(item);
                activitiesTab.isForm = true;
            }
		}

		Button {
			anchors.top: parent.top
			anchors.right: parent.right
			anchors.bottom: parent.bottom
			text: qsTr("DELETE")
            visible: !appActivities.hasChildren(item)
			font {
				pixelSize: 13
			}
            onClicked: {
                appActivities.setEditItem(item);
                appActivities.deleteEditItem();
            }
		}
	}
}
