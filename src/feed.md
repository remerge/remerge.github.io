# Remerge product feed specification

## Introduction
remerge does support dynamic creatives. Dynamic creatives contain placeholders which are filled with data that is specific to the user who is seeing the advertisement. Examples are titles, prices, call to actions, deeplinks or images.

## Requirements

### Feed availability

- the feed must be available via http/https (for example on S3) or SFTP
- credentials to access the feed must be supplied to remerge ahead of time

### Feed format

The feed needs to be a CSV file (can be gezipped).

- Unicode (UTF-8) should be used as character set (a byte order mark should not be used)
- the column delimiter should be a comma
- each row must contain the same number of fields
- the csv must contain a header with column names
- column names should be alpha numeric but must begin with a letter
- column names should be can be camel cased or snake cased
- column names are not allowed to include spaces and other special characters
- fields can be quoted (double quotes)
- fields containing a comma or quotes must be quoted

### Feed content

The feed can have many columns but at least one ID column is required. IDs are going to be used to index the product data and are usually provided via a customer specific event (for example has_viewed_product accompanied with the product ID).

- an ID column should exists
- IDs should be alpha numeric
- IDs should be unique

Data duplication or derived data should be avoid in the feed. For example:
- if every deeplink starts with the same prefix, please avoid the prefix
- if the only changing part in a deeplink is the product ID a deeplink column is not needed at all

## Example

```
id,title,price,deeplink
7ZU9HYbj3Y,Diamond sword,15.34, myapp://item/111
gVWVdrqnm7,Metal helmet,7.44,myapp://item/24
N9czkX9WXo,Gloves of magic,122.22,myapp://item/31
```
