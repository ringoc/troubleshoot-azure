$resultsAll = @(foreach ($subId in $subIds = (Get-AzSubscription | Where-Object {$_.State -ne 'Disabled'}).Id) {
    $context = Set-AzContext -Subscription $subID
    $subName = $context.Subscription.Name
    Write-Host "Working on $SubName"
    $results = @(foreach ($vm in $vms = Get-AzVM) {
        $vmInstanceView = Get-AzVM -Status -ResourceGroup $vm.ResourceGroupName -Name $vm.Name 
        $agent = $vmInstanceView | Select -ExpandProperty VMAgent | Select VMAgentVersion
        $status = $vmInstanceView | Select -ExpandProperty Statuses|  Select-Object -Last 1 

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
    }) | Export-Csv -Path .\report.csv -NoTypeInformation -Append
})
