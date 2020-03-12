function RollDie{
    <# 
        .DESCRIPTION 
        Roll one die and return the result. 
    #>
    param(
        [Parameter(Mandatory=$true)]
        [int32]$Max # The highest number desired
        ,
        [int32]$Min = 1 # the lowest number desired
    )
    $Max = $Max + 1 # because powershell makes -Maximum the  upper limi, and not a potential result
    Get-Random -Minimum $Min -Maximum $Max
}
