# AzureRm.Extensions

## **Installation of the module**
The module is hosted on https://www.powershellgallery.com and can therefore be installed by executing the following command:
```
Install-Module AzureRm.Extensions
```
### **Load module** 
```
Import-Module AzureRm.Extensions
```

## **Use the module** 
You will need to connect to Azure via the standard `Connect-AzureRmAccount` cmdlet, before you can use any of the cmdlets from the module.
```
Connect-AzureRmAccount
Get-AzureRmSubscriptionExt
```

### **Update resource groups without tags**
```
Connect-AzureRmAccount
Get-AzureRmSubscriptionExt -Name *DEV* | Get-AzureRmResourceGroupExt -Name "*" -WithoutTagOnly | Add-AzureRmTagToResourceGroup
```

### **Update resource groups without tags**
```
Connect-AzureRmAccount
Get-AzureRmSubscriptionExt -Name *DEV* | Get-AzureRmResourceGroupExt -Name "*" | Add-AzureRmTagToResource -ApplyParentTags
```
