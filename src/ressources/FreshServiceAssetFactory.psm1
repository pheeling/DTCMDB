Using Module "..\ressources\FreshServiceAssets.psm1"
Using Module "..\ressources\FreshServiceConfiguration.psm1"

class FreshServiceAssetFactory{
    
    [FreshServiceConfiguration] $freshServiceConfiguration
    [FreshServiceAssets] $freshServiceAsset

    FreshServiceAssetFactory(){
        $this.freshServiceConfiguration = [FreshServiceConfiguration]::new()
        $this.freshServiceAsset = [FreshServiceAssets]::new($this.freshServiceConfiguration.setCredentialsFile("..\ressources\${env:USERNAME}_freshservice_cred.xml"))
    }
    
    [Hashtable] createDepartmentList(){
        $departmentGet = $this.freshServiceAsset.getFreshServiceDepartments()
        $pagenumber = 1
        $numberOfDepartments = 0
        $departmentlist =@{}

        while ($departmentGet.Length -ne 0) {
            foreach ($entry in $departmentGet){
                $departmentlist += @{$entry.id = "$($entry.name)"}
            }
            $pagenumber++
            $departmentGet = $this.freshServiceAsset.getFreshServiceDepartments($pagenumber)
        }
    return $departmentlist
    }

    [Hashtable] createCiTypesList(){
        $ciTypesGet = $this.freshServiceAsset.getCITypes()
        $ciTypesList =@{}
        foreach ($item in $ciTypesGet){
            $ciTypesList += @{$item.id = "$($item.label)"}
        }
    return $ciTypesList
    }


}