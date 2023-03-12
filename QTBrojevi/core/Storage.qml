import QtQuick
import QtQuick.LocalStorage

import "../libraries/Base64.js" as Base64;
import "../libraries/Utils.js" as Utils;

QtObject {
    readonly property string dbMajorVersion: "1"
    readonly property string dbMinorVersion: "1.0"    

    function getDatabase() {
        return LocalStorage.openDatabaseSync(`QTComm_${dbMajorVersion}`, dbMinorVersion, "StorageDatabase", 100000);
    }

    //#region SETTINGS /////////////////////////////////////////////////////////////////////////////////////////////////
    property bool initializedSettings: false

    function initializeSettings() {
        const db = getDatabase();
        db.transaction((tx) => {
            tx.executeSql(`
                CREATE TABLE IF NOT EXISTS "settings" (
                    "setting" TEXT UNIQUE,
                    "value" TEXT,
                    PRIMARY KEY("setting")
                );
            `);
        });
        initializedSettings = true;
    }

    function dropSettings() {
        const db = getDatabase();
        db.transaction((tx) => tx.executeSql(`DROP TABLE "settings";`));
    }

    function setSetting(setting, value) {
        if (!initializedSettings) initializeSettings();

        const db = getDatabase();
        let res = "Error";
        db.transaction((tx) => {
            const rs = tx.executeSql(
                `INSERT OR REPLACE INTO "settings" VALUES (?,?);`,
                [setting, value]
            );
            if (rs.rowsAffected > 0) {
                res = "OK";
            }
        });

        return res;
    }

    function getSetting(setting) {
        if (!initializedSettings) initializeSettings();

        const db = getDatabase();
        let res = undefined;
        db.transaction((tx) => {
            const rs = tx.executeSql(
                "SELECT value FROM settings WHERE setting=?;",
                [setting]
            );
            if (rs.rows.length > 0) {
                res = rs.rows.item(0).value;
            }
        });

        return res;
    }
    //#endregion SETTINGS //////////////////////////////////////////////////////////////////////////////////////////////    
}
