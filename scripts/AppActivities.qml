import QtQuick
import QtMultimedia

import "Base64.js" as Base64;
import "Utils.js" as Utils;

Item {
    property int page: 0;
    property int count: 0;
    property var item: null;
    property var items: [];

    function loadActivities() {
        const perPage = appSettings.getPerPageCount();
        count = storage.getActivityCount(item ? item.id : null);
        items = storage.getActivities(item ? item.id : null, perPage, page * perPage);
    }

    function previousPage() {
        if (page > 0) {
            page = page - 1;
            loadActivities();
        }
    }

    function nextPage() {
        const perPage = appSettings.getPerPageCount();
        if (count - ((page + 1) * perPage) > 0) {
            page = page + 1;
            loadActivities();
        }
    }

    function traverseDown(index) {
        if (index >= 0 && index < items.length) {
            let tempItem = items[index];

            // If there is a sound, fire it
            if (tempItem.sound) {
                playSound.source = "data:audio/wav;base64," + Base64.btoa(Utils.qByteArrayToString(tempItem.sound));
                playSound.play();
            }

            // If there are children proceed with loading, otherwise return to the beginning
            item = storage.getActivityCount(tempItem.id) > 0 ? tempItem : null;
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

    SoundEffect {
        id: playSound
        source: ""
    }

    Component.onCompleted: {
        loadActivities();
    }
}
