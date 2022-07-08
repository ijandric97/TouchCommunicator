import QtQuick

QtObject {
    id: appSettings

    property bool isDarkMode: false;
    property var toggleDarkMode: () => isDarkMode = !isDarkMode;
}
