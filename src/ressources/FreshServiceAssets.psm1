Using Module ".\FreshServiceConfiguration.psm1"

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

class FreshServiceAssets 
{
    [PSCredential] $credentials

    FreshServiceAssets([pscredential] $credentials){
        $this.credentials = $credentials
    }

    [Object] getFreshServiceTickets(){
        $url = "https://dinotronic.freshservice.com/helpdesk/tickets.json"
        $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:X" -f $this.credentials.GetNetworkCredential().Password)))
        $headers = @{Authorization="Basic $($base64AuthInfo)"}
        $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose #-ErrorAction SilentlyContinue
        return $response
    }

    [Object] getFreshServiceTickets([String] $page){
        $url = "https://dinotronic.freshservice.com/helpdesk/tickets/filter/all_tickets?format=json&page=$($page)"
        $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:X" -f $this.credentials.GetNetworkCredential().Password)))
        $headers = @{Authorization="Basic $($base64AuthInfo)"}
        $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose #-ErrorAction SilentlyContinue
        return $response
    }

    [Object] getFreshServiceDepartments(){
        $url = "https://dinotronic.freshservice.com/itil/departments.json"
        $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:X" -f $this.credentials.GetNetworkCredential().Password)))
        $headers = @{Authorization="Basic $($base64AuthInfo)"}
        $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose #-ErrorAction SilentlyContinue
        return $response
    }

    [Object] getFreshServiceDepartments([String] $page){
        $url = "https://dinotronic.freshservice.com/itil/departments.json?page=$($page)"
        $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:X" -f $this.credentials.GetNetworkCredential().Password)))
        $headers = @{Authorization="Basic $($base64AuthInfo)"}
        $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose #-ErrorAction SilentlyContinue
        return $response
    }

    [Object] getCITypes(){
        $url = "https://dinotronic.freshservice.com/cmdb/ci_types.json"
        $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:X" -f $this.credentials.GetNetworkCredential().Password)))
        $headers = @{Authorization="Basic $($base64AuthInfo)"}
        $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose #-ErrorAction SilentlyContinue
        return $response
    }

    [Object] getCITypes([String] $page){
        $url = "https://dinotronic.freshservice.com/cmdb/ci_types.json?page=$($page)"
        $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:X" -f $this.credentials.GetNetworkCredential().Password)))
        $headers = @{Authorization="Basic $($base64AuthInfo)"}
        $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose #-ErrorAction SilentlyContinue
        return $response
    }

    [Object] getAllCITypeFields([String] $ciTypeNumber){
        $url = "https://dinotronic.freshservice.com/cmdb/ci_types/$($ciTypeNumber).json"
        $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:X" -f $this.credentials.GetNetworkCredential().Password)))
        $headers = @{Authorization="Basic $($base64AuthInfo)"}
        $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose #-ErrorAction SilentlyContinue
        return $response
    }

    [Object] getAssets(){
        $url = "https://dinotronic.freshservice.com/cmdb/items.json"
        $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:X" -f $this.credentials.GetNetworkCredential().Password)))
        $headers = @{Authorization="Basic $($base64AuthInfo)"}
        $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose #-ErrorAction SilentlyContinue
        return $response
    }

    [Object] getAssets([String] $page){
        $url = "https://dinotronic.freshservice.com/cmdb/items.json?page=$($page)"
        $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:X" -f $this.credentials.GetNetworkCredential().Password)))
        $headers = @{Authorization="Basic $($base64AuthInfo)"}
        $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose #-ErrorAction SilentlyContinue
        return $response
    }

    [Object] getAssetById([int] $id){
        $url = "https://dinotronic.freshservice.com/cmdb/items/$($id).json"
        $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:X" -f $this.credentials.GetNetworkCredential().Password)))
        $headers = @{Authorization="Basic $($base64AuthInfo)"}
        $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose #-ErrorAction SilentlyContinue
        return $response
    }


    [Object] postAzureSubscription([Hashtable] $valuestable){
        $url = "https://dinotronic.freshservice.com/cmdb/items.json"
        $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:X" -f $this.credentials.GetNetworkCredential().Password)))
        $headers = @{Authorization="Basic $($base64AuthInfo)"}
        $json = $valuestable | ConvertTo-Json

        $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "POST" -Body $json #-Debug -Verbose #-ErrorAction SilentlyContinue
        return $response
    }

    [Object] putAzureSubscriptionById([String] $assetId, [Hashtable] $valuestable){
        $url = "https://dinotronic.freshservice.com/cmdb/items/$($assetId).json"
        $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:X" -f $this.credentials.GetNetworkCredential().Password)))
        $headers = @{Authorization="Basic $($base64AuthInfo)"}
        $json = $valuestable | ConvertTo-Json

        $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "PUT" -Body $json #-Debug -Verbose #-ErrorAction SilentlyContinue
        return $response
    }

    [Object] deleteAzureSubscriptionById([String] $assetId){
        $url = "https://dinotronic.freshservice.com/cmdb/items/$($assetId).json"
        $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:X" -f $this.credentials.GetNetworkCredential().Password)))
        $headers = @{Authorization="Basic $($base64AuthInfo)"}

        $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "DELETE" #-Debug -Verbose #-ErrorAction SilentlyContinue
        return $response
    }
    
}