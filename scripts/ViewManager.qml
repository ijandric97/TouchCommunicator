import QtQuick

QtObject {
    // Predefined paths to respective qml view files
    readonly property var files: QtObject {
        readonly property string selectorFile: "views/Selector.qml";
        readonly property string communicatorFile: "views/Communicator.qml";
        readonly property string settingsFile: "views/Settings.qml";
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
