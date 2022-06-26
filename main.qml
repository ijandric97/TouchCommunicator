import QtQuick
import QtQuick.Window
import QtQuick.Controls

import "scripts/ViewManager.js" as ViewManager

Window {
    width: 800
    height: 600
    visible: true
    title: qsTr("Touch Communicator")

    onBeforeRendering: console.log("HMM");

    Loader {
        id: viewLoader

        anchors.fill: parent
        source: ViewManager.DEFAULT_FILE

        onLoaded: { console.log("LOADED"); ViewManager.setLoader(viewLoader) }
    }
}
