# Project Details

## Title

Quick scripts to be run inside an Azure Automation Account which can decrease the spec of an SQL Elastic Pool for off-peak hours, then increase the spec ready for peak hours.

## Description

A typical public website request pattern might look something like below; weekday 09:00-21:00 peak, weekday 21:00-06:00 off-peak, and anytime weekends off-peak. Leveraging the public cloud there are many ways you can scale the frontend compute resources to handle the varying load, but there is also the option of scaling your backend database resource if using Azure SQL Elastic Pools.

With a couple of quick scripts running inside an Azure Automation Account you can decrease the spec for off-peak hours, then increase the spec ready for peak hours. Taking it one step further you could resize based on the input from metrics rather than a preconfigured schedule. 

Cost saving example:
* Baseline Premium 250 DTU 24x7x4 = £1,176 p/m
* Optimized Premium 250 DTU 15x5x4, Standard 200 DTU 9x5x4, Standard 200 DTU 24x2x4 = £737 p/m
* Optimized Premium 250 DTU 15x5x4, Standard 100 DTU 9x5x4, Standard 100 DTU 24x2x4 = £629 p/m


![Web Requests Diagram](https://github.com/cbchalmers/Azure-PaaS-Sql-ElasticPool-Resize-Automation/blob/master/diagrams/web_requests.JPG)

### Prerequisites

* [Azure Automation Account](https://docs.microsoft.com/en-us/azure/automation/automation-intro)

### Installing Inside Azure Automation Account

* Import Modules (Shared Resources > Modules)
    * Az.Accounts
    * Az.Sql
* Create Run as Accounts (Account Settings > Run as accounts)
    * Azure Run as Account
* Create Schedules
    * Weekly-Mon,Tue,Wed,Thu,Fri-0600
    * Weekly-Tue,Wed,Thu,Fri-2100
* Create Runbooks
    * SetLiveElasticPoolNormalPerformance
        * Content from Runbook-SetLiveElasticPoolNormalPerformance.ps1
        * Schedule as Weekly-Mon,Tue,Wed,Thu,Fri-0600
    * SetLiveElasticPoolOptimisedPerformance
        * Content from Runbook-SetLiveElasticPoolOptimisedPerformance.ps1
        * Schedule as Weekly-Tue,Wed,Thu,Fri-2100

## References

* [Az.Accounts Module](https://docs.microsoft.com/en-us/powershell/module/az.accounts/)
* [Az.Sql Module](https://docs.microsoft.com/en-us/powershell/module/az.sql/)

## Authors

Chris Chalmers - [LinkedIn](https://uk.linkedin.com/in/chris-chalmers), [Azure DevOps](https://dev.azure.com/cbchalmers/Personal%20Development), [GitHub](https://github.com/cbchalmers)