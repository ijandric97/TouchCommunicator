import QtQuick 2.0

Item {
    Text {
        text: appSettings.waitTime
        color: appSettings.isDarkMode ? "white": "black";
        x: 0
        y: 0
    }
}
