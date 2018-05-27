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

$list = $customeractions.getPCCustomer()
$departmentlist = $FreshServiceFactory.createDepartmentList()
$freshServiceAssets = $FreshServiceFactory.createAssetList()
$ciTypesList = $FreshServiceFactory.createCiTypesList()
$freshServiceCiTypeId = $ciTypesList.Keys | Where-Object { $ciTypesList[$_] -eq 'Azure / Office 365 Subscription' }

for ($i=0; $i -lt $list.Length; $i++){
    Write-host "$i start"
    $requestBilling = $customeractions.getPCCustomerBillingProfile($list[$i].id) | 
    Select-Object -Property companyName

    #Produces errors because on the dev tenant are no service costs
    $requestServiceCosts = $customeractions.getPCServiceCostsByLine($list[$i].id)

    $requestSubscription = $customeractions.getPCSubscriptions($list[$i].id) | 
    Select-Object -Property offerId,orderId,offerName,quantity,effectiveStartDate,commitmentEndDate,status,billingCycle

    $companyId = $departmentlist.Keys | Where-Object { $departmentlist[$_] -eq "$($requestBilling.companyName)" }

    foreach ($item in $requestSubscription){
        $unitPriceMatch = $requestServiceCosts | Where-Object {
            $_.orderId -eq "$($item.orderId)" -and $_.offerId -eq "$($item.offerId)"
        }
        
        $freshServiceMatch = $freshServiceAssets | Where-Object { 
            $_.levelfield_values.orderid_7001248569 -eq "$($item.orderId)" -and 
            $_.levelfield_values.offerid_7001248569 -eq "$($item.offerId)" -and
            $_.levelfield_values.companyname_7001248569 -eq $requestBilling.companyName        
        }

        if ($unitPriceMatch){
            $unitPrice = $unitPriceMatch.unitPrice
        }

        $valuestable =@{
            cmdb_config_item =@{
                name ="$($item.offerName)"
                ci_type_id ="$($freshServiceCiTypeId)"
                department_id ="$($companyId)"
                level_field_attributes = @{
                    status_7001248569 = "$($item.status)"
                    offerid_7001248569 = "$($item.offerId)"
                    orderid_7001248569 = "$($item.orderId)"
                    companyname_7001248569 = "$($requestBilling.companyName)"
                    offername_7001248569 = "$($item.offerName)"
                    quantity_7001248569 = "$($item.quantity)"
                    unitprice_7001248569 = "$($unitPrice)"
                    billingcycle_7001248569 = "$($item.billingCycle)"
                    effectivestartdate_7001248569 = "$($item.effectiveStartDate)"
                    commitmentenddate_7001248569 = "$($item.commitmentEndDate)"
                } 
            }
        }
        if($item.status -eq "deleted" -and $freshServiceMatch){
            $FreshServiceFactory.freshServiceAsset.deleteAzureSubscriptionById($freshServiceMatch.display_id)
        } elseif ($item.status -ne "deleted" -and $freshServiceMatch){
            $FreshServiceFactory.freshServiceAsset.putAzureSubscriptionById($freshServiceMatch.display_id,$valuestable)
        } elseif ($item.status -ne "deleted") {
            $FreshServiceFactory.freshServiceAsset.postAzureSubscription($valuestable)
        }
    }
    Write-host "$i done"
}


                             