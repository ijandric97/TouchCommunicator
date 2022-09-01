# Touch Communicator

Touch communicator written in Qt Quick (v6+).

## JSON File structure

FIXME: Use SQL instead of JSON
-> ...\AppData\Roaming\QTComm\QML\OfflineStorage
-> Use DB Browser for SQLite

FIXME: Add blob storage and translations to DB and relations etc.
NOTE: Foreign keys do not work in QML SQL because it is based on WebSQL
For more info see: https://forum.qt.io/topic/70600/sqlite-activating-foreign-key-support-not-working/3

NOTE: Material Colors are an array from 0 to 18

TODO: SettingsActivitiesTab should be a copy of communicator but have options for delete, edit upload? (button should be a rectangle with buttons?)

NOTE: Pagination perPage should be calculated as follows:

-   -1 If there is previous page (for button to previous page)
-   -1 If there is next page (for button to next page)
-   -1 If not a root page (for button to return to parent)
    Therefore if there are only 5 elements at the root it should have -0 since it needs no additional buttons.
    But, a child with for example 20 elements, would need -3 from perPage count if on 2nd page to fit 3 additional buttons
    (for previous, next and back to parent buttons).

```json
{
    "settings": {
        "darkTheme": true,
        "rows": 4,
        "columns": 4,
        "waitTime": 2000, // in miliseconds
        "language": "en_US"
    },
    "entries": [
        {
            "title": "Food",
            "icon": "....",
            "audio": "....",
            "buttonColor": "....",
            "children": []
        }
    ]
}
```
