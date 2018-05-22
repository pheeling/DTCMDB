Using Module "..\ressources\PartnerUserConfiguration.psm1"
Using Module "..\ressources\PartnerCenterAuthentication.psm1"
Using Module "..\ressources\PartnerCenterCustomer.psm1"
Using Module "..\ressources\FreshServiceAssetFactory.psm1"

$configuration = [PartnerUserConfiguration]::new()

#$configuration.createLoginCredentialFile()
$cred = $configuration.setCredentialsFile("..\ressources\$($env:USERNAME)_cred.xml") 

$authentication = [PartnerCenterAuthentication]::new()
$response = $authentication.getAADTokenByUser($configuration, $cred)
$accesstoken = $authentication.getSAToken($response)
$customeractions = [PartnerCenterCustomer]::new($accesstoken)

$FreshServiceFactory = [FreshServiceAssetFactory]::new()

#$customeractions | get-member

$list = $customeractions.getPCCustomer()
$departmentlist = $FreshServiceFactory.createDepartmentList()

for ($i=0; $i -lt $list.Length; $i++){
    Write-host "--------------------------------------------------"
    #$requestId = $list[$i].id
    Write-host "--------------------------------------------------"
    $requestBilling = $customeractions.getPCCustomerBillingProfile($list[$i].id) | 
    Select-Object -Property companyName
    Write-host "--------------------------------------------------"
    <#$customeractions.getPCCustomerLicenceUsage($list[$i].id) | 
    Select-Object -Property productName,licensesActive,licensesQualified |Write-Host
    Write-host "--------------------------------------------------"
    $customeractions.getPCCustomerLicenceDeployment($list[$i].id) | 
    Select-Object -Property productName,licensesDeployed,licensesSold | Write-host#>
    Write-host "--------------------------------------------------"
    #Write-host $customeractions.getPCSubscriptions($list[$i].id)
    Write-host "--------------------------------------------------"

    #Produces errors because on the dev tenant are no service costs
    $requestServiceCosts = $customeractions.getPCServiceCostsByLine($list[$i].id)

    $requestSubscription = $customeractions.getPCSubscriptions($list[$i].id) | 
    Select-Object -Property offerId,offerName,quantity,effectiveStartDate,commitmentEndDate

    $companyId = $departmentlist.Keys | Where-Object { $departmentlist[$_] -eq "$($requestBilling.companyName)" }

    #need to implement deduplicatation routine e.g. if offerId exists do not publish
    foreach ($item in $requestSubscription){
        $unitPriceMatch = $requestServiceCosts -match "$($item.offerId)"
        if ($unitPriceMatch){
            $unitPrice = $unitPriceMatch.unitPrice
        }

        $valuestable =@{
            cmdb_config_item =@{
                name ="$($item.offerName)"
                ci_type_id ="7001248569"
                department_id ="$($companyId)"
                level_field_attributes = @{
                    offerid_7001248569 = "$($item.offerId)"
                    companyname_7001248569 = "$($requestBilling.companyName)"
                    offername_7001248569 = "$($item.offerName)"
                    quantity_7001248569 = "$($item.quantity)"
                    unitprice_7001248569 = "$($unitPrice)"
                    effectivestartdate_7001248569 = "$($item.effectiveStartDate)"
                    commitmentenddate_7001248569 = "$($item.commitmentEndDate)"
                } 
            }
        }
        $FreshServiceFactory.freshServiceAsset.postAzureSubscription($valuestable)
    }
}


                             