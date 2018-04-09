class PartnerUserConfiguration 
{
    # Instanced Property
    [object] $credentialsFile
    [String] $partnerServiceApiRoot = "https://api.partnercenter.microsoft.com"
    [String] $authority = "https://login.windows.net/"
    [String] $userName = $this.$credentialsFile.userName
    [String] $password = $this.$credentialsFile.password
    [String] $resourceUrl = "https://api.partnercenter.microsoft.com"
    [String] $clientId = "301a8dcb-2861-4831-a4ca-629a59ed6a4f"
    [String] $applicationDomain = "horgendevelopment.onmicrosoft.com"
    [String] $commonDomain = "common"

    setCredentialsFile([String] $credentialsFilePath){
        $this.credentialsFile =  Import-Clixml $credentialsFilePath;
    }

    createLoginCredentialFile(){
        Get-Credential | Export-Clixml -Path $PSScriptRoot\${env:USERNAME}_cred.xml
    }
}