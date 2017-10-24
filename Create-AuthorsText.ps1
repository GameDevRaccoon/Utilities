# This script is used to generate the standard authors.txt that is used for git-hub projects

Param([String] $Location, [String[]] $devs, [String]$Jsonfile = ".\resources\Authors.json")

$Authors = Get-Content $Jsonfile | ConvertFrom-Json 

$Authors = $Authors.Authors

New-Item $Location\authors.txt -Force

foreach($dev in $devs)
{
    $name = $Authors | Select Name, Alias | Where-Object {$_.Name -eq $dev -or $_.Alias -eq  $dev} | Select Name
    $name = $name.Name

    $alias = $Authors | Select Name, Alias | Where-Object {$_.Name -eq $dev -or $_.Alias -eq  $dev} | Select Alias
    $alias = $alias.Alias
    
    $role = $Authors | Select Name, Alias, Field | Where-Object {$_.Name -eq $dev -or $_.Alias -eq  $dev} | Select Field
    $role = $role.Field

    $link = $Authors | Select Name, Alias, Link | Where-Object {$_.Name -eq $dev -or $_.Alias -eq  $dev} | Select Link
    $link = $link.Link
    Add-Content $Location\authors.txt -Value "$name `t$alias `t$role `t$link"
}