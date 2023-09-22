<#
    .DESCRIPTION Function to download and extract the latest Packer, Terraform and Vault version from Hashicorp
    .NOTES Author:  Ivo Beerens
    .NOTES Site:    www.ivobeerens.nl
    .NOTES Version: 1.0
    .NOTES Changed: September 10, 2023 
    .NOTES Reason:  Creation
#>

#Enable TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
#Speed up the Invoke-Webrequest command
$ProgressPreference = 'SilentlyContinue'

#Variables
$temp_folder = "c:\install\" #Temp download location 
$hashicorp_destination = "c:\install\hashicorp\" #Path for storing the Hashicorp binaries

#Check if the temp folder exist
If(!(test-path -PathType container $hashicorp_destination )) {
    New-Item -ItemType Directory -Path $hashicorp_destination 
}

#Jump to download folder
Set-Location $hashicorp_destination 

Function Download-Hashicorp {
    param (
      [string]$product,
      [string]$url
     )
     try {
        Write-Host "............ Download $product from Hashicorp ............" -ForegroundColor Green
        $urls = Invoke-WebRequest -Uri $url| Select-Object -Expand links | Where-Object href -match "//releases\.hashicorp\.com/$product/\d.*/$product_.*_windows_amd64\.zip$" | Select-Object -Expand href
        $filename = $urls | Split-Path -Leaf
        $download = $temp_folder + $filename
        #Download Hashicorp bits
        Invoke-WebRequest $urls -outfile $download
        #Expand archive
        Write-Host "............ Expand $product archive to binary ............" -ForegroundColor Yellow
        Expand-Archive $download -DestinationPath $hashicorp_destination -Force
        Write-Host "............ Remove $product archive download............" -ForegroundColor Blue
        #Remove download
        Remove-Item $download
     }
     catch {
        Write-Host "An error occurred while downloading or extracting $product" -ForegroundColor Red
        throw $_.Exception.Message
     } 
  }

#Download Packer, Vault and Terraform 
$products = @{
    'packer' = 'https://developer.hashicorp.com/packer/downloads'
    'vault' = 'https://developer.hashicorp.com/vault/downloads'
    'terraform' = 'https://developer.hashicorp.com/terraform/downloads'
}

foreach ($product in $products.GetEnumerator()) {
    Download-Hashicorp -product $product.Name -url $product.Value
}

#Add Hashicorp binary folder to system path
Write-Host "............ Add folder to path ............" -ForegroundColor Green
[Environment]::SetEnvironmentVariable("PATH", $Env:PATH + ";" + $hashicorp_destination, [EnvironmentVariableTarget]::User)
Write-Host "Please restart your PowerShell session for the changes to take effect." -ForegroundColor Yellow
