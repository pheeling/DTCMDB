Using Module "..\ressources\PartnerUserConfiguration.psm1"
Using Module "..\ressources\PartnerCenterAuthentication.psm1"
Using Module "..\ressources\PartnerCenterCustomer.psm1"

$configuration = [PartnerUserConfiguration]::new()

$configuration.createLoginCredentialFile()
$cred = $configuration.setCredentialsFile("..\src\ressources\$($env:USERNAME)_cred.xml") 

$authentication = [PartnerCenterAuthentication]::new()
$response = $authentication.getAADTokenByUser($configuration, $cred)
$accesstoken = $authentication.getSAToken($response)
$customeractions = [PartnerCenterCustomer]::new($accesstoken)

$list = $customeractions.getPCCustomer()

for ($i=0; $i -lt $list.items.Length; $i++){
    Write-host "--------------------------------------------------"
    Write-Host $list.items[$i] 
    Write-host "--------------------------------------------------"
    $customeractions.getPCCustomerBillingProfile($list.items[$i].id) | Write-Host
    Write-host "--------------------------------------------------"
    $customeractions.getPCCustomerLicenceUsage($list.items[$i].id) | Write-Host
    Write-host "--------------------------------------------------"
    $customeractions.getPCCustomerLicenceDeployment($list.items[$i].id) | Write-host
}




