Using Module "..\ressources\PartnerUserConfiguration.psm1"
Using Module "..\ressources\PartnerCenterAuthentication.psm1"

$configuration = [PartnerUserConfiguration]::new()

$configuration.createLoginCredentialFile()
$cred = $configuration.setCredentialsFile("..\src\ressources\${env:USERNAME}_cred.xml")

#$configuration | Get-Member

$authentication = [PartnerCenterAuthentication]::new()
$response = $authentication.getAADTokenByUser($configuration, $cred)
$accesstoken = $authentication.getSAToken($response)

write-host $accesstoken



