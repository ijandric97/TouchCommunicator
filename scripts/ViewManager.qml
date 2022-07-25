import QtQuick

QtObject {
    id: viewManager

    // Predefined paths to respective qml view files
    readonly property var files: QtObject {
        readonly property string selectorFile: "views/Selector.qml";
        readonly property string communicatorFile: "views/Communicator.qml";
        readonly property string settingsFile: "views/Settings.qml";
    }

    // We will set the selector as initial view
    property string viewFile: files.selectorFile;

    property var switchToSelector: () => viewFile = files.selectorFile;
    property var switchToCommunicator: () => viewFile = files.communicatorFile;
    property var switchToSettings: () => viewFile = files.settingsFile;
}
