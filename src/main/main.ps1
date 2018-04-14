Using Module "..\ressources\PartnerUserConfiguration.psm1"
Using Module "..\ressources\PartnerCenterAuthentication.psm1"
Using Module "..\ressources\PartnerCenterCustomer.psm1"

$configuration = [PartnerUserConfiguration]::new()

#$configuration.createLoginCredentialFile()
$cred = $configuration.setCredentialsFile("..\ressources\$($env:USERNAME)_cred.xml") 

$authentication = [PartnerCenterAuthentication]::new()
$response = $authentication.getAADTokenByUser($configuration, $cred)
$accesstoken = $authentication.getSAToken($response)
$customeractions = [PartnerCenterCustomer]::new($accesstoken)

#$customeractions | get-member

$list = $customeractions.getPCCustomer()

for ($i=0; $i -lt $list.Length; $i++){
    Write-host "--------------------------------------------------"
    Write-Host $list[$i].id
    Write-host "--------------------------------------------------"
    $customeractions.getPCCustomerBillingProfile($list[$i].id) | Write-Host
    Write-host "--------------------------------------------------"
    $customeractions.getPCCustomerLicenceUsage($list[$i].id) | Write-Host
    Write-host "--------------------------------------------------"
    $customeractions.getPCCustomerLicenceDeployment($list[$i].id) | Write-host
}




                             