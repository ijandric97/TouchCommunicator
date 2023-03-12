import QtQuick

import "../libraries/Utils.js" as Utils

QtObject {
    // Constants
    readonly property int minWaitTime: 0;
    readonly property int maxWaitTime: 10000;

    // Properties
    property bool isDarkMode: false;
    property int waitTime: 2000;

    // Helper functions
    function toggleDarkMode() {
        return (isDarkMode = !isDarkMode);
    }

    function setWaitTime(newWaitTime) {
        waitTime = Math.min(Math.max(Number(newWaitTime), minWaitTime), maxWaitTime);
    }

    // Load functions
    function getSettingsString() {
        return Utils.prettyStringify({
            isDarkMode: isDarkMode,
            waitTime: waitTime,
        });
    }

    function loadSettingsFromString(settingsString) {
        const parsed = JSON.parse(settingsString);
        if (parsed.isDarkMode !== undefined) isDarkMode = parsed.isDarkMode;
        if (parsed.waitTime !== undefined) waitTime = parsed.waitTime;
    }

    function loadSettings() {
        const settingsString = storage.getSetting("_CURRENT_SETTINGS");

        if (settingsString) {
            loadSettingsFromString(settingsString);
        }
    }

    Component.onCompleted: {
        loadSettings();
    }
}
