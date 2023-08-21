---
title: Hypermedia controls
weight: 110
---

Thanks to *hypermedia controls* a client can navigate through the REST API without hardcoding URIs to specific resources. It suffices to know a limited set of entry points and navigate to the desired information. This adds *flexibility* to the evolution of the API and increases *loose coupling* between client and server.

## Links

When referencing another resource within the same API, a link SHOULD be added using the `href` attribute.

It is NOT RECOMMENDED to link to resources in other APIs to avoid a tight coupling between the APIs, unless the link target is guaranteed to remain very stable (like the `href` links to standard problem types [???](#rule-err-problem)).

Each resource MAY also contain its own location in a `self` attribute at root level of the JSON document.

URIs SHOULD always be absolute.

<div class="caution">

For brevity, most URIs in the style guide examples are shortened, but in reality URIs should always be absolute.

</div>

All `href` hyperlinks are derived from this minimal link type:

<div class="formalpara-title">

**HttpLink JSON data type (from [common-v1.yaml](https://github.com/tjdavis3/rest-guide/tree/master/content/openapi/common-v1.yaml))**

</div>

{{< readfile file="openapi/schemas/httplink.yaml" code="true" lang="yaml" >}}

`self` hyperlinks are derived from the following type:

<div class="formalpara-title">

**SelfLink JSON data type (from [common-v1.yaml](https://github.com/tjdavis3/rest-guide/tree/master/content/openapi/common-v1.yaml))**

</div>

{{< readfile file="openapi/schemas/selflink.yaml" code="true" lang="yaml" >}}

Links should not be used in request bodies in a PUT, POST or PATCH context, as indicated by the `readOnly: true` property.
In a JSON response, they can be added anywhere.

GET {API}/companies/1

``` json
{
   "self": "{API}/companies/1[/companies/1^]"
   "owner": {
      "ssin": "12345678901",
      "href": "http://example.org/v1/people/12345678901"
   },
   "website": "https://wwww.mycompany.com"
}
```

PATCH {API}/companies/1

``` json
{
   "owner": {
      "ssin": "12345678902"
   },
   "website": "https://wwww.mynewwebsite.com"
}
```

The corresponding JSON data type includes the link types using `allOf`.
As `website` isn’t a reference to another API resource, it is not defined using the `HttpLink` type.

``` YAML
definitions:
  Company:
    allOf:
    - "$ref": "./common/v1/common-v1.yaml#/definitions/SelfLink"
    - type: object
      properties:
        owner:
          "$ref": "#/definitions/PersonReference"
        website:
          type: string
          format: uri
  PersonReference:
    allOf:
      - "$ref": "./common/v1/common-v1.yaml#/definitions/HttpLink"
      - type: object
        properties:
          ssin:
            "$ref": "#/definitions/Ssin"
```

Hyperlinks for [???](#Pagination) inside collections and self-references should use a simple URI value in combination with their corresponding link relations (next, prev, first, last, self) instead of the extensible link type.

``` json
{
   "self": "{API}/companies?page=2&pageSize=10[/companies?page=2&pageSize=10^]",
   "prev": "{API}/companies?page=2&pageSize=1[/companies?page=1&pageSize=10^]",
   "next": "{API}/companies?page=2&pageSize=3[/companies?page=3&pageSize=10^]"
}
```

The use of [Web Linking](https://tools.ietf.org/html/rfc5988) and [Hypertext Application Language (HAL)](https://tools.ietf.org/html/draft-kelly-json-hal-08) is not recommended.
