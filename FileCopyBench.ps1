#
# Author: Lars Winkler <lars@winkler-winsen.de>
# Date:   08.09.2022
#

#region Initinalize
$TestFile = "filesystem::\\DiskStation\Public\Synology Restore Media.iso"
$CsvFile = "FileCopyBench.csv"
$CsvDelimiter = ';' # Have to be different to $TimeStampFormat delimiters
$TimeStampFormat = "HH:mm:ss,fff"


$TestFileSize = (Get-Item -Path $TestFile).Length
#endregion Initialize

#region FileCopy
$TimeStampStart = Get-Date
Write-Output "$($TimeStampStart.ToString($TimeStampFormat)) Start"

Copy-Item $TestFile "test.dat"

$TimeStampEnd = Get-Date
Write-Output "$($TimeStampEnd.ToString($TimeStampFormat)) End"

Remove-Item -Force "test.dat"
#endregion FileCopy

#region Calculation
$TimeStampDiff = New-TimeSpan -Start $TimeStampStart -End $TimeStampEnd
$TimeStampDiffSec = 60*60*$TimeStampDiff.Hours `
    + 60*$TimeStampDiff.Minutes `
    + $TimeStampDiff.Seconds `
    + ($TimeStampDiff.Milliseconds/1000)
$MBits = $TestFileSize/1MB*8 / $TimeStampDiffSec
#endregion Calculation
Write-Output "$TimeStampDiffSec Diff Sec"

Write-Output "$([math]::Round($TestFileSize/1MB)) MB"

Write-Output "$([math]::Round($Mbits,2)) MBit/s"

#region CsvOutput
if (-Not(Test-Path -Path $CsvFile)) {
    Write-Output ("TestFileSize;TimeStampStart;TimeStampEnd;TimeStampDiffSec;MBits")`
    | Out-File $CsvFile
}

Write-Output ("{0}$CsvDelimiter{1}$CsvDelimiter{2}$CsvDelimiter{3}$CsvDelimiter{4}" -f $TestFileSize, $TimeStampStart.ToString($TimeStampFormat), $TimeStampEnd.ToString($TimeStampFormat), $TimeStampDiffSec, $MBits)`
    | Out-File $CsvFile -Append
#endregion CsvOutput
