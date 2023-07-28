## Defender - Add Blocked Senders to Anti-Spam Policy
## This script is mainly used for multiple senders, if you are uploading one - go through the portal and modify there :)
## Written by Jack Buttle

## Install Necessary Modules if not installed
if (-not (Get-Module -Name ExchangeOnlineManagement -ListAvailable)) {
    Install-Module -Name ExchangeOnlineManagement -Force -AllowClobber
}

## Import the module & connect to Exchange Online
Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline

## Get existing block list
$currentBlockedSenders = Get-HostedContentFilterPolicy | Select-Object -ExpandProperty BlockedSenders
$newBlockedSenders = @()

## Prompt for new blocked senders
$blockedSenders = Read-Host "Enter the new blocked senders (comma-seperated)"

## Split the blocked senders into an array
$newBlockedSenders = $blockedSenders.Split(",")

## Append the new blocked senders to the existing list
$updatedBlockedSenders = $currentBlockedSenders + $newBlockedSenders

## Remove duplicates from the updated list
$updatedBlockedSenders = $updatedBlockedSenders | Select-Object -Unique

## Update the blocked senders list in the default content filter policy
Set-HostedContentFilterPolicy -Identity "Default" -BlockedSenders $updatedBlockedSenders

## Display the new list
Write-Host "Updated Blocked Senders": $updatedBlockedSenders

## Disconnect from the session
Disconnect-ExchangeOnline