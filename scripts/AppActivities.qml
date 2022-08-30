import QtQuick

QtObject {
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
            // Check if there are children
            if (storage.getActivityCount(items[index].id) > 0) {
                // There are children, proceed with loading
                item = items[index];
                page = 0;
                loadActivities();
            } else {
                // This is a child, fire its action and return us to the beginning
                // TODO: Launch the sound
                item = null;
                page = 0;
                loadActivities();
            }
        }
    }

    function traverseUp() {
        if (item) {
            item = item.parent ? storage.getActivity(item.parent) : null;
            page = 0;
            loadActivities();
        }
    }

    Component.onCompleted: {
        loadActivities();
    }
}
