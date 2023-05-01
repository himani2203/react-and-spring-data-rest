Param(
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [String] $ClientSecret,

    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [String] $ClientId,

    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [String] $TenantId,

    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [String] $SubscriptionId,

    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [String] $ResourceGroupName
)

function InitializeAzureSubscription {
    #Login with Azure AD Credential that has Contributor RBAC role
    Write-Host "Connecting to Azure"
    try {

        $SecureStringPwd = "$ClientSecret" | ConvertTo-SecureString -AsPlainText -Force
        $PSCredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $ClientId, $SecureStringPwd
        
        $null = Connect-AzAccount -ServicePrincipal -TenantId $TenantId -Credential $PSCredential -ErrorAction Stop
        Write-Host "Connected to Azure"
        Write-Host "Setting Subscription"
        $null = Select-AzSubscription -SubscriptionId $SubscriptionId -ErrorAction Stop
    }
    catch {
        Write-Host "Failed to set Azure Subscription. Existing"
        StopIteration
        Exit 1
    }
}


InitializeAzureSubscription

Write-Host "Delete Resource Group $ResourceGroupName"
Write-Host "First Delete Resource Group Lock"
Get-AzResourceLock | where ResourceGroupName -EQ $ResourceGroupName | Remove-AzResourceLock –Force
Write-Host "Resource Group Lock is Deleted"
Get-AzResourceGroup -Name $ResourceGroupName | Remove-AzResourceGroup -Force
Write-Host "Resource Group is Deleted and its associated resources"

