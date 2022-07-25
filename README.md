# Touch Communicator

Touch communicator written in Qt Quick (v6+).

## JSON File structure

FIXME: Use SQL instead of JSON

```json
{
  "settings": {
    "darkTheme": true,
    "rows": 4,
    "columns": 4,
    "waitTime": 2, // in seconds
    "language": "en_US",
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