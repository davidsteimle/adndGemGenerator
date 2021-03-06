# Gem Generation

Of all the programming possibilities provided by roleplaying games, 
I find the gem calculation bit in AD&D to be my favorite. Sure, you 
could award your players with "15 10gp gems," but wouldn't "you find 
10 eye agates and 5 pieces of turquoise," sound better? It adds 
flavor, and when coupled with _reputed properties_ you have a whole 
new set of roleplaying hooks. The variation in value also allows for 
chances to cheat, or be cheated, when selling gems, the degree of 
flaw or improvement affecting skill challenges.

This process is from the *AD&D Dungeon Masters Guide* (1979).

The process is quite simple:

1. Determine how many gems you need (typically in the _Monster Manual_)
1. Determine the [base value](#basevalueofgemsjson-p25)
    * This can be done in lots of 5 or 10
    * Roll percentiles for each lot to get base value
1. Roll for [value variation](#increase-or-decrease-of-worth-beyond-base-value-p26), per lot (optional)
1. Roll for [gem type](#keytogempropertiesjson-p26) (optional)

The difficulty can come in when value variation calls for a second roll, which may in turn call for a third, and so on.

----

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

## Increase or Decrease of Worth Beyond Base Value (p26)

This chart allows for variation in gem value, based on quality or size. Once Base Value is known (from ``basevalueofgems.json`` data) we can decide if that value decreases or increases, according to this table. There is a _value chain_, which can be described (default Base Values in **bold**):

1 SP, 5 SP, 10 SP, 1 GP, 5 GP, **10 GP**, **50 GP**, **100 GP**, **500 GP**, **1,000 GP**, **5,000 GP**, 10,000 GP, 25,000 GP, 50,000 GP, 100,000 GP, 250,000 GP, 500,000 GP, 1,000,000 GP

1,000,000 GP is described as the maximum possible value, and no stone may move more than 7 places from its original base value. One could argue that a change in value also indicates a change in size Increases are described below:

| Die | Result | Comment |
| :-: | :----- | :------ |
|1 | Stone increases to next higher base value; roll again ignoring results above 8. | This result may, potentially, occur many times. |
| 2 | Stone is double base value. Do not roll again. |  |
| 3 | Stone is 10% to 60% above base value. Do not roll again. |  |
| 4-8 | Base value shown is unchanged. | This will be the ``default`` entry, if we use a ``switch`` statement. |
| 9 | Stone is 10% to 40%  below base value. Do not roll again. |  |
| 10 | Stone decreases to next lower base value; roll again ignoring results below 2. | This result may, potentially, occur many times. |
