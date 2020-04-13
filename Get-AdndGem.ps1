# Import json to create objects.
$basevalueofgems = Invoke-RestMethod -Uri https://raw.githubusercontent.com/davidsteimle/adndGemGenerator/master/basevalueofgems.json
$keytogemproperties = Invoke-RestMethod -Uri https://raw.githubusercontent.com/davidsteimle/adndGemGenerator/master/keytogemproperties.json
$sizechain = Invoke-RestMethod -Uri https://raw.githubusercontent.com/davidsteimle/adndGemGenerator/master/sizechain.json

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
        "Log" = $null
        "Factor" = $null
    }
    "Factor" = $null
}

$gem.BaseValue.DiceScore = $dicescore
$gem.GemProperties = $( ($keytogemproperties | Where-Object -Property BaseValue -eq $gem.BaseValue.BaseValue) | Get-Random )
$gem.Modified.Value = $gem.BaseValue.BaseValue
$gem.Modified.Size = $gem.BaseValue.Size
$gem.Factor = $(($sizechain | Where-Object -Property BaseValue -eq $gem.BaseValue.BaseValue).Factor)
$gem.Modified.Factor = $gem.Factor

# Determine if gem is modified 
$rollagain = $false
$count = 1

$one = 1
$ten = 10
$loops = 1

$Logfile = "C:\Users\David\gems.log"

do{
    $modifier = $one..$ten | Get-Random
    switch($modifier){
        1 {
            $rollagain = $true
            $count++
            $gem.Modified.Log = $gem.Modified.Log + "$modifier - Stone increases to next higher base value; roll again on this table ignoring results above 8.\n"

            "$modifier - Stone increases to next higher base value; roll again on this table ignoring results above 8.\n" | Out-File -Append $Logfile

            $gem.Modified.Log = $gem.Modified.Log + " - Current base value = $($gem.Modified.Value)"

            " - Current base value = $($gem.Modified.Value)" | Out-File -Append $Logfile

            $gem.Modified.Factor = $($gem.Modified.Factor + 1)
            $gem.Modified.Value = $(($sizechain | Where-Object -Property BaseValue -eq $gem.Modified.Factor).BaseValue)
            $gem.Modified.Log = $gem.Modified.Log + " - New base value = $($gem.Modified.Value)"

            " - New base value = $($gem.Modified.Value)" | Out-File -Append $Logfile

            $gem.Modified.Log = $gem.Modified.Log + "\n"
            $one = 1
            $ten = 8
            $loops = 6
            
            break
        }
        2 {
            $rollagain = $false
            $gem.Modified.Log = $gem.Modified.Log + "$modifier - Stone is double base value. Do no roll again."

            "$modifier - Stone is double base value. Do no roll again." | Out-File -Append $Logfile

            $gem.Modified.Value = $gem.Modified.Value * 2
            break
        }
        3 {
            $rollagain = $false
            $gem.Modified.Log = $gem.Modified.Log + "$modifier - Stone is 10% to 60% above base value. Do no roll again on this table."

            "$modifier - Stone is 10% to 60% above base value. Do no roll again on this table." | Out-File -Append $Logfile

            $decimal = 1..6 | Get-Random
            $gem.Modified.Value = $gem.Modified.Value * [float]$("1.$decimal")
            $gem.Modified.Value = [math]::Round($gem.Modified.Value,2)
            break
        }
        9 {
            $rollagain = $false
            $gem.Modified.Log = $gem.Modified.Log + "$modifier - Stone is 10% to 40% below base value. Do no roll again on this table."
            
            "$modifier - Stone is 10% to 40% below base value. Do no roll again on this table." | Out-File -Append $Logfile

            $decimal = 6..9 | Get-Random
            $gem.Modified.Value = $gem.Modified.Value * [float]$("0.$decimal")
            $gem.Modified.Value = [math]::Round($gem.Modified.Value,2)
            break
        }
        10 {
            $rollagain = $true
            $count++
            $gem.Modified.Log = $gem.Modified.Log + "$modifier - Stone decreases to next lower base value; roll again on this table ignoring results below 2.\n"
            $gem.Modified.Log = $gem.Modified.Log + " - Current base value = $($gem.Modified.Value)"

            "$modifier - Stone decreases to next lower base value; roll again on this table ignoring results below 2.\n" | Out-File -Append $Logfile
            " - Current base value = $($gem.Modified.Value)" | Out-File -Append $Logfile

            $gem.Modified.Factor = $($gem.Modified.Factor - 1)
            $gem.Modified.Value = $(($sizechain | Where-Object -Property BaseValue -eq $gem.Modified.Factor).BaseValue)
            $gem.Modified.Log = $gem.Modified.Log + " - New base value = $($gem.Modified.Value)"

            " - New base value = $($gem.Modified.Value)" | Out-File -Append $Logfile

            $gem.Modified.Log = $gem.Modified.Log + "\n"
            $one = 2
            $ten = 10
            $loops = 4
            
            break
        }
        default {
            $rollagain = $false
            $gem.Modified.Log = $gem.Modified.Log + "$modifier - Base value shown is unchanged."

            "$modifier - Base value shown is unchanged." | Out-File -Append $Logfile
            break
        }
    }
} while($rollagain -and ($count -le $loops))

" " | Out-File -Append $Logfile
"----------" | Out-File -Append $Logfile
" " | Out-File -Append $Logfile

$gem | ConvertTo-Json
