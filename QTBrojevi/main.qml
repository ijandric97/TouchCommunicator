import QtQuick
import QtQuick.Window
import QtQuick.Controls.Material

import "core"
import "views"

Window {
    width: 800
    height: 800
    visible: true
    title: "Učimo brojeve"
    visibility: "FullScreen"

    Material.theme: appSettings.isDarkMode ? Material.Dark : Material.Light;
    color: appSettings.isDarkMode ? "black" : "white";

    AppSettings {
        id: appSettings
    }

    Storage {
        id: storage
    }

    ActionButton {
    }
}
