# Gem Generation

This process is from the *AD&D Dungeon Masters Guide* (1979).

# basevalueofgems.json (p25)

A jason file defining the first table in the process:

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

