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
        $obj += $response.Substring(1) | ConvertFrom-Json
        #return (_formatResult -obj $obj -type "Customer")
        return $obj    
    }    
}
