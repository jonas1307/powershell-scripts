$work_item = Read-Host "Enter the Work Item ID"

$base_path = "C:\tfsaz\CI\Squads\Toll\Devs\Jonas\$($work_item)"

$references_path = "C:\tfsaz\CI\Squads\Toll\Devs\Jonas\$($work_item)\_references"

Write-Host "Removing $($references_path)"
Remove-Item -Recurse -Force $references_path

Write-Host "Getting Changeset 1 of $($base_path)"
tf get $base_path /recursive /version:C1

Write-Host "Removing $($base_path)"
Remove-Item -Recurse -Force $base_path
