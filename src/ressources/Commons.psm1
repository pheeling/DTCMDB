Using Module "..\model\PartnerCenterModel.psm1"

class Commons {

    setObjectType($item,[String] $type) {
        $item.PSObject.TypeNames.Insert(0, $type)
    }
     
    [Object] formatResult($obj,[String] $type) {
        try 
        {
            if($obj.items)
            {
                foreach($item in $obj.items){
                    $this.setObjectType($item, $type)
                }
                return $obj.items
            }
        }
        catch
        {
            $this.setObjectType($obj, $type)        
            return $obj
        }
    return $obj
    }
}