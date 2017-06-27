# Remerge reporting API

## Introduction
remerge is an app retargeting platform. In addition to our platform's dashboard and analytical capabilities, customers are able to pull JSON-based reports from the remerge reporting API for their currently running campaigns to their internal BI on a daily granularity basis.

The performance by customer is broken down by the following five dimensions: timestamp, country, App, campaign and related ads. Therefore, the results can be easly imported and sliced and diced by the provided dimensions in any Business Intelligence platform of the customer's choice.

## Endpoint

The API is accessible via the following endpoint:

      https://api.remerge.io/report

## Request Parameters

The API provides a simple interface to query data. A start and end date are the only parameters required.

name | content | examples | mandatory
:------------ | :------------- | :------------ | :------------
start_date| Starting date of report (YYYY-MM-DD)|2017-01-09| x
end_date|End date of report (YYYY-MM-DD)|2017-01-10| x
dimensions|Comma seperated list of dimensions to split the aggregates by. Defaults to _audience,country,campaign,ad_ if not passed. Possible values are _audience, country, campaign, ad, platform_.|country,platform| 

A valid request would look like: https://api.remerge.io/report?start_date=2017-01-10&end_date=2017-01-11&dimensions=campaign,ad

## Authorization

In addition the request must be authorized. To get the necessary information for the authorization token please contact your remerge Account Manager or issue a sign in request to api.remerge.io.

Sign in request example.

```curl -H 'Content-Type: application/json' -H 'Accept: application/json' -X POST htd '{"user" : { "email" : "your@email.com", "password": "password"}}'```

Which returns the needed token as JSON.

```{"email":"your@email.com","token":"J-QeJxyza7JH19QUDb4","user_id":1234,"user_name":"Peter Example","user_token":"J-QeJ49Yasdf219QUDb4"}```


The following request headers are mandatory for to make a valid reporting request.

name | content | examples | mandatory
:------------ | :------------- | :------------ | :------------
Request Header | Content-Type | 'Content-Type: application/json' | x
Request Header | Acceptance  | 'Accept: application/json' | x
Request Header | Authorization Token | 'Authorization: Token user_token="HJn4OYViZv", email="example@mydomain.com"'| x
Request Type | POST | POST | x

## Example Request

Below is an example *POST* request to the reporting API using the data transfer tool  [curl](http://curl.haxx.se/docs/manpage.html):

```curl -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Token user_token="HJn4OYViZv", email="example@mydomain.com"' -X POST "https://api.remerge.io/report?start_date=2017-01-10&end_date=2017-01-11" -v```


## Response Fields

The response returns a JSON object containing an results array and an element count. Each array element consists of the following fields:

name | content | examples
:------------ | :------------- | :------------
timestamp | UTC Timestamp| 2017-01-11T00:00:00.000Z
event.platform|Platform which can be ios or android|ios|
event.country| RTB Geo Informatiom | de
event.campaign|Internal Remerge Campaign ID| 42
event.campaign_name|Internal Remerge Campaign Name| Test Campaign
event.cost_currency|Internal Remerge Campaign Currency|EUR
event.audience | App Store Reference | 12345678
event.ad|Creative Name| test.jpg
event.impressions|Daily Impression Counter on App.Country.Campaign.Ad Level| 2
event.clicks|Daily Click Counter on App.Country.Campaign.Ad Level| 1
event.app_open_rate | Counted app opens for clicks | 1.0
event.cost| Cost in customer currency on App.Country.Campaign.Ad Level| 0.12
event.conversions|Daily Target Conversion Event Counter on App.Country.Campaign.Ad Level| 1
event.unique_user|Daily unique user counter on App.Country.Campaign.Ad Level|2

## Example JSON Response
```{results: [{"timestamp":"2017-01-11T00:00:00.000Z","event":{"impressions":2,"audience":"12345678","app_open_rate":1.0,"clicks":1,"ad":"test.jpg","user_id":2,"conversions":1,"campaign":"42","country":"de","cost":0.12,"campaign_name":"Test Campaign"}}],count:1}```

If there exists no data for the given interval the request will return an empty results array and count: 0

## Facebook

Reporting for Facebook campaigns must be retrieved separately from programmatic campaigns. The request and response formats are the same, but there are a slightly different set of request parameters and response fields.

### Request Parameters

name | content | examples | mandatory
:------------ | :------------- | :------------ | :------------
start_date | Starting date of report (YYYY-MM-DD) | 2017-01-09 | x
end_date | End date of report (YYYY-MM-DD) | 2017-01-10 | x
supply_source | Must be set to _facebook_ | facebook| x

### Response Parameters

name | content | examples
:------------ | :------------- | :------------
timestamp | ISO8601 Timestamp | 2017-01-11T00:00:00-07:00
event.fb_campaign_id | Facebook campaign ID | 8459561396106
event.fb_campaign_name | Facebook campaign name | remerge_123_facebook_test
event.cost | Cost in USD | 0.12
event.reengagements | The number of people who took an action that was attributed to this campaign | 1

## Errors

Status | Message | Explanation
:------------ | :------------- | :------------
200| OK | Query results returned as JSON
401| Unauthorized | The provided Authorization token was invalid
422| start_date: Format YYYY-MM-DD required | Start Date illformated
422| end_date: Format YYYY-MM-DD required | End Date illformated
422| start_date: must be a valid date | No real date provided, e.g. 2015-33-09
422| end_date: must be a valid date | No real date provided, e.g. 2015-33-09
422| end_date: end date must be greater or equal to the start date | End date is earlier then start date
422| queryID: queryId already exists | User has send already an request which is still processed by the api, i.e query rate limit per user is 1.
504| Gateway Timeout | The request took to long for the webserver to process. This is typically due to a too broad query interval, please try again with an interval of at most 14 days.
