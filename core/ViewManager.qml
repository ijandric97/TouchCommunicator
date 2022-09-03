import QtQuick

QtObject {
    // Predefined paths to respective qml view files
    readonly property var files: QtObject {
        readonly property string selectorFile: "views/selector/Selector.qml";
        readonly property string communicatorFile: "views/communicator/Communicator.qml";
        readonly property string settingsFile: "views/settings/Settings.qml";
    }

    // We will set the selector as initial view
    property string viewFile: files.selectorFile;

    // Helper functions
    function switchToSelector()
    {
        viewFile = files.selectorFile;
    }

    function switchToCommunicator()
    {
        viewFile = files.communicatorFile;
    }

    function switchToSettings()
    {
        viewFile = files.settingsFile;
    }
}
