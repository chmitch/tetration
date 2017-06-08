﻿#Login-AzureRmAccount

#You'll need to change this to be the name of your subscription
$subscription = "Microsoft Azure Internal Consumption"

#this prefix is used to help make names of vms storage accounts etc unique.  Keep if 5 characters or less.
$envPrefixName = "cgmtet" 
$username = "amadmin"
$rgname = $envPrefixName + "rg"

$location = "East US"
$virtualNetworkName = $enfPrefixName + "vnet"
$virtualNetworkExistingRGName = $rgname
$virtualNetworkAddressPrefix = "10.1.0.0/24"
$vnetNewOrExisting = "new"
$subnetPrefix = "10.1.0.0/24"
$subnetName = "tetsubnet"
$subnetStartAddress = "10.1.0.1"
$adminUsername = "tetadmin"
#note put a real password in here
$adminPassword = "" | ConvertTo-SecureString -AsPlainText -Force     
$sshPublicKey = ""
$authenticationType = "password"
$vmName = $envPrefixName + "orch"
$newStorageAccountName = $envPrefixName + "stor"
$storageAccountType = "Standard_LRS"
$storageAccountNewOrExisting ="new"
$storageAccountExistingRG = $rgname
$publicIPAddressName = $envPrefixName + "pubip"
$publicIPDnsName =  $envPrefixName + "dns"
$publicIPNewOrExisting = "new"
$publicIPExistingRGName = ""
$baseUrl = "https://raw.githubusercontent.com/chmitch/tetration/master" 
$vmSize = "Standard_DS2_v2"

#-TemplateUri https://raw.githubusercontent.com/chmitch/tetration/master/mainTemplate.json `
#-TemplateFile C:\projects\tetration\mainTemplate.json `
New-AzureRmResourceGroup -Name $rgname -Location $location
    
New-AzureRmResourceGroupDeployment `
    -ResourceGroupName $rgname  `
    -TemplateUri https://raw.githubusercontent.com/chmitch/tetration/master/mainTemplate.json `
    -location $location `
    -virtualNetworkName $virtualNetworkName `
    -virtualNetworkExistingRGName $virtualNetworkExistingRGName `
    -vnetNewOrExisting $vnetNewOrExisting `
    -subnetPrefix $subnetPrefix `
    -subnetName $SubnetName `
    -subnetStartAddress $subnet1StartAddress `
    -adminUsername $adminUsername `
    -newStorageAccountName $newStorageAccountName `
    -storageAccountType $storageAccountType `
    -storageAccountNewOrExisting $storageAccountNewOrExisting `
    -storageAccountExistingRG $rgname `
    -authenticationType $authenticationType `
    -publicIPAddressName $publicIPAddressName `
    -publicIPDnsName $publicIPDnsName `
    -publicIPNewOrExisting $publicIPNewOrExisting `
    -publicIPExistingRGName $publicIPExistingRGName `
    -vmSize $vmSize -baseUrl $baseUrl -adminPassword $adminPassword -vmName $vmName
    