import QtQuick
import QtQuick.Window
import QtQuick.Controls

import "scripts";


Window {
    width: 800
    height: 600
    visible: true
    title: qsTr("Touch Communicator")

    ApplicationSettings {
        id: appSettings
    }

    Loader {
        id: viewLoader
        anchors.fill: parent
        source: appSettings.viewFile;
    }
}
