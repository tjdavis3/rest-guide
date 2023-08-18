---
title: Document
weight: 43
---

A document resource is a *singular concept* that is referring to a business entity or object instance. A document’s state representation typically includes both *fields with values* and [*links*](#links) to other related resources.

`GET {API}/employers/93017373[^]`

``` json
{
  "name": "Belgacom",
  "employerId": 93017373,
  "company": {
    "enterpriseNumber": "0202239951",
    "href": "{API}/companies/0202239951[^]"
  },
  "self": "{API}/employers/93017373[^]"
}
```

**Child resources**

A document may have *child resources* that represent its specific subordinate concepts. Most document resources are contained in a *parent [collection resource](#Collection)* and define a **variable path segment with identity key**.

![collection](collection.png)

When defining child resources, stick to concepts *within the same API*. An employer resource could contain child concepts as employees, debts, taxes, mandates, declarations, risks, but putting all these different concepts below a single document resource becomes unmanageable.
In that case **prefer associations and create [links](#links)** to other APIs from the employer resource.

## Identifier

The *identity key* of a document resource is preferably a *natural business identifier* uniquely identifying the business resource like an ISBN or SSIN. If such key does not exist, a *surrogate or technical key* can be created.

New types of identifiers should be designed carefully. Once an identifier has been introduced, it may get widespread usage in various systems even beyond the scope for which it was initially designed, making it very hard to change its structure later on.

Designing identifiers in a URI structure, as specified in the [ICEG URI standard](https://github.com/belgif/thematic/blob/master/URI/iceg_uri_standard.md), is useful as it makes the identifier context-independent and more self-descriptive. A REST API may choose to use a shorter API-local form of a URI identifier because of practical considerations.

When designing an identifier, various requirements may be of importance specific to the use case:

- the governance and lifecycle of identifiers and the entities they represent

- easy to memorize (e.g. textual identifier like problem types)

- input by user (e.g. web form, over phone/mail)

  - easy to type (ignore special separator chars, difference between lower/capital case), limited length

  - validation of typing errors, e.g. by checksum, fixed length, …​

  - hint on format to recognize purpose of identifier based on its value

- printable (restricted length)

- open to evolve structure for new use cases

- ability to generate identifiers collision-free at multiple independent sources, e.g. by adding a source-specific prefix, using UUIDs, …​

- stable across different deployment environments (e.g. problem type codes)

- hide any business information (e.g. no sequential number that indicates number of resources created)

- not easy to guess a valid identifier, especially for unsecured resources (e.g. no sequentially generated identifier)

- easy to represent in URL parameter without escaping

- sortable (for technical reasons e.g. pagination)

For new identifiers, a string based format SHOULD be used: textual lowerCamelCase string codes, [UUID](http://tools.ietf.org/html/rfc4122), URI or other custom formats. Take into account the requirements that follow from the ways the identifier will be used.

Each identifier MUST be represented by only one single string value, so that a string equality check can be used to test if two identifiers are identical. This means that capitalization, whitespace or leading zeroes are significant.

In the OpenAPI data type for the identifier, a regular expression may be specified if helpful for input validation or as hint of the structure (e.g. to avoid whitespace or wrong capitalization), but shouldn’t be too restrictive in order to be able to evolve the format.

No business meaning SHOULD be attributed to parts of the identifier. This should be captured in separate data fields. Parts with technical meaning like a checksum are allowed.

<div class="note">

Parts of an identifier may carry some business meaning for easier readability, like the problem type identifiers in this guide, but no application logic should parse and interpret these parts.

</div>

<div class="warning">

Don’t use database-generated keys as identity keys in your public API to avoid tight coupling between the database schema and API. Having the key independent of all other columns insulates the database relationships from changes in data values or database design (agility) and guarantees uniqueness.

</div>

The table below lists some examples of identifiers, though it does not list all possibilities or considerations when designing a new identifier.

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 25%" />
<col style="width: 25%" />
<col style="width: 25%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align: left;">identifier structure</th>
<th style="text-align: left;">example</th>
<th style="text-align: left;">OpenAPI type</th>
<th style="text-align: left;">considerations</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;"><p>UUID</p></td>
<td style="text-align: left;"><p>"d9e35127-e9b1-4201-a211-2b52e52508df"</p></td>
<td style="text-align: left;"><p>Type defined in <a href="https://github.com/belgif/openapi-common/blob/master/src/main/swagger/common/v1/common-v1.yaml">common-v1.yaml</a></p>
<div class="sourceCode" id="cb1"><pre class="sourceCode YAML"><code class="sourceCode yaml"><span id="cb1-1"><a href="#cb1-1" aria-hidden="true" tabindex="-1"></a><span class="fu">Uuid</span><span class="kw">:</span></span>
<span id="cb1-2"><a href="#cb1-2" aria-hidden="true" tabindex="-1"></a><span class="at">  </span><span class="fu">description</span><span class="kw">:</span><span class="at"> Universally Unique Identifier, as standardized in RFC 4122 and ISO/IEC 9834-8</span></span>
<span id="cb1-3"><a href="#cb1-3" aria-hidden="true" tabindex="-1"></a><span class="at">  </span><span class="fu">type</span><span class="kw">:</span><span class="at"> string</span></span>
<span id="cb1-4"><a href="#cb1-4" aria-hidden="true" tabindex="-1"></a><span class="at">  </span><span class="fu">pattern</span><span class="kw">:</span><span class="at"> </span><span class="st">&#39;^[\da-f]{8}-[\da-f]{4}-[\da-f]{4}-[\da-f]{4}-[\da-f]{12}$&#39;</span></span></code></pre></div></td>
<td style="text-align: left;"><p>long identifier,
not easy to memorize or input by user,
easy to generate,
resistant to brute-force guessing</p></td>
</tr>
<tr class="even">
<td style="text-align: left;"><p>URI (URN)</p></td>
<td style="text-align: left;"><p>"urn:problem-type:belgif:resourceNotFound"</p></td>
<td style="text-align: left;"><div class="sourceCode" id="cb2"><pre class="sourceCode YAML"><code class="sourceCode yaml"><span id="cb2-1"><a href="#cb2-1" aria-hidden="true" tabindex="-1"></a><span class="fu">type</span><span class="kw">:</span><span class="at"> string</span></span>
<span id="cb2-2"><a href="#cb2-2" aria-hidden="true" tabindex="-1"></a><span class="fu">format</span><span class="kw">:</span><span class="at"> uri</span></span>
<span id="cb2-3"><a href="#cb2-3" aria-hidden="true" tabindex="-1"></a><span class="fu">pattern</span><span class="kw">:</span><span class="at"> </span><span class="st">&quot;^urn:problem-type:.+$&quot;</span><span class="co"> # further restrictions may be possible</span></span></code></pre></div></td>
<td style="text-align: left;"><p>can be human-readable,
long, not easy to input by user</p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><p>URI (http)</p></td>
<td style="text-align: left;"><p>"https://www.waterwegen.be/id/rivier/schelde"</p></td>
<td style="text-align: left;"><div class="sourceCode" id="cb3"><pre class="sourceCode YAML"><code class="sourceCode yaml"><span id="cb3-1"><a href="#cb3-1" aria-hidden="true" tabindex="-1"></a><span class="fu">type</span><span class="kw">:</span><span class="at"> string</span></span>
<span id="cb3-2"><a href="#cb3-2" aria-hidden="true" tabindex="-1"></a><span class="fu">format</span><span class="kw">:</span><span class="at"> uri</span></span></code></pre></div></td>
<td style="text-align: left;"><p>can be human-readable,
long, not easy to input by user,
requires character escaping when used as URL parameter
can be generated collision-free by multiple sources (different domain name)</p></td>
</tr>
<tr class="even">
<td style="text-align: left;"><p>custom format</p></td>
<td style="text-align: left;"><p>"ab12347895"</p></td>
<td style="text-align: left;"><div class="sourceCode" id="cb4"><pre class="sourceCode YAML"><code class="sourceCode yaml"><span id="cb4-1"><a href="#cb4-1" aria-hidden="true" tabindex="-1"></a><span class="fu">type</span><span class="kw">:</span><span class="at"> string</span></span>
<span id="cb4-2"><a href="#cb4-2" aria-hidden="true" tabindex="-1"></a><span class="fu">pattern</span><span class="kw">:</span><span class="at"> </span><span class="st">&quot;^[a-z0-9]{1-20}$&quot;</span></span></code></pre></div></td>
<td style="text-align: left;"><p>short,
easy to encode</p></td>
</tr>
</tbody>
</table>

A *code* is a special type of identifier:

- it has an exhaustive list of possible values that doesn’t change frequently over time

- each value identifies a concept (examples: a country, a gender, …​).

New code types SHOULD be represented as string values in lowerCamelCase.

Depending on context, the OpenAPI data type may enumerate the list of allowed values (see [???](#enum-rule)).

`GET /refData/paymentMethods/{code}` with `code` of type `PaymentMethodCode`

As string with enumeration:

``` YAML
PaymentMethodCode:
  type: string
  enum:
  - cash
  - wireTransfer
  - creditCard
  - debitCard
```

As string with regular expression:

``` YAML
PaymentMethodCode:
  type: string
  pattern: "^[A-Za-z0-9]+$"
  example: "debitCard"
```

When defining the type for a property representing an existing numerical code or identifier:

- Identifiers that are commonly represented (e.g. when displayed or inputted by a user) with **leading zeros** present SHOULD be represented using a string type. A regular expression SHOULD be specified in the OpenAPI data type to avoid erroneous values (i.e. without leading zeros).

- Otherwise, use an integer based type. It is RECOMMENDED to further restrict the format of the type (e.g. `format: int32` and using `minimum`/`maximum`).

For new identifiers, it is not recommended to use a number type however as stated in [simpara_title](#new-identifiers)

An employer ID may be of variable length. Leading zeroes are ignored and most of the time not displayed.

``` YAML
EmployerId:
  description: Definitive or provisional NSSO number, assigned to each registered employer or local or provincial administration.
  type: integer
  format: int64
  minimum: 0
  maximum: 5999999999
  example: 21197
```

If SSIN has a zero as first digit, it is always displayed.

``` YAML
Ssin:
  description: Social Security Identification Number issued by the National Register or CBSS
  type: string
  pattern: '^\d{11}$'
```

Country NIS code is a three-digit code, the first digit cannot be a zero.

``` YAML
CountryNisCode:
  description: NIS code representing a country as defined by statbel.fgov.be
  type: integer
  minimum: 100
  maximum: 999
  example: 150 # represents Belgium
```

Following naming guidelines should be applied when using an identifier or code in a REST API:

- JSON property:

  - within an object that represents the entire or part of a resource: use `id` or `code`

  - to reference a resource within another one’s representation: property name should designate the relation between the resources (see [???](#rule-jsn-naming)); no need to suffix with `id` or `code`

- path parameter: use `id` or `code`, OPTIONALLY prefixed with the resource type to disambiguate when there are multiple identifiers as path parameters

- query search parameter: use same name as the property in the JSON resource representation of the response (see [???](#filtering))

- OpenAPI type: add suffix `Id` or `Code` to distinguish it from the type of the full resource representation

As an exception, use the standardized name for the business identifier if one exists, rather than `id` or `code`.

If multiple identifiers or coding schemes may be used within the same context, a suffix can be added to the name to disambiguate.

Request:

    GET /stores/{storeId}/orders/{orderId} 

Response:

``` YAML
{
  "id": 123,  
  "customer": 456, 
  "store": {
     "id": 789, 
     "href": "/stores/789"
  },
  "paymentMethod": "creditCard",
  "deliveryMethod": {
     "code": "deliveredAtHome", 
     "href": "/refData/deliveryMethods/deliveredAtHome"
  }
}
```

OpenAPI types (not all are listed for brevity):

``` YAML
Order: 
  type: object
  properties:
    id:
      $ref: "#/components/schemas/OrderId" 
    customer:
      $ref: "#/components/schemas/CustomerId" 
    store:
      $ref: "#/components/schemas/StoreReference" 
    paymentMethod:
      $ref: "#/components/schemas/PaymentMethodCode" 
    deliveryMethod:
      $ref: "#/components/schemas/DeliveryMethodReference" 

OrderId: 
  type: integer
  format: int32
  minimum: 1

StoreReference: 
  allOf:
  - $ref: "./common/v1/common-v1.yaml#/definitions/HttpLink"
  type: object
  properties:
    id:
      $ref: "#/components/schemas/StoreId" 

StoreId: 
  type: integer
  format: int32
  minimum: 1
```

- path parameter: `id` prefixed with resource type to be able to distinguish both parameters

- `id` as property of the consulted resource

- identifier used to reference another resource. JSON property name designates relation to the other resource.

- `id` as property in a partial representation of a `store` resource

- `code` as property in a partial representation of a `deliveryMethod` resource

- The type of the full resource representation doesn’t have a suffix

- Types of the identifiers have the suffix `Id` or `Code`

- Partial resource representations, which may link to the full resource

<!-- -->

    GET /refData/deliveryMethods/{code} 

``` YAML
{
  "code": "deliveredAtHome",
  "description": {
     "nl": "Geleverd aan huis",
     "en": "Delivered at home",
     "fr": "Livré à domicile"
  }
}
```

- Since there are no child resources with other path parameters, simply `code` suffices

<!-- -->

    GET /persons/{ssin} 

``` YAML
{
  "ssin": "12345678901", 
  "partner": "2345678902", 
  "civilStatus": 1
}
```

- Standardized business identifier name `Ssin` is preferred over `id`.

- JSON property name designates relation to the other resource. The OpenAPI specification declares the expected value to be of type `Ssin`.

<!-- -->

    GET /addresses/{addressId}

``` YAML
{
  "municipality": {
    "code": 10000,
    "name": "Brussels"
  },
  "country": {
    "nisCode": 150, 
    "isoCode": "BE", 
    "name": {
      "nl": "België",
      "fr": "Belgique"
    }
  }
}
```

- Prefixes `nis` and `iso` disambiguate between two types of country identifiers used in a single context

## Consult

    GET {API}/employers/93017373[^] HTTP/1.1

<table>
<colgroup>
<col style="width: 16%" />
<col style="width: 33%" />
<col style="width: 50%" />
</colgroup>
<tbody>
<tr class="odd">
<td style="text-align: left;"><p><a href="#get">???</a></p></td>
<td style="text-align: left;"><p>/employers/{employerId}</p></td>
<td style="text-align: left;"><p>Consult a single employer</p></td>
</tr>
<tr class="even">
<td colspan="3" style="text-align: left;"><p>Parameters</p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><p><code>employerId</code></p></td>
<td style="text-align: left;"><p>path-param</p></td>
<td style="text-align: left;"><p>NSSO number uniquely identifying the employer.</p></td>
</tr>
<tr class="even">
<td colspan="3" style="text-align: left;"><p>Response</p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><p>body</p></td>
<td style="text-align: left;"><p>The response properties and links to other resources.</p></td>
<td style="text-align: left;"><div class="sourceCode" id="cb1"><pre class="sourceCode json"><code class="sourceCode json"><span id="cb1-1"><a href="#cb1-1" aria-hidden="true" tabindex="-1"></a><span class="fu">{</span></span>
<span id="cb1-2"><a href="#cb1-2" aria-hidden="true" tabindex="-1"></a>  <span class="dt">&quot;self&quot;</span><span class="fu">:</span> <span class="st">&quot;{API}/employers/93017373[/employers/93017373^]&quot;</span><span class="fu">,</span></span>
<span id="cb1-3"><a href="#cb1-3" aria-hidden="true" tabindex="-1"></a>  <span class="dt">&quot;name&quot;</span><span class="fu">:</span> <span class="st">&quot;Belgacom&quot;</span><span class="fu">,</span></span>
<span id="cb1-4"><a href="#cb1-4" aria-hidden="true" tabindex="-1"></a>  <span class="dt">&quot;employerId&quot;</span><span class="fu">:</span> <span class="dv">93017373</span><span class="fu">,</span></span>
<span id="cb1-5"><a href="#cb1-5" aria-hidden="true" tabindex="-1"></a>  <span class="dt">&quot;company&quot;</span><span class="fu">:</span> <span class="fu">{</span></span>
<span id="cb1-6"><a href="#cb1-6" aria-hidden="true" tabindex="-1"></a>    <span class="dt">&quot;enterpriseNumber&quot;</span><span class="fu">:</span> <span class="st">&quot;0202239951&quot;</span><span class="fu">,</span></span>
<span id="cb1-7"><a href="#cb1-7" aria-hidden="true" tabindex="-1"></a>    <span class="dt">&quot;href&quot;</span><span class="fu">:</span> <span class="st">&quot;{API}/companies/202239951[/companies/202239951^]&quot;</span></span>
<span id="cb1-8"><a href="#cb1-8" aria-hidden="true" tabindex="-1"></a>  <span class="fu">}</span></span>
<span id="cb1-9"><a href="#cb1-9" aria-hidden="true" tabindex="-1"></a><span class="fu">}</span></span></code></pre></div></td>
</tr>
<tr class="even">
<td colspan="3" style="text-align: left;"><p>Most used response codes</p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><p><a href="#http-200">200</a></p></td>
<td style="text-align: left;"><p>OK</p></td>
<td style="text-align: left;"><p>Default success code if the document exists.</p></td>
</tr>
<tr class="even">
<td style="text-align: left;"><p><a href="#http-400">400</a></p></td>
<td style="text-align: left;"><p>Bad request</p></td>
<td style="text-align: left;"><p>The dynamic path segment containing the identity key has a wrong data format:</p>
<div class="sourceCode" id="cb2"><pre class="sourceCode json"><code class="sourceCode json"><span id="cb2-1"><a href="#cb2-1" aria-hidden="true" tabindex="-1"></a><span class="fu">{</span></span>
<span id="cb2-2"><a href="#cb2-2" aria-hidden="true" tabindex="-1"></a>  <span class="dt">&quot;type&quot;</span><span class="fu">:</span> <span class="st">&quot;urn:problem-type:belgif:badRequest&quot;</span><span class="fu">,</span></span>
<span id="cb2-3"><a href="#cb2-3" aria-hidden="true" tabindex="-1"></a>  <span class="dt">&quot;href&quot;</span><span class="fu">:</span> <span class="st">&quot;https://www.belgif.be/specification/rest/api-guide/problems/badRequest.html&quot;</span><span class="fu">,</span></span>
<span id="cb2-4"><a href="#cb2-4" aria-hidden="true" tabindex="-1"></a>  <span class="dt">&quot;status&quot;</span><span class="fu">:</span> <span class="dv">400</span><span class="fu">,</span></span>
<span id="cb2-5"><a href="#cb2-5" aria-hidden="true" tabindex="-1"></a>  <span class="dt">&quot;title&quot;</span><span class="fu">:</span> <span class="st">&quot;Bad Request&quot;</span><span class="fu">,</span></span>
<span id="cb2-6"><a href="#cb2-6" aria-hidden="true" tabindex="-1"></a>  <span class="dt">&quot;instance&quot;</span><span class="fu">:</span> <span class="st">&quot;urn:uuid:d9e35127-e9b1-4201-a211-2b52e52508df&quot;</span><span class="fu">,</span></span>
<span id="cb2-7"><a href="#cb2-7" aria-hidden="true" tabindex="-1"></a>  <span class="dt">&quot;detail&quot;</span><span class="fu">:</span> <span class="st">&quot;The input message is incorrect&quot;</span><span class="fu">,</span></span>
<span id="cb2-8"><a href="#cb2-8" aria-hidden="true" tabindex="-1"></a>  <span class="dt">&quot;issues&quot;</span><span class="fu">:</span> <span class="ot">[</span></span>
<span id="cb2-9"><a href="#cb2-9" aria-hidden="true" tabindex="-1"></a>    <span class="fu">{</span></span>
<span id="cb2-10"><a href="#cb2-10" aria-hidden="true" tabindex="-1"></a>      <span class="dt">&quot;type&quot;</span><span class="fu">:</span> <span class="st">&quot;urn:problem-type:belgif:input-validation:schemaViolation&quot;</span><span class="fu">,</span></span>
<span id="cb2-11"><a href="#cb2-11" aria-hidden="true" tabindex="-1"></a>      <span class="dt">&quot;in&quot;</span><span class="fu">:</span> <span class="st">&quot;path&quot;</span><span class="fu">,</span></span>
<span id="cb2-12"><a href="#cb2-12" aria-hidden="true" tabindex="-1"></a>      <span class="dt">&quot;name&quot;</span><span class="fu">:</span> <span class="st">&quot;employerId&quot;</span><span class="fu">,</span></span>
<span id="cb2-13"><a href="#cb2-13" aria-hidden="true" tabindex="-1"></a>      <span class="dt">&quot;value&quot;</span><span class="fu">:</span> <span class="st">&quot;abc&quot;</span><span class="fu">,</span></span>
<span id="cb2-14"><a href="#cb2-14" aria-hidden="true" tabindex="-1"></a>      <span class="dt">&quot;detail&quot;</span><span class="fu">:</span> <span class="st">&quot;This value should be numeric&quot;</span></span>
<span id="cb2-15"><a href="#cb2-15" aria-hidden="true" tabindex="-1"></a>    <span class="fu">}</span></span>
<span id="cb2-16"><a href="#cb2-16" aria-hidden="true" tabindex="-1"></a>  <span class="ot">]</span></span>
<span id="cb2-17"><a href="#cb2-17" aria-hidden="true" tabindex="-1"></a><span class="fu">}</span></span></code></pre></div>
<p>​</p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><p><a href="#http-404">404</a></p></td>
<td style="text-align: left;"><p>Not Found</p></td>
<td style="text-align: left;"><p>The document resource does not exist.</p></td>
</tr>
</tbody>
</table>

<div class="warning">

​[204 No content](#http-204) should not be used with GET.

</div>

The `select` query parameter is reserved to return a resource representation with only the specified properties.

The value of this parameter SHOULD follow this [BNF grammar](https://en.wikipedia.org/wiki/Backus%E2%80%93Naur_form):

``` BNF
<selects>            ::= [ <negation> ] <selects_struct>
<selects_struct>     ::= "(" <select_items> ")"
<select_items>       ::= <select> [ "," <select_items> ]
<select>             ::= <select_name> | <selects_substruct>
<selects_substruct>  ::= <select_name> <selects_struct>
<select_name>        ::= <dash_letter_digit> [ <select_name> ]
<dash_letter_digit> ::= <dash> | <letter> | <digit>
<dash>              ::= "-" | "_"
<letter>            ::= "A" | ... | "Z" | "a" | ... | "z"
<digit>             ::= "0" | ... | "9"
<negation>          ::= "!"
```

    GET /employers/93017373?select=(name)

``` json
{
  "self": "{API}/employers/93017373?select=(name)[/employers/93017373?select=(name)^]",
  "name": "Proximus"
}
```

Note that parentheses around the value of the `select` parameter are required, even when selecting a single property.

This notation can also be used for nested properties:

    GET /employers/93017373?select=(name,address(street(name,code)))

``` json
{
  "self": "{API}/employers/93017373[/employers/93017373^]",
  "name": "Proximus",
  "address": {
    "street": {
      "name": "Koning Albert II laan",
      "code": 2177
    }
  }
}
```

## Update

Updating a resource may be done in one of several ways.
One and only one of following patterns should be chosen per resource, unless forced by a backwards compatible change.

In order of preference:

1.  use PUT with complete objects to update a resource as long as feasible (i.e. do not use PATCH at all).

    This option is preferred when clients are likely to always take into account the entire resource representation.
    If a client ignores some of a resource’s properties returned by a consultation, they are likely to be omitted from the PUT request and thus lost.
    This scenario may occur when new properties were added during the API lifecycle.
    In this case, use of PUT isn’t advised.

2.  Use PATCH with partial objects to only update parts of a resource, whenever possible, using the JSON Merge Patch standard.

    JSON Merge Patch is limited however, e.g. it doesn’t allow for an update of a single element of an array.
    If this proves to be an issue, this might however indicate that the array elements might be beter modeled as seperate subresources.

3.  use POST on a child resource instead of PATCH if the request does not modify the resource in a way defined by the semantics of the media type.
    See [???](#Controller) for more information.

Use of the JSON Patch standard, an alternative to JSON Merge Patch, is not recommended, as it proves to be difficult to implement.

### Full update

Use `PUT` when you like to do a complete update of a document resource.
All values are replaced by the values submitted by the client.
Absent optional values in the request are set to their default value if one is specified in the OpenAPI specification.

    PUT {API}/employers/93017373[^] HTTP/1.1

    {
        "employerId": 93017373,
        "name": "Belgacom"
    }

<table>
<colgroup>
<col style="width: 16%" />
<col style="width: 33%" />
<col style="width: 50%" />
</colgroup>
<tbody>
<tr class="odd">
<td style="text-align: left;"><p>​​​​​​​​​<a href="#put">???</a></p></td>
<td style="text-align: left;"><p>/employers/{employerId}</p></td>
<td style="text-align: left;"><p>Replace the entire employer resource with the client data. This implies a full update of the resource. Via <code>PUT</code> the client submits new values for all the data.</p></td>
</tr>
<tr class="even">
<td colspan="3" style="text-align: left;"><p>Request</p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><p>body</p></td>
<td style="text-align: left;"><p>Full representation of the resource to persist.</p></td>
<td style="text-align: left;"></td>
</tr>
<tr class="even">
<td colspan="3" style="text-align: left;"><p>​​​Parameters</p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><p><code>employerId</code></p></td>
<td style="text-align: left;"><p>path-param</p></td>
<td style="text-align: left;"><p>employer ID of NSSO uniquely identifying the employer.</p></td>
</tr>
<tr class="even">
<td colspan="3" style="text-align: left;"><p>Response</p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><p>body</p></td>
<td style="text-align: left;"><p>either empty or resource after update</p></td>
<td style="text-align: left;"><div class="sourceCode" id="cb1"><pre class="sourceCode json"><code class="sourceCode json"><span id="cb1-1"><a href="#cb1-1" aria-hidden="true" tabindex="-1"></a><span class="fu">{</span></span>
<span id="cb1-2"><a href="#cb1-2" aria-hidden="true" tabindex="-1"></a>    <span class="dt">&quot;employerId&quot;</span><span class="fu">:</span> <span class="dv">93017373</span><span class="fu">,</span></span>
<span id="cb1-3"><a href="#cb1-3" aria-hidden="true" tabindex="-1"></a>    <span class="dt">&quot;name&quot;</span><span class="fu">:</span> <span class="st">&quot;Belgacom&quot;</span></span>
<span id="cb1-4"><a href="#cb1-4" aria-hidden="true" tabindex="-1"></a><span class="fu">}</span></span></code></pre></div></td>
</tr>
<tr class="even">
<td colspan="3" style="text-align: left;"><p>Most used response codes
​​</p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><p><a href="#http-200">200</a></p></td>
<td style="text-align: left;"><p>OK</p></td>
<td style="text-align: left;"><p>The update is successful and updated resource is returned.</p>
<p>​​</p></td>
</tr>
<tr class="even">
<td style="text-align: left;"><p><a href="#http-204">204</a></p></td>
<td style="text-align: left;"><p>No Content</p></td>
<td style="text-align: left;"><p>The update is successful but updated resource is not returned.</p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><p><a href="#http-400">400</a></p></td>
<td style="text-align: left;"><p>Bad request</p></td>
<td style="text-align: left;"><p>The input data is not valid according the data schema.</p></td>
</tr>
<tr class="even">
<td style="text-align: left;"><p><a href="#http-404">404</a></p></td>
<td style="text-align: left;"><p>Not Found</p></td>
<td style="text-align: left;"><p>The resource does not exist and thus cannot be updated.
​</p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><p><a href="#http-409">409</a></p></td>
<td style="text-align: left;"><p>Conflict</p></td>
<td style="text-align: left;"><p>The client data is in conflict with the data on the server e.g. optimistic locking issues.
​</p></td>
</tr>
</tbody>
</table>

### Partial update

Use `PATCH` when you like to do a partial update of a document resource.

The `PATCH` message MUST conform to the JSON Merge Patch ([RFC 7386](https://tools.ietf.org/html/rfc7386)) specification:

- JSON properties in the request overwrite the ones in the previous resource state

- properties with value `null` in the request are removed from the resource

- properties not present in the request are preserved

APIs should support both the MIME type of JSON merge patch `application/merge-patch+json` as the generic `application/json` JSON mime type.
As JSON Merge Patch requests can not be fully specified as an OpenAPI data type, a MergePatch marker type should be used, defined in [common-v1.yaml](https://github.com/belgif/openapi-common/blob/master/src/main/swagger/common/v1/common-v1.yaml).

    PATCH {API}/employers/93017373[^] HTTP/1.1

<table>
<colgroup>
<col style="width: 16%" />
<col style="width: 33%" />
<col style="width: 50%" />
</colgroup>
<tbody>
<tr class="odd">
<td style="text-align: left;"><p><a href="#patch">???</a></p></td>
<td style="text-align: left;"><p>/employers/{employerId}</p></td>
<td style="text-align: left;"><p>Performs a partial update of an existing employer.</p></td>
</tr>
<tr class="even">
<td colspan="3" style="text-align: left;"><p>Request</p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><p>body</p></td>
<td style="text-align: left;"><p>JSON Merge Patch</p></td>
<td style="text-align: left;"><div class="sourceCode" id="cb1"><pre class="sourceCode json"><code class="sourceCode json"><span id="cb1-1"><a href="#cb1-1" aria-hidden="true" tabindex="-1"></a><span class="fu">{</span></span>
<span id="cb1-2"><a href="#cb1-2" aria-hidden="true" tabindex="-1"></a>  <span class="dt">&quot;bankrupt&quot;</span><span class="fu">:</span> <span class="kw">false</span><span class="fu">,</span></span>
<span id="cb1-3"><a href="#cb1-3" aria-hidden="true" tabindex="-1"></a>  <span class="dt">&quot;bankruptDate&quot;</span><span class="fu">:</span> <span class="kw">null</span></span>
<span id="cb1-4"><a href="#cb1-4" aria-hidden="true" tabindex="-1"></a><span class="fu">}</span></span></code></pre></div></td>
</tr>
<tr class="even">
<td colspan="3" style="text-align: left;"><p>Parameters</p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><p><code>employerId</code></p></td>
<td style="text-align: left;"><p>path-param</p></td>
<td style="text-align: left;"><p>employer ID of NSSO uniquely identifying the employer.</p></td>
</tr>
<tr class="even">
<td colspan="3" style="text-align: left;"><p>Response</p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><p>body</p></td>
<td style="text-align: left;"><p>empty or the complete resource after applying PATCH</p></td>
<td style="text-align: left;"><div class="sourceCode" id="cb2"><pre class="sourceCode json"><code class="sourceCode json"><span id="cb2-1"><a href="#cb2-1" aria-hidden="true" tabindex="-1"></a><span class="fu">{</span></span>
<span id="cb2-2"><a href="#cb2-2" aria-hidden="true" tabindex="-1"></a>    <span class="dt">&quot;employerId&quot;</span><span class="fu">:</span> <span class="dv">93017373</span><span class="fu">,</span></span>
<span id="cb2-3"><a href="#cb2-3" aria-hidden="true" tabindex="-1"></a>    <span class="dt">&quot;name&quot;</span><span class="fu">:</span> <span class="st">&quot;Belgacom&quot;</span><span class="fu">,</span></span>
<span id="cb2-4"><a href="#cb2-4" aria-hidden="true" tabindex="-1"></a>    <span class="dt">&quot;bankrupt&quot;</span><span class="fu">:</span> <span class="kw">false</span></span>
<span id="cb2-5"><a href="#cb2-5" aria-hidden="true" tabindex="-1"></a><span class="fu">}</span></span></code></pre></div></td>
</tr>
<tr class="even">
<td colspan="3" style="text-align: left;"><p>Most used response codes</p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><p><a href="#http-200">200</a></p></td>
<td style="text-align: left;"><p>OK</p></td>
<td style="text-align: left;"><p>Success code with resource after applying PATCH returned.</p></td>
</tr>
<tr class="even">
<td style="text-align: left;"><p><a href="#http-204">204</a></p></td>
<td style="text-align: left;"><p>No Content</p></td>
<td style="text-align: left;"><p>Success code without returning the resource.</p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><p><a href="#http-400">400</a></p></td>
<td style="text-align: left;"><p>Bad request</p></td>
<td style="text-align: left;"><p>The input data is not valid according the data schema.</p></td>
</tr>
<tr class="even">
<td style="text-align: left;"><p><a href="#http-404">404</a></p></td>
<td style="text-align: left;"><p>Not Found</p></td>
<td style="text-align: left;"><p>The resource does not exist and thus cannot be updated.</p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><p><a href="#http-409">409</a></p></td>
<td style="text-align: left;"><p>Conflict</p></td>
<td style="text-align: left;"><p>The client data is in conflict with the data on the server e.g. optimistic locking issues.</p></td>
</tr>
</tbody>
</table>

## Remove

Use `DELETE` when you like to delete a document resource.

    DELETE {API}/employers/93017373[^] HTTP/1.1

<table>
<colgroup>
<col style="width: 16%" />
<col style="width: 33%" />
<col style="width: 50%" />
</colgroup>
<tbody>
<tr class="odd">
<td style="text-align: left;"><p><a href="#delete">???</a></p></td>
<td style="text-align: left;"><p>/employers/{employerId}</p></td>
<td style="text-align: left;"><p>Deletes an employer.</p></td>
</tr>
<tr class="even">
<td colspan="3" style="text-align: left;"><p>Parameters</p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><p><code>employerId</code></p></td>
<td style="text-align: left;"><p>path-param</p></td>
<td style="text-align: left;"><p>employer ID of NSSO uniquely identifying the employer.</p></td>
</tr>
<tr class="even">
<td colspan="3" style="text-align: left;"><p>Response</p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><p>body</p></td>
<td style="text-align: left;"><p>empty or a message indicating success</p></td>
<td style="text-align: left;"><pre><code>204 No Content

or

200 OK
{
 &quot;message&quot;: &quot;Employer is deleted.&quot;
}</code></pre></td>
</tr>
<tr class="even">
<td colspan="3" style="text-align: left;"><p>Most used response codes</p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><p><a href="#http-200">200</a></p></td>
<td style="text-align: left;"><p>OK</p></td>
<td style="text-align: left;"><p>Success code with the deleted resource returned.</p></td>
</tr>
<tr class="even">
<td style="text-align: left;"><p><a href="#http-204">204</a></p></td>
<td style="text-align: left;"><p>No Content</p></td>
<td style="text-align: left;"><p>Success code with the deleted resource not returned.</p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><p><a href="#http-400">400</a></p></td>
<td style="text-align: left;"><p>Bad request</p></td>
<td style="text-align: left;"><p>Generic error on client side. For example, the syntax of the request is invalid.</p></td>
</tr>
<tr class="even">
<td style="text-align: left;"><p><a href="#http-404">404</a></p></td>
<td style="text-align: left;"><p>Not Found</p></td>
<td style="text-align: left;"><p>The resource does not exist and thus cannot be deleted.</p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><p><a href="#http-409">409</a></p></td>
<td style="text-align: left;"><p>Conflict</p></td>
<td style="text-align: left;"><p>A constraint on the resource is violated.
The resource could not be deleted because the request is in conflict with the current
state of the resource.</p>
<p>For example, a REST API may return this response code when a client tries to DELETE a non-empty store resource.</p></td>
</tr>
</tbody>
</table>

## Long-running tasks

Some operations need to be performed asynchronously, as they take too long to complete.

Long-running tasks MUST be represented as a resource.
The task resource is created using a POST action returning a `202 Accepted` response containing the URL of the task in the `Location` HTTP header.
It can then be fetched by the client to get the processing status of the task.

When GETting the task resource, the response can be:

- Still processing: status `200 OK` and a representation of the task’s current status

- Success: status `303 See Other` with the `Location` header containing the URL of the task’s output.

- Failure: status `200 OK` with a representation of the task’s status, including the reason of the failure

Variations on the above may be required, e.g. if the task has no output, the response on success may be `200 OK` without a `Location` header.
The schema [common-v1.yaml](https://github.com/belgif/openapi-common/blob/master/src/main/swagger/common/v1/common-v1.yaml) defines the representation of a task’s status.

**Submitting the task**

`POST /images/tasks`

    HTTP/1.1 202 Accepted
    Content-Type: application/json;charset=UTF-8
    Location: http://www.example.org/images/tasks/1
    Date: Sun, 13 Sep 2018 01:49:27 GMT

``` JSON
{
  "self": "/images/tasks",
  "status": {
    "state": "processing",
    "pollAfter": "2018-09-13T01:59:27Z"
  }
}
```

The response `202 Accepted` status indicates that the server accepted the request for processing.
`pollAfter` hints when to check for an updated status at a later time.

**Getting the processing status**

`GET /images/tasks/1`

*When the server is still processing the task*

    HTTP/1.1 200 OK
    Content-Type: application/json;charset=UTF-8

``` JSON
{
  "self": "/images/tasks/1",
  "status": {
    "state": "processing",
    "pollAfter": "2018-09-13T02:09:27Z"
  }
}
```

*When processing has completed*

    HTTP/1.1 303 See Other
    Location: http://www.example.org/images/1
    Content-Type: application/json;charset=UTF-8

``` JSON
{
  "self": "/images/tasks/1",
  "status": {
    "state": "done",
    "completed":"2018-09-13T02:10:00Z"
  }
}
```

The `Location` header refers to the result of the task.

*In case of failure during processing*

    HTTP/1.1 200 OK
    Content-Type: application/json;charset=UTF-8

``` JSON
{
  "self": "/images/tasks/1",
  "status": {
    "state": "failed",
    "completed":"2018-09-13T02:10:00Z",
    "problem": {
      "instance": "urn:uuid:d9e35127-e9b1-4201-a211-2b52e52508df",
      "title": "Bad Request",
      "status": 400,
      "type": "urn:problem-type:example:invalidImageFormat",
      "href": "https://example.org/example/v1/refData/problemTypes/urn:problem-type:example:invalidImageFormat",
      "detail": "Invalid image format"
    }
  }
}
```

Note that the status code is `200 OK` as the retrieval of the task’s status succeeded.
The cause of failure is represented using an embedded Problem object, as defined in [???](#Error handling).
