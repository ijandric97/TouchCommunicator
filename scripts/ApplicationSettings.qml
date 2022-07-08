import QtQuick 2.2

QtObject {
    id: applicationSettings

    // VIEWMANAGER /////////////////////////////////////////////////////////////////////
    // Predefined paths to respective qml view files
    readonly property var files: QtObject {
        readonly property string selectorFile: "views/selector.qml";
        readonly property string communicatorFile: "views/communicator.qml";
        readonly property string settingsFile: "views/settings.qml";

        // We will set the selector as initial view
        readonly property string defaultFile: selectorFile;
    }


    property string viewFile: files.defaultFile;

    function switchToSelector() {
        viewFile = files.selectorFile + "?" + Math.random();
    }

    function switchToCommunicator() {
        viewFile = files.communicatorFile + "?" + Math.random();
    }

    function switchToSettings() {
        viewFile = files.settingsFile + "?" + Math.random();
    }
}
