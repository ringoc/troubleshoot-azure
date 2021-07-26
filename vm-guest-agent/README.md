# Powershell for Azure Guest Agent 

## [az-check-vm-guest-agent-status](https://github.com/ringoc/troubleshoot-azure/blob/main/vm-guest-agent/az-check-vm-guest-agent-status.ps1)
This powershell script can print out information in related to guest agent installation status of all VM across multiple subscriptions. The result is output into CSV file. 
### Usage
`./az-check-vm-guest-agent-status.ps1 -subscriptionId "<sub-id>" -path "./report.cvs" -resourceGroup "<rg>" -vmName "<vm>"`
### Output 
```Remove item at ./report.csv ...
Checking on subscription: <sub-name>
Found VM:  <vm>
```
