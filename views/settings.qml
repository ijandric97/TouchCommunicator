import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material

Item {
    anchors {
        fill: parent
        margins: 16
    }

    Button {
        id: backButton
        text: qsTr("BACK");
        display: AbstractButton.TextUnderIcon;
        anchors {
            left: parent.left
            top: parent.top
        }
        icon {
            source: "qrc:///images/btn_back.png";
            color: "transparent"
        }
        onClicked: {
            appSettings.loadSettings(); // Just in case something is not saved, revert it
            // TODO: Perhaps revert also activities
            viewManager.switchToSelector();
        }
    }

    Text {
        id: settingsTitle
        height: 1
        text: qsTr("SETTINGS");
        color: appSettings.isDarkMode ? "white": "black";
        anchors {
            left: backButton.right
            top: parent.top
            leftMargin: 16
            topMargin: 16;
        }
        font {
            pointSize: 24
        }
    }

    Button {
        id: saveButton
        text: qsTr("SAVE");
        display: AbstractButton.TextUnderIcon;
        anchors {
            right: parent.right
            top: parent.top
        }
        icon {
            source: "qrc:///images/btn_save.png";
            color: "transparent"
        }
        onClicked: {
            appSettings.saveSettings();
            // TODO: Perhaps saving activities?
        }
    }

    Rectangle {
        id: settingsBorder
        anchors {
            left: parent.left
            right: parent.right
            top: backButton.bottom
            bottom: parent.bottom
            topMargin: 8
        }
        border {
            color: appSettings.isDarkMode ? "#585858": "#9C9C9C";
            width: 1
        }
        radius: 5
        color: Material.background

        TabBar {
            id: settingsTabBar
            anchors {
                left: parent.left
                top: parent.top
                right: parent.right
                leftMargin: 2
                topMargin: 2
                rightMargin: 2
            }

            TabButton {
                text: qsTr("GENERAL");
            }
            TabButton {
                text: qsTr("ACTIVITIES");
            }
        }

        Frame {
            anchors {
                top: settingsTabBar.bottom
                left: parent.left
                right: parent.right
                bottom: parent.bottom
                leftMargin: 1
                bottomMargin: 1
                rightMargin: 1
            }

            StackLayout {
                anchors.fill: parent

                currentIndex: settingsTabBar.currentIndex

                SettingsGeneralTab { }
                SettingsActivitiesTab { }
            }
        }
    }
}
