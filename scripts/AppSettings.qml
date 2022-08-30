import QtQuick

import "utils.js" as Utils

QtObject {
    // Constants
    readonly property var sizes: [3, 4, 5];
    readonly property int minWaitTime: 0;
    readonly property int maxWaitTime: 10000;
    readonly property var languages: ["hr_HR", "en_US"];

    // Properties
    property bool isDarkMode: false;
    property int rowSizeIndex: 1;
    property int columnSizeIndex: 1;
    property int waitTime: 2000;
    property string language: "hr_HR";

    // Helper functions
    function toggleDarkMode() {
        return (isDarkMode = !isDarkMode);
    }

    function getPerPageCount() {
        return getRowCount() * getColumnCount();
    }

    function getRowCount() {
        if (rowSizeIndex < 0 || rowSizeIndex >= sizes.length) {
            rowSizeIndex = 0; // Safety check, if index is incorrect set it to 0
        }
        return sizes[rowSizeIndex];
    }

    function getColumnCount() {
        if (columnSizeIndex < 0 || columnSizeIndex >= sizes.length) {
            columnSizeIndex = 0; // Safety check, if index is incorrect set it to 0
        }
        return sizes[columnSizeIndex];
    }

    function setWaitTime(newWaitTime) {
        waitTime = Math.min(Math.max(Number(newWaitTime), minWaitTime), maxWaitTime);
    }

    function setLanguage(newLanguage) {
        if (languages.findIndex((el) => el === newLanguage) !== -1) {
            language = newLanguage;
            qmlTranslator.selectLanguage(newLanguage);
        }
    }

    // Save and Load functions
    function getSettingsString() {
        return Utils.prettyStringify({
            isDarkMode: isDarkMode,
            rowSizeIndex: rowSizeIndex,
            columnSizeIndex: columnSizeIndex,
            waitTime: waitTime,
            language: language,
        });
    }

    function loadSettingsFromString(settingsString) {
        const parsed = JSON.parse(settingsString);

        if (parsed.isDarkMode !== undefined) isDarkMode = parsed.isDarkMode;
        if (parsed.rowSizeIndex !== undefined) rowSizeIndex = parsed.rowSizeIndex;
        if (parsed.columnSizeIndex !== undefined) columnSizeIndex = parsed.columnSizeIndex;
        if (parsed.waitTime !== undefined) waitTime = parsed.waitTime;
        if (parsed.language !== undefined) language = parsed.language;

        setLanguage(language); // Set the language to correct one
    }

    function saveSettings() {
        storage.setSetting("_CURRENT_SETTINGS", getSettingsString());
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
