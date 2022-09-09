# FileCopyBench
Performes file copy operation with taking time stamps to calc bandwidth im MBit/s. Outputs statistics and saves to CSV file

## Output examples
### Terminal
```
22:09:44,977 Start
22:09:52,040 End
7.063 Diff Sec
320 MB
362.66 MBit/s
```

### CSV (comma separated file)
```
TestFileSize;TimeStampStart;TimeStampEnd;TimeStampDiffSec;MBits
335736832;22:09:44,977;22:09:52,040;7,063;362,66016565198925
```
## Customize

Test file with path and UNC support ```$TestFile = "filesystem::\\DiskStation\Public\Synology Restore Media.iso"``` 

Time stamp format ```$TimeStampFormat = "HH:mm:ss,fff"``` (US should be ```HH:MM:ss.fff```)

CSV file ```$CsvFile = "FileCopyBench.csv"```
