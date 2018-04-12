class PartnerCenterCustomer{

    [String] $satoken

    PartnerCenterCustomer([String] $satoken){
        $this.satoken = $satoken
    }

    [Object] getPCCustomer(){
        $obj = @()
        $url = "https://api.partnercenter.microsoft.com/v1/customers"
        $headers = @{Authorization="Bearer $($this.satoken)"}

        $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose  
        return $response.Substring(1) | ConvertFrom-Json 
    }
    
    [Object] getPCCustomerLicenceUsage([String] $tenantid){
        $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/analytics/licenses/deployment" -f $tenantid
        $headers = @{Authorization="Bearer $($this.satoken)"}

        $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
        #$obj = @() + $response.Substring(1) | ConvertFrom-Json
        return $response.Substring(1) | ConvertFrom-Json
    }

    [Object] getPCCustomerLicenceDeployment([String] $tenantid){
        $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/analytics/licenses/deployment" -f $tenantid
        $headers = @{Authorization="Bearer $($this.satoken)"}

        $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
        #$obj = @() + $response.Substring(1) | ConvertFrom-Json
        return @() + $response.Substring(1) | ConvertFrom-Json      
    }

   [Object] getPCCustomerBillingProfile([String] $tenantid){
        $obj = @()
        $url = "https://api.partnercenter.microsoft.com/v1/customers/{0}/profiles/billing" -f $tenantid
        $headers = @{Authorization="Bearer $($this.satoken)"}

        $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose
        #$obj += $response.Substring(1) | ConvertFrom-Json
        return $response.Substring(1) | ConvertFrom-Json
   }

}
