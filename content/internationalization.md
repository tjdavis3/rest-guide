---
title: Internationalization (I18N)
weight: 150
draft: true
---

Textual descriptions part of a resource may need to be offered in the language of a user.

One of following strategies may be chosen for internationalization:

- Do not offer textual descriptions in the API response. Offer them only separate from the data, for example as a dedicated collection resource in the API returning a code list with descriptions. This list can be cached by a client.

- Only include descriptions in a single language, specified by the caller in the `Accept-Language` header.

- Offer descriptions in all applicable languages, i.e. for APIs offered by the Belgian Government in French, Dutch, German and sometimes English as well. This approach is not scalable to high number of languages.
  The descriptions may be filtered by a `lang` query parameter.

## Accept-Language

As for [???](#Media Types), HTTP supports content negotiation for the language used in response content.

Users can inform the server that a specific language is requested by adding the `Accept-Language` HTTP header to each request ([RFC 7231](http://tools.ietf.org/html/rfc7231#section-5.3.5)).

Its value is a language tag ([RFC 5646](https://tools.ietf.org/html/rfc5646)), consisting of a {iso639-1}\[ISO 639-1\] lowercase language code, optionally followed by an uppercase country code indicating a country-specific variant.
Internationalized APIs of Belgian Federal Government organizations MUST also support the variants for the official Belgian languages ending on `-BE`.
Multiple languages may be specified in order of preference.
A wildcard `*` matches any language.

The `Content-Language` response header MUST be used to indicate the language used in the response for internationalized content.

In case the server could not honor any of the requested languages, it SHOULD return a [406 Not Acceptable](#http-406) error.
If the resource supports caching, the `Vary: Accept-Language` MUST be included in the response.

<div class="formalpara-title">

**Request headers**

</div>

    Accept-Language: nl-BE, nl, fr-BE, fr, en, *

<div class="formalpara-title">

**Response headers**

</div>

    Content-Language: nl

## Multi-language descriptions

It may be decided to include all supported translations for descriptions in a resource’s representation.

A multi-language description SHOULD be represented by a JSON object with {iso639-1}\[ISO 639-1\] language codes as property names and the corresponding textual description as values.

An API MAY offer to filter the representation to a single language by using the [reserved query parameter](#query-param-lang) `lang`.

A `LocalizedString` type is defined supporting the three official Belgian languages.

<div class="formalpara-title">

**LocalizedString JSON Schema (from [common-v1.yaml](https://github.com/belgif/openapi-common/blob/master/src/main/swagger/common/v1/common-v1.yaml))**

</div>

``` YAML
LocalizedString:
  description: A description specified in multiple languages
  type: object
  properties:
  fr:
    type: string
  nl:
    type: string
  de:
    type: string
```

<div class="formalpara-title">

**Request**

</div>

`GET /countries/BE`

<div class="formalpara-title">

**Response**

</div>

``` json
"name": {
 "fr": "Belgique",
 "nl": "België",
 "de": "Belgien"
}
```

<div class="formalpara-title">

**Filtering a single language**

</div>

`GET /countries/BE?lang=fr`

``` json
"name": {
 "fr": "Belgique"
}
```
