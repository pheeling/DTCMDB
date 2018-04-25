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

    [Object] getFreshServiceDepartments(){
        $url = "https://dinotronic.freshservice.com/itil/departments.json"
        $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:X" -f $this.credentials.GetNetworkCredential().Password)))
        $headers = @{Authorization="Basic $($base64AuthInfo)"}
        $response = Invoke-RestMethod -Uri $url -Headers $headers -ContentType "application/json" -Method "GET" #-Debug -Verbose #-ErrorAction SilentlyContinue
        return $response
    }
}