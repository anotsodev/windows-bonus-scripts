Write-Host "This script will add new scheduled task and that executes a powershell script"

$action = New-ScheduledTaskAction -Execute "powershell.exe dump-logs.ps1"
$trigger = New-ScheduledTaskTrigger -Weekly -At 9am

Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "Dump Logs" -Description "Dump logs"