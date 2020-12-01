# Load the Run as Connection
$Connection = Get-AutomationConnection -Name AzureRunAsConnection

# Login to Azure Account with Service Principal identity
$Account = Connect-AzAccount `
     -ServicePrincipal `
     -Tenant $Connection.TenantID `
     -ApplicationId $Connection.ApplicationID `
     -CertificateThumbprint $Connection.CertificateThumbprint

$DestinationResoureGroupName = "CC-P-UKW-SQL-DATABASE-SERVICES-rg"
$DestinationServerName = "CC-P-UKW-SQL01"
$DestinationElasticPoolName = "CC-P-UKW-SQL-elasticpool"

# Set SQL Elastic Pool to Premium (higher cost than Standard) for peak hours
Set-AzSqlElasticPool -ResourceGroupName $DestinationResoureGroupName `
    -ServerName $DestinationServerName `
    -ElasticPoolName $DestinationElasticPoolName  `
    -Edition "Premium" `
    -Dtu "125" `
    -DatabaseDtuMax "125"