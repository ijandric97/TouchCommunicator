import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material
import QtQuick.Dialogs

import "../../libraries/Base64.js" as Base64;
import "../../libraries/Utils.js" as Utils;

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
                    font.underline: true
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
                    font.underline: true
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

            // Icon
            ColumnLayout {
                Layout.fillWidth: true

                Label {
                    text: qsTr("ICON")
                    font.underline: true
                }

                RowLayout {
                    Layout.fillWidth: true

                    Image {
                        Layout.margins: 8
                        visible: appActivities.editIcon
                        source: appActivities.editIcon ? "data:image/png;base64," + 
                            Base64.btoa(Utils.qByteArrayToString(appActivities.editIcon)) : "";                       
                    }
                
                    Button {
                        visible: !appActivities.editIcon
                        text: qsTr("SELECT_ICON");
                        display: AbstractButton.TextBesideIcon
                        icon {
                            source: "qrc:///images/btn_add.png";
                            color: "transparent"
                        }
                        onClicked: iconDialog.visible = true
                    }
                    Button {
                        visible: appActivities.editIcon
                        text: qsTr("NO_ICON");
                        display: AbstractButton.TextBesideIcon
                        icon {
                            source: "qrc:///images/btn_delete.png";
                            color: "transparent"
                        }
                        onClicked: appActivities.editIcon = null;
                    }

                    FileDialog {
                        id: iconDialog
                        title: qsTr("SELECT_ICON")
                        nameFilters: ["Image files (*.jpg *.png)"]
                        onAccepted: appActivities.editIcon = storage.loadFile(iconDialog.selectedFile);
                        onRejected: appActivities.editIcon = null;
                        Component.onCompleted: visible = false
                    }
                }
            }

            // Sound
            ColumnLayout {
                Layout.fillWidth: true

                Label {
                    text: qsTr("SOUND")
                    font.underline: true
                }

                RowLayout {
                    Layout.fillWidth: true

                    Button {
                        visible: appActivities.editSound
                        Layout.rightMargin: 8
                        display: AbstractButton.TextBesideIcon
                        text: qsTr("PLAY_SOUND");
                        icon {
                            source: "qrc:///images/btn_play.png";
                            color: "transparent"
                        }          
                        onClicked: appActivities.playEditSound();          
                    }
                    Button {
                        visible: !appActivities.editSound
                        text: qsTr("SELECT_SOUND");
                        display: AbstractButton.TextBesideIcon
                        icon {
                            source: "qrc:///images/btn_add.png";
                            color: "transparent"
                        }
                        onClicked: soundDialog.visible = true
                    }
                    Button {
                        visible: appActivities.editSound
                        text: qsTr("NO_SOUND");
                        display: AbstractButton.TextBesideIcon
                        icon {
                            source: "qrc:///images/btn_delete.png";
                            color: "transparent"
                        }
                        onClicked: appActivities.editSound = null;
                    }

                    FileDialog {
                        id: soundDialog
                        title: qsTr("SELECT_SOUND")
                        nameFilters: ["Sound files (*.wav)"]
                        onAccepted: appActivities.editSound = storage.loadFile(soundDialog.selectedFile);
                        onRejected: appActivities.editSound = null;
                        Component.onCompleted: visible = false
                    }
                }
            }
        }
    }

    // Back and Save buttons
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
