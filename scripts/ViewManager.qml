import QtQuick

QtObject {
    id: viewManager

    // Predefined paths to respective qml view files
    readonly property var files: QtObject {
        readonly property string selectorFile: "views/selector.qml";
        readonly property string communicatorFile: "views/communicator.qml";
        readonly property string settingsFile: "views/settings.qml";
    }

    // We will set the selector as initial view
    property string viewFile: files.selectorFile;

    property var switchToSelector: () => viewFile = files.selectorFile + "?" + Math.random();
    property var switchToCommunicator: () => viewFile = files.communicatorFile + "?" + Math.random();
    property var switchToSettings: () => viewFile = files.settingsFile + "?" + Math.random();
}
