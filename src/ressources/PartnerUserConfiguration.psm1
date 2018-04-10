class PartnerUserConfiguration 
{
    # Instanced Property
    [String] $partnerServiceApiRoot = "https://api.partnercenter.microsoft.com"
    [String] $authority = "https://login.windows.net/"
    [String] $resourceUrl = "https://api.partnercenter.microsoft.com"
    [String] $clientId = "ef965141-5b55-4720-b369-7212b7e6b3cf"
    [String] $applicationDomain = "horgendevelopment.onmicrosoft.com"
    [String] $commonDomain = "common"

    [PSCredential] setCredentialsFile([String] $credentialsFilePath){
        return Import-Clixml $credentialsFilePath
    }

    createLoginCredentialFile(){
        Get-Credential | Export-Clixml -Path $PSScriptRoot\${env:USERNAME}_cred.xml
    }
}