#
# Author: Lars Winkler <lars@winkler-winsen.de>
# Date:   08.09.2022
#

$TestFile = "filesystem::\\DiskStation\Public\Synology Restore Media.iso"
$CsvFile = "FileCopyBench.csv"
$TimeStampFormat = "HH:MM:ss,fff"

$TestFileSize = (Get-Item -Path $TestFile).Length

$TimeStampStart = Get-Date
Write-Output "$($TimeStampStart.ToString($TimeStampFormat)) Start"

Copy-Item $TestFile "test.dat"

$TimeStampEnd = Get-Date
Write-Output "$($TimeStampEnd.ToString($TimeStampFormat)) End"

Remove-Item -Force "test.dat"

$TimeStampDiff = New-TimeSpan -Start $TimeStampStart -End $TimeStampEnd
$TimeStampDiffSec = 60*60*$TimeStampDiff.Hours `
    + 60*$TimeStampDiff.Minutes `
    + $TimeStampDiff.Seconds `
    + ($TimeStampDiff.Milliseconds/1000)
Write-Output "$TimeStampDiffSec Diff Sec"

Write-Output $($TestFileSize/1MB)

$MBits = $TestFileSize/1MB*8 / $TimeStampDiffSec
Write-Output "$Mbits MBit/s"

if (-Not(Test-Path -Path .\copybench.csv)) {
    Write-Output ("TestFileSize;TimeStampStart;TimeStampEnd;TimeStampDiffSec;MBits")`
    | Out-File $CsvFile
}

Write-Output ("{0};{1};{2};{3};{4}" -f $TestFileSize, $TimeStampStart.ToString($TimeStampFormat), $TimeStampEnd.ToString($TimeStampFormat), $TimeStampDiffSec, $MBits)`
    | Out-File $CsvFile -Append
