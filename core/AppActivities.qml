import QtQuick
import QtMultimedia

import "../libraries/Base64.js" as Base64;
import "../libraries/Utils.js" as Utils;

Item {
    property int page: 0;
    property int count: 0;
    property var item: null;
    property var items: [];

    function loadActivities() {
        count = storage.getActivityCount(item ? item.id : null); // getLimitAndOffset() depends on this, must be before
        const limitOffset = getLimitAndOffset();
        items = storage.getActivities(item ? item.id : null, limitOffset.limit, limitOffset.offset);
    }

    function getLimitAndOffset() {
        let hasUp = false;
        let hasNext = false;
        let hasPrevious = false;
        let offset = 0;
        let limit = appSettings.getPerPageCount(); // We begin with the perPage count we specified in the settings

        if (item !== null) {
            limit = limit - 1; // There is a parent, which means up button is also always present
            hasUp = true;
        }

        if (page === 0 && limit < count) {
            limit = limit -1;
            hasNext = true;
        } else if (!(page === 0 && limit > count)) {
            // This means we are not on a first page, and there are more elements than the first page can fit
            for (let i = 0; i < page; i++) {
                if (i === 0 && limit < count) {
                    // Special case
                    limit = limit - 1; // For the next button
                    offset = limit; // Go to the next page
                } else if (offset + limit < count) {
                    offset = offset + (limit - 1); // We have both next and previous
                }
            }

            hasPrevious = true; // We are not on page 0, we always have a previous
            if (offset + limit < count) {
                limit = limit - 1; // We are not on a last page so we have both next and previous
                hasNext = true;
            }
        }

        return ({ limit: limit, offset: offset, hasUp: hasUp, hasPrevious: hasPrevious, hasNext: hasNext});
    }

    function previousPage() {
        page = page - 1;
        loadActivities();
    }

    function nextPage() {
        page = page + 1;
        loadActivities();
    }

    function traverseDown(index, editMode = false) {
        if (index >= 0 && index < items.length) {
            let tempItem = items[index];

            // If there is a sound, fire it
            if (tempItem.sound) {
                audioOutput.source = "data:audio/wav;base64," + Base64.btoa(Utils.qByteArrayToString(tempItem.sound));
                audioOutput.play();
            }

            // If there are children proceed with loading, otherwise return to the beginning
            // If editMode, force ourselves into it
            item = storage.getActivityCount(tempItem.id) > 0 || editMode ? tempItem : null;
            page = 0;
            loadActivities();
        }
    }

    function traverseUp() {
        if (item) {
            item = item.parent ? storage.getActivity(item.parent) : null;
            page = 0;
            loadActivities();
        }
    }

    function getActionButtons() {
        const limitOffset = getLimitAndOffset();
        const buttons = [];

        if (limitOffset.hasUp) buttons.push({ title: "UP", index: -1, icon: "qrc:///images/btn_back.png" });
        if (limitOffset.hasPrevious) buttons.push({ title: "PREVIOUS", index: -2, icon: "qrc:///images/btn_left.png" });
        if (limitOffset.hasNext) buttons.push({ title: "NEXT", index: -3, icon: "qrc:///images/btn_right.png" });
        
        return buttons;
    }

    function getDummyCount() {
        let ret = 0;
        if (items.length > 0) {
            ret = appSettings.getPerPageCount() - items.length - getActionButtons().length;
        }
        if (ret < 0) ret = 0;
        return ret;
    }

    SoundEffect {
        id: audioOutput
        source: ""
    }

    //#region ADD / EDIT ///////////////////////////////////////////////////////////////////////////////////////////////
    // We need this for reactivity
    property var editId: null;
    property var editParent: null;
    property string editTitle: "";
    property var editColor: null;
    property var editIcon: null;
    property var editSound: null;

    function hasChildren(item) {
        if (item) return storage.hasChildren(item.id);
    }

    function setEditItem(item) {
        editId = item ? item.id : null;
        editParent = item ? item.parent : null;
        editTitle = item ? item.title : "";
        editColor = item ? item.color : null;
        editIcon = item ? item.icon : null;
        editSound = item ? item.sound : null;
    }

    function deleteEditItem() {
        if (editId) {
            storage.deleteActivity(editId);
            setEditItem(null);
            loadActivities();
        }
    }

    function saveEditItem() {
        if (editTitle) {
            const parent = item ? item.id : editParent;
            storage.setActivity(editTitle, editColor, editIcon, editSound, parent, editId);
            setEditItem(null);
            loadActivities();
        }
    }
    //#endregion ADD / EDIT ////////////////////////////////////////////////////////////////////////////////////////////
}
