class FreshServiceConfiguration 
{
    # Instanced Property
    [String] $urlfreshservice = "https://dinotronic.freshservice.com"

    [PSCredential] setCredentialsFile([String] $credentialsFilePath){
        return Import-Clixml $credentialsFilePath
    }

    createLoginCredentialFile(){
        Get-Credential | Export-Clixml -Path $PSScriptRoot\${env:USERNAME}_freshservice_cred.xml
    }
}