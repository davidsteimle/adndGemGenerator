# Gem Generation

This process is from the *AD&D Dungeon Masters Guide* (1979).

## basevalueofgems.json (p25)

A json file defining the first table in the process:

| DiceScore | BaseValue | Description | Size |
| :-------: | :-------: | :---------- | :--- |
| 1-25 | 10 | ornamental | very small |
| 26-50 | 50 | semi-precious | small |
| 51-70 | 100 | fancy | average |
| 71-90 | 500 | precious | large |
| 91-99 | 1000 | gem | very large |
| 100 | 5000 | jewel | huge |

Sample JSON:

```
{
  "DiceScore": [1,25],
  "BaseValue": 10,
  "Description": "ornamental",
  "Size": "very small"
}
```

## keytogemproperties.json (p26)

A json file with definitions from **Key to Gem Properties**

```
{
  "BaseValue": "10",
  "Name": "banded agate",
  "Opacity": "translucent",
  "Description": "striped brown and blue and white and reddish",
  "ReputedProperties": "restful and safe sleep"
}
```

This file will use the ``BaseValue`` score as a reference point between itself and ``basevalueofgems.json``.
