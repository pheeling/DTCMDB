Using Module ".\PartnerUserConfiguration.psm1"

class PartnerCenterAuthentication
{
    [String] getAADTokenByUser([PartnerUserConfiguration] $config){
    
        $url  = "https://login.windows.net/{0}/oauth2/token" -f $config.applicationDomain
        $body =         "grant_type=password&"
        $body = $body + "resource=$($config.resourceUrl)&"
        $body = $body + "client_id=$($config.clientId)&"
        $body = $body + "username=$($config.userName)&"
        $body = $body + "password=$($config.password)&"
        $body = $body + "scope=openid"
    
        $response = Invoke-RestMethod -Uri $url -ContentType "application/x-www-form-urlencoded" -Body $body -method "POST" #-Debug -Verbose -Headers $headers
        return $response
    }
}