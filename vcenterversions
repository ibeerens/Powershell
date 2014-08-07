$FileLoc = "D:\temp\versions.txt"

#SSO Version
$path = 'HKLM:\Software\VMware, Inc.\VMware Infrastructure\SSOServer'
$SSOversion = Get-ItemProperty $path | Select-Object -ExpandProperty "InstalledVersion"

#Inventory Service
$path1 = 'HKLM:\Software\VMware, Inc.\VMware Infrastructure\Inventory Service'
$Inventoryversion = Get-ItemProperty $path1 | Select-Object -ExpandProperty "Version"

#Web Client Version
$path2 = 'HKLM:\Software\VMware, Inc.\VMware Infrastructure\vSphere Web Client'
$Webclientversion = Get-ItemProperty $path2 | Select-Object -ExpandProperty "InstalledVersion"

#vCenter Version
$path3 = 'HKLM:\Software\VMware, Inc.\VMware VirtualCenter'
$vCenterversion = Get-ItemProperty $path3 | Select-Object -ExpandProperty "InstalledVersion"

#VMware Update Manager Version
$path4 = 'HKLM:\Software\Wow6432Node\VMware, Inc.\VMware Update Manager'
$VUMversion = Get-ItemProperty $path4 | Select-Object -ExpandProperty "InstalledVersion"

#VMware vSphere PowerCLI 
$path5 = 'HKLM:\Software\Wow6432Node\VMware, Inc.\VMware vSphere PowerCLI'
$PowerCLIversion = Get-ItemProperty $path5 | Select-Object -ExpandProperty "InstalledVersion"

# Output to file
write-output "vCenter Single Sign-On version: $SSOVersion" | out-file $FileLoc 
write-output "vSphere Web Client version: $Webclientversion" | out-file $FileLoc -append
write-output "vCenter Inventory Service version: $Inventoryversion" | out-file $FileLoc -append
write-output "vCenter Server Version: $vCenterversion" | out-file $FileLoc -append
write-output "VMware Update Manager version: $VUMVersion" | out-file $FileLoc -append
write-output "VMware PowerCLI version: $PowerCLIVersion" | out-file $FileLoc -append
