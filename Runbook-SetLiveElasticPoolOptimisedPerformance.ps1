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

# Set SQL Elastic Pool to Standard (lower cost than Premium) for off-peak hours
Set-AzSqlElasticPool -ResourceGroupName $DestinationResoureGroupName `
    -ServerName $DestinationServerName `
    -ElasticPoolName $DestinationElasticPoolName  `
    -Edition "Standard" `
    -Dtu "200" `
    -DatabaseDtuMax "200"