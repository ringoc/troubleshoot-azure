# optional parameters
param (
    [string]$subscriptionId = "",
    [string]$resourceGroup = "",
    [string]$vmName = "",
    [string]$path = './report.csv'
)

# clean up existing report file
Write-Host "Remove item at $path ..."
Remove-Item -Path $path

# construct the subscription ids
$subIds = $subscriptionId -ne "" ? ((Get-AzSubscription -SubscriptionId $subscriptionId | Where-Object {$_.State -ne 'Disabled'}).Id) : ((Get-AzSubscription | Where-Object {$_.State -ne 'Disabled'}).Id)

# loop through all subscriptions 
$resultsAll = @(foreach ($subId in $subIds) {
    # set Az context
    $context = Set-AzContext -Subscription $subID
    $subName = $context.Subscription.Name
    Write-Host "Checking on subscription: $SubName"
    
    # get all VMs
    $vms = ($resourceGroup -ne "" -and $vmName -ne "") ? (Get-AzVM -ResourceGroupName $resourceGroup -Name $vmName) : (Get-AzVM) 
    $results = @(foreach ($vm in $vms) {
        
        $vmInstanceView = Get-AzVM -Status -ResourceGroup $vm.ResourceGroupName -Name $vm.Name 
        $agent = $vmInstanceView | Select -ExpandProperty VMAgent | Select VMAgentVersion
        $status = $vmInstanceView | Select -ExpandProperty Statuses|  Select-Object -Last 1 # last status object indicate vm status
        
        Write-Host "Found VM: $vm.Name"

        # construct the custom object
        [PSCustomObject]@{
            subID = $subID
            subName = $subName
            vmName = $vm.Name
            rgName = $vm.ResourceGroupName
            location = $vm.Location
            vmOsType = $vm.StorageProfile.OsDisk.OsType
            vmOsDiskCreateOption = $vm.StorageProfile.OsDisk.CreateOption
            vmStatus = $status.Code
            vmAgentVersion = $agent.VMAgentVersion 
        }
    }) | Export-Csv -Path $path -NoTypeInformation -Append # output csv file with append mode
})
