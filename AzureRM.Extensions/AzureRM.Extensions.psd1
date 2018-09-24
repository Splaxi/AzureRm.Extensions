@{
    # Script module or binary module file associated with this manifest
    ModuleToProcess   = 'AzureRM.Extensions.psm1'
	
    # Version number of this module.
    ModuleVersion     = '0.1.4'
	
    # ID used to uniquely identify this module
    GUID              = '78de8635-5d5a-41aa-a858-1d3796d22f77'
	
    # Author of this module
    Author            = 'Mötz Jensen'
	
    # Company or vendor of this module
    CompanyName       = 'Essence Solutions'
	
    # Copyright statement for this module
    Copyright         = 'Copyright (c) 2018 Mötz Jensen'
	
    # Description of the functionality provided by this module
    Description       = 'Small toolkit to ease the burden when assigning tags across multiple subscriptions, resource groups and resources'
	
    # Minimum version of the Windows PowerShell engine required by this module
    PowerShellVersion = '5.0'
	
    # Modules that must be imported into the global environment prior to importing
    # this module
    RequiredModules   = @(
        @{ ModuleName = 'PSFramework'; ModuleVersion = '0.9.25.113' },
        @{ ModuleName = 'AzureRm'; ModuleVersion = '6.7.0' }
    )
	
    # Assemblies that must be loaded prior to importing this module
    # RequiredAssemblies = @('bin\AzureRM.Extensions.dll')
	
    # Type files (.ps1xml) to be loaded when importing this module
    # TypesToProcess = @('xml\AzureRM.Extensions.Types.ps1xml')
	
    # Format files (.ps1xml) to be loaded when importing this module
    # FormatsToProcess = @('xml\AzureRM.Extensions.Format.ps1xml')
	
    # Functions to export from this module
    FunctionsToExport = @(
							'Add-AzureRmTagToResource',
							'Add-AzureRmTagToResourceGroup' 

							'Get-AzureRmResourceExt',
							'Get-AzureRmResourceGroupExt',
							'Get-AzureRmSubscriptionExt'
    )
	
    # Cmdlets to export from this module
    CmdletsToExport   = ''
	
    # Variables to export from this module
    VariablesToExport = ''
	
    # Aliases to export from this module
    AliasesToExport   = ''
	
    # List of all modules packaged with this module
    ModuleList        = @()
	
    # List of all files packaged with this module
    FileList          = @()
	
    # Private data to pass to the module specified in ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
    PrivateData       = @{
		
        #Support for PowerShellGet galleries.
        PSData = @{
			
            # Tags applied to this module. These help with module discovery in online galleries.
            Tags         = @('azurerm', 'azure', 'tag')
			
             # A URL to the license for this module.
			 LicenseUri   = "https://opensource.org/licenses/MIT"

			 # A URL to the main website for this project.
			 ProjectUri   = 'https://github.com/Splaxi/AzureRm.Extensions'
			
            # A URL to an icon representing this module.
            # IconUri = ''
			
            # ReleaseNotes of this module
			# ReleaseNotes = ''
			
			# Indicates this is a pre-release/testing version of the module.
            IsPrerelease = 'True'
			
        } # End of PSData hashtable
		
    } # End of PrivateData hashtable
}