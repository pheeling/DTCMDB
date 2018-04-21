Using Module ".\Commons.psm1"

class PartnerCenterCustomer{

    [String] $satoken
    [Commons] $commonactions

    PartnerCenterCustomer([String] $satoken){
        $this.satoken = $satoken
        $this.commonactions = [Commons]::new()
    }

    [Object] getPCCustomer(){
        #$obj = @()
        $url = "https://api.partnercenter.microsoft.com/v1/customers"
        $headers = @{Authorization="Bearer $($this.satoken)"}
        $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-ErrorAction SilentlyContinue #-Debug -Verbose  
        $obj += $response.Substring(1) | ConvertFrom-Json
        return $this.commonactions.formatResult($obj,"Customer")
    }
    
    [Object] getPCCustomerLicenceUsage([String] $tenantid){
        $url = "https://api.partnercenter.microsoft.com/v1/customers/$($tenantid)/analytics/licenses/usage" #-f $tenantid
        $headers = @{Authorization="Bearer $($this.satoken)"}
        $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-ErrorAction SilentlyContinue #-Debug -Verbose
        $obj = @() + $response.Substring(1) | ConvertFrom-Json
        return $this.commonactions.formatResult($obj,"CustomerLicensesUsageInsights")     
    }

    [Object] getPCCustomerLicenceDeployment([String] $tenantid){
        $url = "https://api.partnercenter.microsoft.com/v1/customers/$($tenantid)/analytics/licenses/deployment" #-f $tenantid
        $headers = @{Authorization="Bearer $($this.satoken)"}
        $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-ErrorAction SilentlyContinue #-Debug -Verbose
        $obj = @() + $response.Substring(1) | ConvertFrom-Json
        return $this.commonactions.formatResult($obj,"CustomerLicensesDeploymentInsights")      
    }

   [Object] getPCCustomerBillingProfile([String] $tenantid){
        #$obj = @()
        $url = "https://api.partnercenter.microsoft.com/v1/customers/$($tenantid)/profiles/billing" #-f $tenantid
        $headers = @{Authorization="Bearer $($this.satoken)"}
        $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-ErrorAction SilentlyContinue #-Debug -Verbose
        $obj += $response.Substring(1) | ConvertFrom-Json
        return $this.commonactions.formatResult($obj,"Profile") 
   }

}
