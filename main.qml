import QtQuick
import QtQuick.Window
import QtQuick.Controls.Material

import "scripts"
import "views"


Window {
    width: 800
    height: 800
    visible: true
    title: qsTr("TOUCH_COMMUNICATOR");

    Material.theme: appSettings.isDarkMode ? Material.Dark : Material.Light;
    color: appSettings.isDarkMode ? "black" : "white";

    AppSettings {
        id: appSettings
    }

    ViewManager {
        id: viewManager
    }

    AppActivities {
        id: appActivities
    }

    Storage {
        id: storage
    }

    Loader {
        id: viewLoader
        anchors.fill: parent
        source: viewManager.viewFile
    }
}
