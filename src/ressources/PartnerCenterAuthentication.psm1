Using Module ".\PartnerUserConfiguration.psm1"

class PartnerCenterAuthentication
{
    [String] getAADTokenByUser([PartnerUserConfiguration] $config, [pscredential] $cred){
    
        $url  = "https://login.windows.net/{0}/oauth2/token" -f $config.applicationDomain
        $body =         "grant_type=password&"
        $body = $body + "resource=$($config.resourceUrl)&"
        $body = $body + "client_id=$($config.clientId)&"
        $body = $body + "username=$($cred.GetNetworkCredential().UserName)&"
        $body = $body + "password=$($cred.GetNetworkCredential().Password)&"
        $body = $body + "scope=openid"
    
        $response = Invoke-RestMethod -Uri $url -ContentType "application/x-www-form-urlencoded" -Body $body -method "POST" #-Debug -Verbose -Headers $headers
        return $response.access_token
    }

    [String] getSAToken([String] $aadtoken){
    $url  = "https://api.partnercenter.microsoft.com/generatetoken"
	$body = "grant_type=jwt_token"
	$headers=@{Authorization="Bearer $aadtoken"}
    
    try {
        $response = Invoke-RestMethod -Uri $url -ContentType "application/x-www-form-urlencoded" -Headers $headers -Body $body -method "POST" #-Debug -Verbose
        return $response.access_token
    } catch {
        $ErrorMessage = $_.Exception.Message
        "Cannot retrieve the token: $ErrorMessage"
    }
        return $null
    }
}