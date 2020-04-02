<#
Modification History:
        Ivo Beerens, April 1, 2020: Created

.SYNOPSIS
    Check the GPU hardware acceleration registry keys
.DESCRIPTION
    Check the GPU hardware acceleration registry keys for the following applications:"
        - Office 2016/365
        - Google Chrome
        - Mozilla Firefox
        - Internet Explorer 11
        - Microsoft Edge based on Chromium
.EXAMPLE
    PS C:\> .\CheckHWacceleration.ps1
.INPUTS
    
.OUTPUTS
    
.NOTES
    Change the log variable 
    Author: Ivo Beerens
    Blog:   https://www.ivobeerens.nl
#>

# Variables
$log = 'C:\PowerShell\CheckHWacceleration.txt'
function reg-exist {
    [CmdletBinding()]
    param (
        [string]$regkey,
        [string]$regname
    )
        
    process {
        try {
            Get-ItemPropertyValue -Path $regkey -Name $regname -ErrorAction:SilentlyContinue
        } catch {
            Write-Host "The following regkey: $regkey\$regname is not found" -ForegroundColor Red
        }
    }

}

function reg-check {
    [CmdletBinding()]
    param (
        
    )
    Clear
    Write-Host "Check the GPU hardware acceleration registry keys for the following applications:"
    Write-Host "- Office 2016/365"
    Write-Host "- Google Chrome"
    Write-Host "- Mozilla Firefox"
    Write-Host "- Internet Explorer 11"
    Write-Host "- Microsoft Edge based on Chromium"
    Write-Host "---------------------------------------------------------------"
   
    $win10version = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion").ReleaseId
    Write-Host "Windows 10 version: $win10version" -ForegroundColor Green
    Write-Host "---------------------------------------------------------------"
    Start-Transcript -Path $log -Force | Out-Null
    Write-Host "Microsoft Office 2016/365 GPU hardware acceleration" -ForegroundColor Green
    Write-Host "Value 1 = Disabled"
    # For Office 2013: navigate to HKEY_CURRENT_USER\Software\Microsoft\Office\15.0 Common\Graphics
    # For Office 2016/365: navigate to HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Common\Graphics
    # For Office 2019: navigate to HKEY_CURRENT_USER\Software\Microsoft\Office\18.0\Common\Graphics
    $regkey = "HKCU:\SOFTWARE\Microsoft\office\16.0\Common\Graphics" 
    $regname = "DisableHardwareAcceleration"
    $output = reg-exist $regkey $regname
    Write-Host "Current value:" $output -ForegroundColor Yellow

    Write-Host "---------------------------------------------------------------"
    Write-Host "Google Chrome GPU hardware acceleration" -ForegroundColor Green
    Write-Host "Value 0 = Disabled"
    $regkey = "HKCU:\Software\Policies\Google\Chrome"
    $regname = "HardwareAccelerationModeEnabled"
    $output = reg-exist $regkey $regname
    Write-Host "Current value:" $output -ForegroundColor Yellow

    Write-Host "---------------------------------------------------------------"
    Write-Host "Mozilla Firefox GPU hardware acceleration" -ForegroundColor Green
    Write-Host "Value 0 = Disabled"
    $regkey = "HKCU:\SOFTWARE\Policies\Mozilla\Firefox"
    $regname = "HardwareAcceleration"
    $output = reg-exist $regkey $regname
    Write-Host "Current value:" $output -ForegroundColor Yellow

    Write-Host "---------------------------------------------------------------"
    Write-Host "Internet Explorer 11 GPU hardware acceleration" -ForegroundColor Green
    Write-Host "Value 1 = Disabled"
    $regkey = "HKCU:\SOFTWARE\Microsoft\Internet Explorer\Main"
    $regname = "UseSWRender"
    $output = reg-exist $regkey $regname
    Write-Host "Current value:" $output -ForegroundColor Yellow

    Write-Host "---------------------------------------------------------------"
    Write-Host "Microsoft Edge based on Chromium GPU hardware acceleration" -ForegroundColor Green
    Write-Host "Value 0 = Disabled"
    $regkey = "HKCU:\SOFTWARE\Policies\Microsoft\Edge"
    $regname = "HardwareAccelerationModeEnabled"
    $output = reg-exist $regkey $regname
    Write-Host "Current value:" $output -ForegroundColor Yellow
    Write-Host "---------------------------------------------------------------"

    Stop-Transcript
}

reg-check