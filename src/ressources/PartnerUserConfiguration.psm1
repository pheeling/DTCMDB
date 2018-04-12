class PartnerUserConfiguration 
{
    # Instanced Property
    [String] $partnerServiceApiRoot = "https://api.partnercenter.microsoft.com"
    [String] $authority = "https://login.windows.net/"
    [String] $resourceUrl = "https://api.partnercenter.microsoft.com"
    [String] $clientId = "301a8dcb-2861-4831-a4ca-629a59ed6a4f"
    [String] $applicationDomain = "horgendevelopment.onmicrosoft.com"
    [String] $tenantId = "a68b5c42-3ac0-41dd-9e96-8c360287aebd"
    [String] $commonDomain = "common"

    [PSCredential] setCredentialsFile([String] $credentialsFilePath){
        return Import-Clixml $credentialsFilePath
    }

    createLoginCredentialFile(){
        Get-Credential | Export-Clixml -Path $PSScriptRoot\${env:USERNAME}_cred.xml
    }
}