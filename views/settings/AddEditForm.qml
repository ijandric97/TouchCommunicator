import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material

ColumnLayout {
    Layout.fillWidth: true

    Text {
        height: 1
        text: appActivities.editId ? qsTr("EDIT_ITEM") : qsTr("ADD_ITEM");
        color: appSettings.isDarkMode ? "white": "black";
        font {
            pointSize: 24
        }
    }

    GroupBox {
        Layout.fillWidth: true

        ColumnLayout {
            Layout.fillWidth: true

            // Title
            RowLayout {
                Layout.fillWidth: true
                spacing: 20

                Label {
                    text: qsTr("TITLE")
                }
                TextField {
                    Layout.fillWidth: true
                    text: appActivities.editTitle
                    onEditingFinished: {
                        appActivities.editTitle = text
                    }
                }
            }

            // Colors
            ColumnLayout {
                Layout.fillWidth: true

                Label {
                    text: qsTr("COLOR")
                }
                GridLayout {
                    columns: 10
                    rows: 2

                    Button {
                        Layout.preferredWidth: 65
                        Material.background: undefined
                        onClicked: {
                            appActivities.editColor = null
                        }
                        icon {
                            source: appActivities.editColor === undefined || appActivities.editColor === null ?
                                        "qrc:///images/btn_check.png" : "";
                            color: "transparent"
                        }
                    }

                    Repeater {
                        model: 19
                        Button {
                            Layout.preferredWidth: 65
                            Material.background: Material.color(index)
                            onClicked: {
                                appActivities.editColor = index
                            }
                            icon {
                                source: appActivities.editColor === index ?
                                            "qrc:///images/btn_check.png" : "";
                                color: "transparent"
                            }
                        }

                        Component.onCompleted: {
                            // Append the elements to the grid instead of repeater
                            while (children.length) {
                                children[0].parent = communicator;
                            }
                        }
                    }

                }
            }
        }
    }

    RowLayout {
        Layout.fillWidth: true

        Button {
            text: qsTr("BACK");
            display: AbstractButton.TextBesideIcon
            icon {
                source: "qrc:///images/btn_back.png";
                color: "transparent"
            }
            onClicked: {
                appActivities.setEditItem(null);
                activitiesTab.isForm = false;
            }
        }

        // A dummy item to fill the space between Back and Save buttons
        Item {
            Layout.fillWidth: true
        }

        Button {
            text: qsTr("SAVE");
            display: AbstractButton.TextBesideIcon
            icon {
                source: "qrc:///images/btn_save.png";
                color: "transparent"
            }
            onClicked: {
                appActivities.saveEditItem();
                activitiesTab.isForm = false
            }
        }
    }
}
