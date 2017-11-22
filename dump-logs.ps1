#  https://eventlogxp.com/blog/exporting-event-logs-with-windows-powershell/ = credits here
#  This script exports consolidated and filtered event logs to CSV
#

Set-Variable -Name EventAgeDays -Value 7     #we will take events for the latest 7 days
Set-Variable -Name CompArr -Value @("WIN-SER-AD-DNS", "WIN-SER-WEBFTP1", "WIN-SER-WEBFTP2")
Set-Variable -Name LogNames -Value @("Application", "System")
Set-Variable -Name EventTypes -Value @("Error", "Warning")
Set-Variable -Name ExportFolder -Value "\\win-ser-db\SER-LOGFILES\"


$el_c = @()   #consolidated error log
$now=get-date
$startdate=$now.adddays(-$EventAgeDays)
$ExportFile=$ExportFolder + "log-dump.csv"  # we cannot use standard delimiteds like ":"

foreach($comp in $CompArr)
{
  foreach($log in $LogNames)
  {
    Write-Host Processing $comp\$log
    $el = get-eventlog -ComputerName $comp -log $log -After $startdate -EntryType $EventTypes
    $el_c += $el  #consolidating
  
  }
}
$el_sorted = $el_c | Sort-Object TimeGenerated    #sort by time
Write-Host Exporting to $ExportFile
$el_sorted|Select EntryType, TimeGenerated, Source, EventID, MachineName | Export-CSV $ExportFile -NoTypeInfo  #EXPORT
Write-Host Done!