<#
.SYNOPSIS
    PoolParentSnapShot.ps1
.VERSION
    1.0
.DESCRIPTION
    Exports all Horizon pools with the parents and active snapshot 
.NOTES
    Author(s): Ivo Beerens
    Requirements:  
    Make sure the VMware.HV.Helper module is installed, see: https://github.com/vmware/PowerCLI-Example-Scripts
    Copy the VMware.Hv.Helper to the module location.
.EXAMPLE
    PS> ./PoolParentSnapShot.ps1
#>

Import-Module VMware.Hv.Helper

#Variables
$conserver = ' '
$domain = ' '

# Connect to Horizon Connection Server
Write-Output " ", "Connect to the Connection Server" 
Connect-HVServer -Server $conserver -Domain $domain

$pools = (Get-HVPool).base.name

$myCol = @() # Create empty array
ForEach ($pool in $pools) {
        $poolname = Get-HVPool -PoolName $pool
        $row = " " | Select-Object PoolName, Parent, Snapshot 
        $row.PoolName = $pool
        $row.Parent = $poolname.AutomatedDesktopData.VirtualCenterNamesData.ParentVmPath
        $row.Snapshot = $poolname.AutomatedDesktopData.VirtualCenterNamesData.SnapshotPath
        $myCol += $row

    }
Write-Output $myCol | Format-Table -AutoSize

Disconnect-HVServer * -Confirm:$false