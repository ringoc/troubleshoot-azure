# optional parameters
param (
    [string]$subscriptionName = "",
    [string]$resourceGroup = "",
    [string]$vmName = "",
    [string]$path = './report.csv',
    [bool]$debug = $FALSE

)

# clean up existing report file

if (Test-Path $path) { 
    Write-Host "Remove item at $path ..."
    Remove-Item -Path $path 
}

if ($debug) {
    Write-Host "subscriptionName: " $subscriptionName
    Write-Host "resource: " $resourceGroup
    Write-Host "vmName: " $vmName
    Write-Host "path: " $path
}

# construct the subscription ids
$subIds = $subscriptionName -ne "" ? ((Get-AzSubscription -SubscriptionName $subscriptionName | Where-Object {$_.State -ne 'Disabled'}).Id) : ((Get-AzSubscription | Where-Object {$_.State -ne 'Disabled'}).Id)

# loop through all subscriptions 
$resultsAll = @(foreach ($subId in $subIds) {
    # set Az context
    $context = Set-AzContext -Subscription $subID
    $subName = $context.Subscription.Name
    Write-Host "Checking on subscription: $SubName"
    
    # get all VMs
    $vms = ($resourceGroup -ne "" -and $vmName -ne "") ? (Get-AzVM -ResourceGroupName $resourceGroup -Name $vmName) : (Get-AzVM) 
    Write-Host "Name `t`t CreateOption `t`t Status  `t`t VMAgentVersion `t`t OsName"
    $results = @(foreach ($vm in $vms) {
        
        $vmInstanceView = Get-AzVM -ResourceGroup $vm.ResourceGroupName -Name $vm.Name -Status
        $agent = $vmInstanceView | Select -ExpandProperty VMAgent | Select VMAgentVersion
        $status = $vmInstanceView | Select -ExpandProperty Statuses|  Select-Object -Last 1 # last status object indicate vm status
        
        Write-Host $vm.Name "`t`t" $vm.StorageProfile.OsDisk.CreateOption "`t`t" $status.Code  "`t`t" $agent.VMAgentVersion "`t`t" $vmInstanceView.OsName

        # construct the custom object
        [PSCustomObject]@{
            subID = $subID
            subName = $subName
            vmName = $vm.Name
            rgName = $vm.ResourceGroupName
            location = $vm.Location
            vmOsName = $vmInstanceView.OsName
            vmOsType = $vm.StorageProfile.OsDisk.OsType
            vmOsDiskCreateOption = $vm.StorageProfile.OsDisk.CreateOption
            vmStatus = $status.Code
            vmAgentVersion = $agent.VMAgentVersion 
        }
    }) | Export-Csv -Path $path -NoTypeInformation -Append # output csv file with append mode
})
