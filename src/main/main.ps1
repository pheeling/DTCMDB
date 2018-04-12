Using Module "..\ressources\PartnerUserConfiguration.psm1"
Using Module "..\ressources\PartnerCenterAuthentication.psm1"
Using Module "..\ressources\PartnerCenterCustomer.psm1"

$configuration = [PartnerUserConfiguration]::new()

$configuration.createLoginCredentialFile()
$cred = $configuration.setCredentialsFile("..\src\ressources\${env:USERNAME}_cred.xml")

$authentication = [PartnerCenterAuthentication]::new()
$response = $authentication.getAADTokenByUser($configuration, $cred)
$accesstoken = $authentication.getSAToken($response)
$customerlist = [PartnerCenterCustomer]::new($accesstoken)
$list = $customerlist.getPCCustomer()

$list.items | Write-Host




