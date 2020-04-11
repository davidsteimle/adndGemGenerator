# Import json to create objects.
$basevalueofgems = Invoke-RestMethod -Uri https://raw.githubusercontent.com/davidsteimle/adndGemGenerator/master/basevalueofgems.json
$keytogemproperties = Invoke-RestMethod -Uri https://raw.githubusercontent.com/davidsteimle/adndGemGenerator/master/keytogemproperties.json

# Convert the range from the DiceScore into a usable range for comparison.
foreach($item in $basevalueofgems){
    $item.DiceScore = $( ($item.DiceScore[0])..($item.DiceScore[1]) )
}

# Define base gem as a hashtable
$gem = @{
    "BaseValue" = $null
    "Type" = $null
    "Size" = $null
    "Name" = $null
    "Opacity" = $null
    "Description" = $null
    "ReputedProperties" = $null
    "ModifiedValue" = $null
    "ModifiedSize" = $null
}

$dicescore = $(1..100 | Get-Random)

$gem = @{
    "BaseValue" = $($basevalueofgems | Where-Object -Property DiceScore -Contains $dicescore)
    "GemProperties" = $null
    "Modified" = @{
        "Value" = $null
        "Size" = $null
    }
}

$gem.BaseValue.DiceScore = $dicescore
$gem.GemProperties = $( ($keytogemproperties | Where-Object -Property BaseValue -eq $gem.BaseValue.BaseValue) | Get-Random )
