# Remerge reporting API

## Introduction
remerge is an app retargeting platform. In addition to our platform's dashboard and analytical capabilities, customers are able to pull JSON-based reports from the remerge reporting API to their internal BI.

## Request Parameters

name | content | examples | mandatory
:------------ | :------------- | :------------ | :------------
start_date| Starting date of report (YYYY-MM-DD)|2015-10-09| x
end_date|End date of report (YYYY-MM-DD)|2015-10-10| x

## Example Request
curl -H 'Content-Type: application/json' -H 'Accept: application/json' -H "Authorization: Token user_token=\"HJn4OYViZv\", email=\"example@mydomain.com\"" -X POST "https://api.remerge.io/report?start_date=2015-10-10&end_date=2015-10-11"

## Response Fields

name | content | examples
:------------ | :------------- | :------------
timestamp | UTC Timestamp| 2015-10-11T00:00:00.000Z
event.country| RTB Geo Informatiom | DE
event.campaign|Internal Remerge Campaign ID| 42
event.campaign_name|Internal Remerge Campaign Name| test
event.ad|Creative Name| test.jpg
event.impressions|Daily Impression Counter on App.Country.Campaign.Ad Level| 2
event.clicks|Daily Click Counter on App.Country.Campaign.Ad Level| 1
event.app_open_rate | Counted app opens for clciks | 1.0
event.cost| Cost in customer currency on App.Country.Campaign.Ad Level| 0.12
event.conversions|Daily Target Conversion Event Counter on App.Country.Campaign.Ad Level| 1
event.unique_user|Daily unique user counter on App.Country.Campaign.Ad Level|2

## Example Response
results: [{"timestamp":"2015-10-11T00:00:00.000Z","event":{"impressions":2,"audience":"21","app_open_rate":1.0,"clicks":1,"ad":"test.jpg","user_id":2,"conversions":1,"campaign":"42","country":"pl","cost":0.12,"campaign_name":"test "}}]
## Errors

Status | Message | Explanation
:------------ | :------------- | :------------
400| ERROR_INVALID_STARTDATE | An invalid or missing start_date was given as a parameter in the request

