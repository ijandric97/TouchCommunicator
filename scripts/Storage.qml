import QtQuick
import QtQuick.LocalStorage

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

    //#region ACTIVITIES ///////////////////////////////////////////////////////////////////////////////////////////////
    property bool initializedActivities: false

    function initializeActivities() {
        const db = getDatabase();
        db.transaction((tx) => {
            tx.executeSql(`
                CREATE TABLE IF NOT EXISTS "activities" (
                    "id"	INTEGER NOT NULL UNIQUE,
                    "parent"	INTEGER,
                    "title"	TEXT NOT NULL,
                    "color"	INTEGER,
                    "icon"  BLOB,
                    "sound" BLOB,
                    PRIMARY KEY("id")
                );
            `);
        });
        initializedActivities = true;
    }

    function dropActivities() {
        const db = getDatabase();
        db.transaction((tx) => tx.executeSql(`DROP TABLE "activities";`));
    }

    function setActivity(title, color, parent = null, id = null) {
        if (!initializedActivities) initializeActivities();

        const db = getDatabase();
        let res = "Error";
        db.transaction((tx) => {
            const rs = tx.executeSql(
                `INSERT OR REPLACE INTO "activities" VALUES (?,?,?,?);`,
                [id, parent, title, color]
            );
            if (rs.rowsAffected > 0) {
                res = "OK";
            }
        });

        return res;
    }

    function getActivity(id) {
        if (!initializedActivities) initializeActivities();

        const db = getDatabase();
        let res = null;
        db.transaction((tx) => {
            const rs = tx.executeSql(`SELECT * FROM activities WHERE id=?`, [id]);
            if (rs.rows.length > 0) {
                res = rs.rows.item(0);
            }
        });

        return res;
    }

    function getActivities(parent = null, limit = -1, offset = 0) {
        if (!initializedActivities) initializeActivities();

        const db = getDatabase();
        let res = [];
        db.transaction((tx) => {
            const rs = parent
                ? tx.executeSql(
                    `SELECT * FROM activities WHERE parent=? LIMIT ? OFFSET ?;`,
                    [parent, limit, offset]
                )
                : tx.executeSql(
                    `SELECT * FROM activities WHERE parent IS NULL LIMIT ? OFFSET ?;`,
                    [limit, offset]
                );
            for (let i = 0; i < rs.rows.length; i++) {
                res.push(rs.rows.item(i));
            }
        });

        return res;
    }

    function getActivityCount(parent = null) {
        if (!initializedActivities) initializeActivities();

        const db = getDatabase();
        let res = 0;
        db.transaction((tx) => {
            const rs = parent
                ? tx.executeSql(`SELECT COUNT(*) as count FROM activities WHERE parent=?;`, [parent])
                : tx.executeSql(`SELECT COUNT(*) as count FROM activities WHERE parent IS NULL;`);
            if (rs.rows.length > 0) {
                res = rs.rows.item(0).count;
            }
        });

        return res;
    }
    //#endregion ACTIVITIES ////////////////////////////////////////////////////////////////////////////////////////////
}
