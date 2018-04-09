Using Module ".\src\ressources\PartnerUserConfiguration.ps1"

class PartnerCenterAuthentication
{
    [object] getAADTokenByUser([PartnerUserConfiguration] $config){
    
        $username = $config.username
        $password = $config.password
        $domain = $config.applicationDomain
        $clientid = $config.clientId
        $resource = $config.resourceUrl
    
        $url  = "https://login.windows.net/{0}/oauth2/token" -f $domain
        $body =         "grant_type=password&"
        $body = $body + "resource=$resource&"
        $body = $body + "client_id=$clientid&"
        $body = $body + "username=$username&"
        $body = $body + "password=$password&"
        $body = $body + "scope=openid"
    
        $response = Invoke-RestMethod -Uri $url -ContentType "application/x-www-form-urlencoded" -Body $body -method "POST" #-Debug -Verbose -Headers $headers
        return $response
    }
}