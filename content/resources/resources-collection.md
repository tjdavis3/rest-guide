---
title: Collection
weight: 44
---

A collection resource is a server-managed list of document resources.

A plural noun SHOULD be used for collection names, for example 'employers' or 'people'.

{API}/employers\[^\]

## Consult

The representation of a collection MUST contain a list of links to child resources:

- A query on a collection MUST contain an `items` property with an array of objects, each one representing an item in the collection.

- In these objects, a `href` property MUST be present with a link to the resource.

- The unique business identifier SHOULD be present for each item.

- Each item object MAY be extended with some key business properties, needed for display in a master view.

- In case the collection is empty, the `items` property MUST have an empty array as value.

- The `title` property MAY be used to provide a human-readable description for an item, usable as display text for the link.

- The number of items in the collection result set MAY be included in the response using the `total` property. If the response is paginated, its value MUST correspond to the number of items regardless of pagination, rather than only the number of items in the current page.

<div class="caution">

A collection resource SHOULD always return a JSON object as top-level data structure to support extensibility. Do not return a JSON array, because the moment you like to add paging, hypermedia links, etc, your API will break.

</div>

|                  |             |                                                                                  |
|------------------|-------------|----------------------------------------------------------------------------------|
| [200](#http-200) | OK          | Default response code, also when the collection is empty.                        |
| [400](#http-400) | Bad Request | Generic error on client side. For example, the syntax of the request is invalid. |
| [404](#http-404) | Not found   | The URI provided cannot be mapped to a resource.                                 |

Most used response codes

<div class="warning">

​[204 No content](#http-204) should not be used with GET.

</div>

|      |                                                                                    |                      |
|------|------------------------------------------------------------------------------------|----------------------|
| sort | Multi-value query param with list of properties to sort on.                        
        Direction is ascending by default. To indicate descending, prefix property with -.  | ?sort=age&sort=-name |

Query parameters

    GET {API}/employers[^] HTTP/1.1​

<div class="formalpara-title">

**Response**

</div>

``` json
{
 "self": "{API}/employers",
 "items":[
   {
     "href":"{API}/employers/93017373[/employers/93017373^]",
     "title":"Belgacom",
     "employerId": 93017373,
     "enterpriseNumber": "0202239951"
   },
   {
     "href":"{API}/employers/20620259[/employers/20620259^]",
     "title":"Partena VZW",
     "employerId": 20620259,
     "enterpriseNumber": "0409536968"
   }
 ],
 "total":2
}
```

<div class="formalpara-title">

**JSON data types**

</div>

``` YAML
EmployersResponse:
  allOf:
  - $ref: common/v1/common-v1.yaml#/definitions/SelfLink
  - type: object
    properties:
      items:
        type: array
        items:
          $ref: "#/definitions/EmployerLink"
      total:
        type: integer
EmployerLink:
  allOf:
  - $ref: common/v1/common-v1.yaml#/definitions/HttpLink
  - type: object
    properties:
      employerId:
        $ref: "./employer/identifier/v1/employer-identifier-v1beta.yaml#/definitions/EmployerId"
      enterpriseNumber:
        $ref: "./organization/identifier/v1/organization-identifier-v1.yaml#/definitions/EnterpriseNumber"
```

When the collection items contain few data, you may want to retrieve them in full when getting the collection.
In this case, the full representations MUST be included in an 'embedded' property as described in [???](#Embedding resources).

    GET {API}/appendices/employerclasses?embed=items[^] HTTP/1.1​

<div class="formalpara-title">

**Response**

</div>

``` JSON
​​​{
 "self": "{API}/appendices/employerclasses?embed=items[/appendices/employerclasses?embed=items^]",
 "items": [
  {
   "value": "0",
   "href": "{API}/appendices/employerclasses/0[/appendices/employerclasses/0^]"
  }, {
   "value": "2",
   "href": "{API}/appendices/employerclasses/2[/appendices/employerclasses/2^]"
  }
 ],
 "total":2,
 "embedded": {
   "{API}/appendices/employerclasses/2[/appendices/employerclasses/2^]": {
     "self": "{API}/appendices/employerclasses/2[/appendices/employerclasses/2^]",
     "value": "2",
     "description": {
       "nl": "Bijzondere categorie voor werkgevers die voor hun arbeiders een speciale bijdrage verschuldigd zijn.",
       "fr": "Catégorie particulière pour les employeurs redevables pour les ouvriers d’une cotisation spéciale."
      }
   },
   "{API}/appendices/employerclasses/0[/appendices/employerclasses/0^]": {
     "self": "{API}/appendices/employerclasses/0[/appendices/employerclasses/0^]",
     "value": "0",
     "description": {
      "nl": "Algemene categorie voor werkgevers van commerciële of niet-commerciële aard.",
      "fr": "Catégorie générale pour les employeurs, de type commercial ou non-commercial."
     }
   }
 }
}​
```

<div class="formalpara-title">

**JSON data types**

</div>

``` YAML
AppendixCodesResponse:
  description: A collection of appendix codes
  type: object
  properties:
    items:
      type: array
      items:
        $ref: '#/definitions/AppendixCodeLink'
    total:
      type: integer
    embedded:
      type: object
      additionalProperties:
        $ref: 'appendixCode.yaml#/definitions/AppendixCode'
AppendixCodeLink:
  allOf:
  - $ref: 'common/v1/common-v1.yaml#/definitions/HttpLink'
  - type: object
    properties:
      value:
        $ref: 'appendixCode.yaml#/definitions/AppendixCodeValue'
```

## Filtering

A collection may support [query parameters](#query-parameters) to filter its items:

- a query parameter with the name of a document property, filters items on the specified value

- the query parameter `q` is reserved for a full text search on all the document’s content

- other filter parameters may be supported, e.g. to look up items within a search period

Unless the API documentation explicitly states otherwise, returned collection items:

- should satisfy ALL filter query parameters (AND-logic)

- have to match ANY of the values of a multi-valued filter query parameter (OR-logic).

For example, the query
`GET /cars?doors=5&color=black&color=blue` should be interpreted by default as: "search for all cars that have 5 doors AND are of color blue OR black".

<table>
<colgroup>
<col style="width: 16%" />
<col style="width: 33%" />
<col style="width: 50%" />
</colgroup>
<tbody>
<tr class="odd">
<td style="text-align: left;"><p><a href="#get">???</a></p></td>
<td style="text-align: left;"><p>/employers</p></td>
<td style="text-align: left;"><p>get all the employers documents in the collection</p></td>
</tr>
<tr class="even">
<td colspan="3" style="text-align: left;"><p>​​​Parameters</p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><p>name</p></td>
<td style="text-align: left;"><p>query-param</p></td>
<td style="text-align: left;"><p>Filter only employers that have a specific name.</p></td>
</tr>
<tr class="even">
<td colspan="3" style="text-align: left;"><p>Response</p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><p>body</p></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"><div class="sourceCode" id="cb1"><pre class="sourceCode json"><code class="sourceCode json"><span id="cb1-1"><a href="#cb1-1" aria-hidden="true" tabindex="-1"></a><span class="fu">{</span></span>
<span id="cb1-2"><a href="#cb1-2" aria-hidden="true" tabindex="-1"></a>  <span class="dt">&quot;self&quot;</span><span class="fu">:</span> <span class="st">&quot;{API}/companies?name=belg[/companies?name=belg^]&quot;</span><span class="fu">,</span></span>
<span id="cb1-3"><a href="#cb1-3" aria-hidden="true" tabindex="-1"></a>    <span class="dt">&quot;items&quot;</span><span class="fu">:</span> <span class="ot">[</span><span class="fu">{</span></span>
<span id="cb1-4"><a href="#cb1-4" aria-hidden="true" tabindex="-1"></a>        <span class="dt">&quot;href&quot;</span><span class="fu">:</span> <span class="st">&quot;{API}/companies/202239951[/companies/202239951^]&quot;</span><span class="fu">,</span></span>
<span id="cb1-5"><a href="#cb1-5" aria-hidden="true" tabindex="-1"></a>        <span class="dt">&quot;title&quot;</span><span class="fu">:</span> <span class="st">&quot;Belgacom&quot;</span></span>
<span id="cb1-6"><a href="#cb1-6" aria-hidden="true" tabindex="-1"></a>    <span class="fu">}</span><span class="ot">,</span> <span class="fu">{</span></span>
<span id="cb1-7"><a href="#cb1-7" aria-hidden="true" tabindex="-1"></a>        <span class="dt">&quot;href&quot;</span><span class="fu">:</span> <span class="st">&quot;{API}/companies/448826918[/companies/448826918^]&quot;</span><span class="fu">,</span></span>
<span id="cb1-8"><a href="#cb1-8" aria-hidden="true" tabindex="-1"></a>        <span class="dt">&quot;title&quot;</span><span class="fu">:</span> <span class="st">&quot;Carrefour Belgium SA&quot;</span></span>
<span id="cb1-9"><a href="#cb1-9" aria-hidden="true" tabindex="-1"></a>    <span class="fu">}</span><span class="ot">]</span><span class="fu">,</span></span>
<span id="cb1-10"><a href="#cb1-10" aria-hidden="true" tabindex="-1"></a>    <span class="dt">&quot;total&quot;</span><span class="fu">:</span> <span class="dv">2</span></span>
<span id="cb1-11"><a href="#cb1-11" aria-hidden="true" tabindex="-1"></a><span class="fu">}</span></span></code></pre></div></td>
</tr>
<tr class="even">
<td colspan="3" style="text-align: left;"><p>Most used response codes
​​</p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><p><a href="#http-200">200</a></p></td>
<td style="text-align: left;"><p>OK</p></td>
<td style="text-align: left;"><p>Default response code, also when the filtered collection is empty.</p></td>
</tr>
<tr class="even">
<td style="text-align: left;"><p><a href="#http-400">400</a></p></td>
<td style="text-align: left;"><p>Bad Request</p></td>
<td style="text-align: left;"><p>Generic error on client side. For example, the syntax of the request is invalid.</p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><p><a href="#http-404">404</a></p></td>
<td style="text-align: left;"><p>Not found</p></td>
<td style="text-align: left;"><p>The URI provided cannot be mapped to a resource.
​</p></td>
</tr>
</tbody>
</table>

<div class="warning">

​[204 No content](#http-204) should not be used with GET.

</div>

    GET {API}/companies?name=belg[^] HTTP/1.1​

## Pagination

Collection with too many items MUST support pagination.
There are two pagination techniques:

- offset-based pagination: numeric offset identifies a page

- cursor-based (aka key-based or luke index): a unique key element identifies a page

Cursor-based pagination has some advantages, especially for high volumes.
Take into account the considerations [listed in the Zalando API guidelines](http://zalando.github.io/restful-api-guidelines/#160) before choosing a pagination technique.

|            |                                              |                                                                                                                                                                              |
|------------|----------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `next`     | MANDATORY (except for the last page)         | hyperlink to the next page                                                                                                                                                   |
| `prev`     | OPTIONAL                                     | hyperlink to the previous page                                                                                                                                               |
| `pageSize` | RECOMMENDED                                  | Maximum number of items per page. For the last page, its value should be independent of the number of actually returned items.                                               |
| `page`     | MANDATORY (offset-based); N/A (cursor-based) | index of the current page of items, should be 1-based (the default and first page is 1)                                                                                      |
| `first`    | OPTIONAL                                     | hyperlink to the first page                                                                                                                                                  |
| `last`     | OPTIONAL                                     | hyperlink to the last page                                                                                                                                                   |
| `total`    | OPTIONAL                                     | Total number of items across all pages. If query parameters are used to filter the result set, this is the total of the collection result set, not of the entire collection. |

Reserved JSON properties:

The names of the properties with hyperlink values and the `items` property are derived from the [IANA registered link relations](https://www.iana.org/assignments/link-relations/link-relations.xml).

|            |                                                                   |                                                                                          |
|------------|-------------------------------------------------------------------|------------------------------------------------------------------------------------------|
| `pageSize` | OPTIONAL                                                          | maximum number of items per page desired by client; must have a default value if absent. |
| `page`     | MANDATORY with default value 1 (offset-based); N/A (cursor-based) | the index of page to be retrieved                                                        |

Reserved query parameters:

    GET {API}/companies?page=2&pageSize=2[^] HTTP/1.1​

``` json
{
  "self": "{API}/companies?page=2&pageSize=2[/companies?page=2&pageSize=2^]",
  "items": [
    {
      "href": "{API}/companies/202239951[/companies/202239951^]",
      "title": "Belgacom"
    },
    {
      "href": "{API}/companies/212165526[/companies/212165526^]",
      "title": "CPAS de Silly"
    }
  ],
  "pageSize": 2,
  "total": 7,
  "first": "{API}/companies?pageSize=2[/companies?pageSize=2^]",
  "last": "{API}/companies?page=4&pageSize=2[/companies?page=4&pageSize=2^]",
  "prev": "{API}/companies?page=1&pageSize=2[/companies?page=1&pageSize=2^]",
  "next": "{API}/companies?page=3&pageSize=2[/companies?page=3&pageSize=2^]"
}
```

    GET {API}/companies?afterCompany=0244640631[^] HTTP/1.1​

``` json
{
  "self": "{API}/companies?afterCompany=0244640631&pageSize=2[/companies?afterCompany=0244640631&pageSize=2^]",
  "items": [
    {
      "href": "{API}/companies/202239951[/companies/202239951^]",
      "title": "Belgacom"
    },
    {
      "href": "{API}/companies/212165526[/companies/212165526^]",
      "title": "CPAS de Silly"
    }
  ],
  "pageSize": 2,
  "total": 7,
  "first": "{API}/companies?pageSize=2[/companies?pageSize=2^]",
  "next": "{API}/companies?afterCompany=0212165526&pageSize=2[/companies?afterCompany=0212165526&pageSize=2^]"
}
```

## Create a new resource​

The collection resource can be used to create new document resources from the `POST` request body.
Absent optional values are set to their default value if one is specified in the OpenAPI specification.

<table>
<colgroup>
<col style="width: 16%" />
<col style="width: 33%" />
<col style="width: 50%" />
</colgroup>
<tbody>
<tr class="odd">
<td style="text-align: left;"><p>​​​​​​​​​<a href="#post">???</a></p></td>
<td style="text-align: left;"><p>/employers</p></td>
<td style="text-align: left;"><p>create a new employer in the collection</p></td>
</tr>
<tr class="even">
<td colspan="3" style="text-align: left;"><p>​​​Request</p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><p>body</p></td>
<td style="text-align: left;"><p>​The data of the resource to create.</p></td>
<td style="text-align: left;"><div class="sourceCode" id="cb1"><pre class="sourceCode json"><code class="sourceCode json"><span id="cb1-1"><a href="#cb1-1" aria-hidden="true" tabindex="-1"></a><span class="fu">{</span></span>
<span id="cb1-2"><a href="#cb1-2" aria-hidden="true" tabindex="-1"></a>  <span class="dt">&quot;name&quot;</span><span class="fu">:</span> <span class="st">&quot;Belgacom&quot;</span><span class="fu">,</span></span>
<span id="cb1-3"><a href="#cb1-3" aria-hidden="true" tabindex="-1"></a>  <span class="dt">&quot;employerId&quot;</span><span class="fu">:</span> <span class="dv">93017373</span><span class="fu">,</span></span>
<span id="cb1-4"><a href="#cb1-4" aria-hidden="true" tabindex="-1"></a>  <span class="dt">&quot;company&quot;</span><span class="fu">:</span> <span class="fu">{</span></span>
<span id="cb1-5"><a href="#cb1-5" aria-hidden="true" tabindex="-1"></a>    <span class="dt">&quot;enterpriseNumber&quot;</span><span class="fu">:</span> <span class="st">&quot;0202239951&quot;</span></span>
<span id="cb1-6"><a href="#cb1-6" aria-hidden="true" tabindex="-1"></a>  <span class="fu">}</span></span>
<span id="cb1-7"><a href="#cb1-7" aria-hidden="true" tabindex="-1"></a><span class="fu">}</span></span></code></pre></div></td>
</tr>
<tr class="even">
<td colspan="3" style="text-align: left;"><p>Response headers</p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><p>Location</p></td>
<td style="text-align: left;"><p>http-header</p></td>
<td style="text-align: left;"><p>The URI of the newly created resource e.g. /employers/93017373</p></td>
</tr>
<tr class="even">
<td colspan="3" style="text-align: left;"><p>Response</p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><p>body</p></td>
<td style="text-align: left;"><p>​</p></td>
<td style="text-align: left;"><p>The API should specify for each creation operation, if it returns:</p>
<ul>
<li><p>an empty body,</p></li>
<li><p>a partial resource representation (e.g. only a generated resource identifier),</p></li>
<li><p>or a full resource representation.</p></li>
</ul></td>
</tr>
<tr class="even">
<td colspan="3" style="text-align: left;"><p>Most used response codes
​​</p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><p><a href="#http-201">201</a></p></td>
<td style="text-align: left;"><p>Created</p></td>
<td style="text-align: left;"><p>Default response code if the resource is created.</p></td>
</tr>
<tr class="even">
<td style="text-align: left;"><p><a href="#http-409">409</a></p></td>
<td style="text-align: left;"><p>Conflict</p></td>
<td style="text-align: left;"><p>The resource could not be created because the request is in conflict with the current state of the resource. E.g. the resource already exists (duplicate key violation).</p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><p><a href="#http-303">303</a></p></td>
<td style="text-align: left;"><p>See Other</p></td>
<td style="text-align: left;"><p>The resource already exists.
May be returned instead of <code>409 Conflict</code> if it is considered a normal use case to perform the operation for an already existing resource.
The <code>Location</code> header refers to the resource.</p></td>
</tr>
</tbody>
</table>

<div class="warning">

​[200 OK](#http-200) should not be used with POST for creating resources.

</div>

    POST /employers HTTP/1.1

    HTTP/1.1 201 Created
    Location: /employers/93017373
    Content-Length: 0
    Date: Wed, 06 Jan 2016 15:37:16 GMT

## Remove

A selection of items can be removed from a collection using the DELETE method. In fact, the collection itself cannot be removed, but it can be emptied if all its items are removed.
By using query parameters, the items to be removed can be filtered.
In order to remove a single specific item from a collection, use [DELETE on the document resource](#remove-document).

|                          |             |                                                                                                                    |
|--------------------------|-------------|--------------------------------------------------------------------------------------------------------------------|
| [???](#delete)           | /employers  | Delete all the employers documents in the collection.                                                              |
| Parameters               |             |                                                                                                                    |
| name                     | query-param | Remove only employers that have a specific name.                                                                   |
| Response                 |             |                                                                                                                    |
| body                     |             | Empty or a message incidating success.                                                                             |
| Most used response codes |             |                                                                                                                    |
| [200](#http-200)         | OK          | The items are successfully removed from the collection and returned.                                               |
| [204](#http-204)         | No content  | The items are successfully removed from the collection but no additional content is included in the response body. |
| [400](#http-400)         | Bad Request | Generic error on client side. For example, the syntax of the request is invalid.                                   |
| [404](#http-404)         | Not found   | The collection resource does not exist and thus cannot be deleted.                                                 |
