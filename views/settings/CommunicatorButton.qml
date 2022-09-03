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
			source: item.icon ? "data:image/png;base64," +  Base64.btoa(Utils.qByteArrayToString(item.icon)) : "";
			color: "transparent"
		}
        onClicked: appActivities.traverseDown(itemIndex, true);

		Button {
			anchors.top: parent.top
			anchors.left: parent.left
			anchors.bottom: parent.bottom
			text: "EDIT"

            onClicked: {
                appActivities.setEditItem(item);
                activitiesTab.isForm = true;
            }
		}

		Button {
			anchors.top: parent.top
			anchors.right: parent.right
			anchors.bottom: parent.bottom
			text: "DELETE"
            visible: !appActivities.hasChildren(item)

            onClicked: {
                appActivities.setEditItem(item);
                appActivities.deleteEditItem();
            }
		}
	}
}
