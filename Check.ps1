# Test if file is blank

if ((Get-Content "D:\Scripts\test.txt") -eq $Null) {
        write-host "File is blank"
    }   
else {
        write-host "file is written"
}
