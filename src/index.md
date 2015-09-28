# Remerge Tracking API

## Introduction
remerge is a app retargeting platform. To provide updates to audience segments in real time customers who don't use an attributions provider supported by remerge (like [Adjust](http://www.adjust.com)) or have an internal tracking solution, can forward events to the remerge tracking API.
## Endpoint
Two endpoint are available, depending on the location of your servers.

    http://track.eu1.remerge.io/event
    http://track.us1.remerge.io/event

## Request
For every event a GET should be send to one of the given endpoints including the following parameters (in the query string). If the request was successful the API responds with `HTTP 204`.

## Parameters
All mandatory parameters (marked with a **M**) must be provided to allow proper tracking. Optional parameters can be set to improve retargeting and reporting. Parameters which contain characters which are not web safe have to be encoded properly.

name | content | examples
:------------ | :------------- | :------------
app_id (**M**) | iTunes or Google Play Store App ID  | 553834731, com.king.candycrush
event (**M**)| name of the event | purchase, add_to_basket, level_2_reached
data | additional data for the event, can be anything, usually JSON | {"store":1341, "keywords":["yellow","red"]}
value | event value (can be an abritrary properly encoded string) | sock, 41231, 1-0
ts (**M**)| event timestamp as [unix epoch](http://en.wikipedia.org/wiki/Unix_time), timezone should be UTC | 1427976389
partner (**M**)| name of the tracking partner | supergame
key (**M**)| key of the partner (provided by remerge) | x34dlx
idfa (**M**)| [Apple IDFA](https://developer.apple.com/library/prerelease/ios/documentation/AdSupport/Reference/ASIdentifierManager_Ref/index.html#//apple_ref/occ/instp/ASIdentifierManager/advertisingIdentifier) (uppercase) (if a aaid was provided not mandatory)| AEBE52E7-03EE-455A-B3C4-E57283966239
aaid (**M**)| [Android Advertising ID](https://developer.android.com/google/play-services/id.html) (lowercase) (if a idfa was provided not mandatory) | 38400000-8cf0-11bd-b23e-10b96e40000d
country (**M**)| [ISO alpha 2 country code](http://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) (lowercase)| de
device_name (**M**)| Device name | iPad
os_name (**M**)| OS name | android, ios
os_version (**M**)| OS version | 8.0.1
user | customer user id | 4838131
yob | year of birth | 1982
gender | gender (m or f)| m
revenue | revenue in micro currency units (allows sub cent values and avoids float issues)| 170000 (=0.17), 57500000 (=5.75$)
currency | [ISO 4217 currency code](http://en.wikipedia.org/wiki/ISO_4217) | USD
network | if the event is attributes to a partner, the networks name or id | remerge,Facebook
campaign | if the event is attributes to a partner, the campaign name or id | us_retarget_lappsed
ad | if the event is attributes to a partner , the ad name or id | 1231
creative | if the event is attributes to a partner, the creative name or id | super_banner.png
click_id | pass through parameter for the unique ad click id (usually appended to a click tracking url by remerge) | iwShT9ec49



## Example
Example with placeholders (whereas {PLACEHOLDER} should be the name of your internal placeholder)

    http://track.eu1.remerge.io/event?app_id={PLACEHOLDER}&event={PLACEHOLDER}&partner={PLACEHOLDER}&key={PLACEHOLDER}&idfa={PLACEHOLDER}&aaid={PLACEHOLDER}&country={PLACEHOLDER}&device_name={PLACEHOLDER}&os_name={PLACEHOLDER}&os_version={PLACEHOLDER}&user={PLACEHOLDER}&yob={PLACEHOLDER}&gender={PLACEHOLDER}&ts={PLACEHOLDER}&revenue={PLACEHOLDER}&currency={PLACEHOLDER}&network={PLACEHOLDER}&campaign={PLACEHOLDER}&ad={PLACEHOLDER}&creative={PLACEHOLDER}&click_id={PLACEHOLDER}
