Using Module "..\ressources\PartnerUserConfiguration.psm1"

$configuration = [PartnerUserConfiguration]::new()

# $configuration | Get-Member
If ($configuration.userName -eq $null){
    Write-Host "success"
} else {
    Write-Host "failed"
}

$configuration.createLoginCredentialFile()
$configuration.setCredentialsFile(".\src\ressources\${env:USERNAME}_cred.xml")

If ($configuration.userName -eq $null){
    Write-Host "failed"
} else {
    Write-Host "success"
}