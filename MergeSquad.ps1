$work_item = Read-Host "Enter the Work Item ID"

$base_path = "C:\tfsaz\CI\Squads\Toll\Devs\Jonas\$($work_item)"

$dev_branches = Get-ChildItem -Path $base_path -Directory | Where-Object { $_.Name -notlike "_references*" } | Select-Object -ExpandProperty FullName
$squad_branches = @()

foreach ($item in $dev_branches) {
    $item = $item -replace "\\Devs\\Jonas\\$($work_item)", ""
    $squad_branches += $item
}

Write-Host "Getting $($base_path)"
tf get "$($base_path)" /recursive /version:T

for ($i = 0; $i -lt $dev_branches.Count; $i++) {
    
    # Write-Host "Getting $($dev_branches[$i])"
    # tf get "$($dev_branches[$i])" /recursive /version:T

    Write-Host "Getting $($squad_branches[$i])"
    tf get "$($squad_branches[$i])" /recursive /version:T
    
    Write-Host "Merging $($dev_branches[$i]) to $($squad_branches[$i])"
    tf merge "$($dev_branches[$i])" "$($squad_branches[$i])" /recursive /version:T /noprompt
}
