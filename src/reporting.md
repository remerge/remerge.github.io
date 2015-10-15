# Remerge reporting API

## Introduction
remerge is an app retargeting platform. In addition to our platform's dashboard and analytical capabilities, customers are able to pull JSON-based reports from the remerge reporting API for their currently running campaigns to their internal BI on a daily granularity basis. 

The performance by customer is broken down by the five dimensions timestamp, country, App, campaign and related ads. Therefore, the results can be easly imported and sliced and diced by the provided dimensions in any Business Intelligence platform of the customer's choice. 

The API is accessiable via the following endpoint  *https://api.remerge.io/report*

## Request Parameters

The API provides a simple interface to query data. A start and end date are the only parameters required. 

name | content | examples | mandatory
:------------ | :------------- | :------------ | :------------
start_date| Starting date of report (YYYY-MM-DD)|2015-10-09| x
end_date|End date of report (YYYY-MM-DD)|2015-10-10| x

A valid request would look like: https://api.remerge.io/report?start_date=2015-10-10&end_date=2015-10-11

## Authorization

In addition the requst must be authorized. The following request headers are mandatory. To get the necessary information for the authorization token please contact your remerge Account Manager:

name | content | examples | mandatory
:------------ | :------------- | :------------ | :------------
Request Header | Content-Type | -H 'Content-Type: application/json' | x
Request Header | Acceptance  | -H 'Accept: application/json' | x
Request Header | Authorization Token | -H 'Authorization: Token user_token=\"HJn4OYViZv\", email=\"example@mydomain.com\"'| x
Request Type | POST | -X POST | x

## Example Request

Below is an example *POST* request to the reporting API using the data transfer tool  [curl](http://curl.haxx.se/docs/manpage.html):

```curl -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Token user_token=\"HJn4OYViZv\", email=\"example@mydomain.com\"' -X POST "https://api.remerge.io/report?start_date=2015-10-10&end_date=2015-10-11"```


## Response Fields
The response returns a JSON object containing an results array. Each array element consists of the following fields:

name | content | examples
:------------ | :------------- | :------------
timestamp | UTC Timestamp| 2015-10-11T00:00:00.000Z
event.country| RTB Geo Informatiom | DE
event.campaign|Internal Remerge Campaign ID| 42
event.campaign_name|Internal Remerge Campaign Name| Test Campaign
event.audience | App Store Reference | 12345678
event.ad|Creative Name| test.jpg
event.impressions|Daily Impression Counter on App.Country.Campaign.Ad Level| 2
event.clicks|Daily Click Counter on App.Country.Campaign.Ad Level| 1
event.app_open_rate | Counted app opens for clicks | 1.0
event.cost| Cost in customer currency on App.Country.Campaign.Ad Level| 0.12
event.conversions|Daily Target Conversion Event Counter on App.Country.Campaign.Ad Level| 1
event.unique_user|Daily unique user counter on App.Country.Campaign.Ad Level|2

## Example JSON Response
```{results: [{"timestamp":"2015-10-11T00:00:00.000Z","event":{"impressions":2,"audience":"12345678","app_open_rate":1.0,"clicks":1,"ad":"test.jpg","user_id":2,"conversions":1,"campaign":"42","country":"pl","cost":0.12,"campaign_name":"Test Campaign"}}]}```

## Errors

Status | Message | Explanation
:------------ | :------------- | :------------
200| OK | Query results returend as JSON
422| start_date: Format YYYY-MM-DD required |  Start Date illformated
422| end_date: Format YYYY-MM-DD required |  End Date illformated
422| start_date: must be a valid date | No real date provided, e.g. 2015-33-09
422| end_date: must be a valid date | No real date provided, e.g. 2015-33-09
422| end_date: end date must be greater or equal to the start date | End date is earlier then start date
422| queryID: queryId already exists | User has send already an request which is still processed by the api, i.e query rate limit per user is 1.  
