# Set deleteUnattachedVHDs=$true if you want to delete unattached VHDs
# Set deleteUnattachedVHDs=$false if you want to see the Uri of the unattached VHDs
$deleteUnattachedVHDs=$false
# Set targetContainerName to the container where the .vhd is located
$targetContainerName='vhds'

$storageAccounts = Get-AzStorageAccount

foreach($storageAccount in $storageAccounts){
    Write-Output('Processing Storage Account "' + $storageAccount.StorageAccountName + '" ...')
    $storageKey = (Get-AzStorageAccountKey -ResourceGroupName $storageAccount.ResourceGroupName -Name $storageAccount.StorageAccountName)[0].Value
    $context = New-AzStorageContext -StorageAccountName $storageAccount.StorageAccountName -StorageAccountKey $storageKey
    $containers = Get-AzStorageContainer -Context $context
    $containers | Where-Object {$_.Name -eq $targetContainerName} | ForEach-Object  {
        Write-Output('Processing Container "' + $_.Name + '" ...')
        $blobs = Get-AzStorageBlob -Container $_.Name -Context $context
        #Fetch all the Page blobs with extension .vhd as only Page blobs can be attached as disk to Azure VMs
        $blobs | Where-Object {$_.BlobType -eq 'PageBlob' -and $_.Name.EndsWith('.vhd')} | ForEach-Object { 
            #If a Page blob is not attached as disk then LeaseStatus will be unlocked
            Write-Output('Processing Blob "' + $_.Name + ' ...')
            if($_.ICloudBlob.Properties.LeaseStatus -eq 'Unlocked'){
                    if($deleteUnattachedVHDs){
                        Write-Output "Deleting unattached VHD with Uri: $($_.ICloudBlob.Uri.AbsoluteUri)"
                        $_ | Remove-AzStorageBlob -Force
                        Write-Output "Deleted unattached VHD with Uri: $($_.ICloudBlob.Uri.AbsoluteUri)"
                    }
                    else{
                        Write-Output('URI: ' + $_.ICloudBlob.Uri.AbsoluteUri)
                    }
            }
        }
    }
}
