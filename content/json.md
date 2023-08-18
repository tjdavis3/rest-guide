---
title: JSON
weight: 90
---

All RESTful services must support **JSON** (Javascript Object Notation [RFC 7159](https://tools.ietf.org/html/rfc7159)).

For extensibility, the payload (if any) of a RESTful request or response should always be a JSON object instead of an array, string, number, etc ([???](#rule-evo-object)).
This way the request or response can always be extended with new properties ( [???](#rule-evo-compat)).

Following guidelines SHOULD be respected when determining a name for a JSON property:

- use *lowerCamelCase* notation

  - also for abbreviations: all letters after the first should be lowercase

- use American English

- do not use underscores (\_), hyphens (-) or dots (.) in a property name, nor use a digit as first letter

- don’t use overly generic terms like `info(rmation)` and `data` as property name or as part of it

- the name should refer to the business meaning of its value in relation to the object in which it is specified, rather than how it is defined

- omit parts of the name that are already clear from the context

Properties used from other standards, like OpenID Connect and OAuth2, are allowed to deviate from this rule.

<table>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align: left;">KO</th>
<th style="text-align: left;">OK</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;"><p>SSIN</p></td>
<td style="text-align: left;"><p>ssin</p></td>
</tr>
<tr class="even">
<td style="text-align: left;"><p>street_RRN</p></td>
<td style="text-align: left;"><p>streetRrn</p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><p>customerInformation</p></td>
<td style="text-align: left;"><p>customer</p></td>
</tr>
<tr class="even">
<td style="text-align: left;"><p>descriptionStringLength140</p></td>
<td style="text-align: left;"><p>description</p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><div class="sourceCode" id="cb1"><pre class="sourceCode JSON"><code class="sourceCode json"><span id="cb1-1"><a href="#cb1-1" aria-hidden="true" tabindex="-1"></a><span class="er">&quot;country&quot;:</span> <span class="fu">{</span></span>
<span id="cb1-2"><a href="#cb1-2" aria-hidden="true" tabindex="-1"></a>  <span class="dt">&quot;countryNisCode&quot;</span><span class="fu">:</span> <span class="dv">150</span><span class="fu">,</span></span>
<span id="cb1-3"><a href="#cb1-3" aria-hidden="true" tabindex="-1"></a>  <span class="dt">&quot;countryIsoCode&quot;</span><span class="fu">:</span> <span class="st">&quot;BE&quot;</span><span class="fu">,</span></span>
<span id="cb1-4"><a href="#cb1-4" aria-hidden="true" tabindex="-1"></a>  <span class="dt">&quot;countryName&quot;</span><span class="fu">:</span> <span class="st">&quot;Belgium&quot;</span></span>
<span id="cb1-5"><a href="#cb1-5" aria-hidden="true" tabindex="-1"></a><span class="fu">}</span></span></code></pre></div></td>
<td style="text-align: left;"><div class="sourceCode" id="cb2"><pre class="sourceCode JSON"><code class="sourceCode json"><span id="cb2-1"><a href="#cb2-1" aria-hidden="true" tabindex="-1"></a><span class="er">&quot;country&quot;:</span> <span class="fu">{</span></span>
<span id="cb2-2"><a href="#cb2-2" aria-hidden="true" tabindex="-1"></a>  <span class="dt">&quot;nisCode&quot;</span><span class="fu">:</span> <span class="dv">150</span><span class="fu">,</span></span>
<span id="cb2-3"><a href="#cb2-3" aria-hidden="true" tabindex="-1"></a>  <span class="dt">&quot;isoCode&quot;</span><span class="fu">:</span> <span class="st">&quot;BE&quot;</span><span class="fu">,</span></span>
<span id="cb2-4"><a href="#cb2-4" aria-hidden="true" tabindex="-1"></a>  <span class="dt">&quot;name&quot;</span><span class="fu">:</span> <span class="st">&quot;Belgium&quot;</span></span>
<span id="cb2-5"><a href="#cb2-5" aria-hidden="true" tabindex="-1"></a><span class="fu">}</span></span></code></pre></div></td>
</tr>
</tbody>
</table>

In below example, `enterpriseNumber` should be used even though the `enterprise` prefix is clear by its context.
This is because `enterpriseNumber` is a fixed denomination (declared in Crossroads Bank for Enterprises) and using just `number` would rather cause confusion to type of identifier being used.

``` json
{
  "name": "Belgacom",
  "employerId": 93017373,
  "enterprise": {
    "enterpriseNumber": "0202239951"
    "href": "/organizations/0202239951"
  }
}
```

Properties with a `null` value SHOULD be stripped from the JSON message.

A notable exception to this rule are JSON Merge Patch requests, in which a `null` value indicates the removal of a JSON property.

Note that this rule doesn’t apply to empty values (e.g. empty strings `""` or empty arrays `[]`) as they are considered different from a `null` value.

<table>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<tbody>
<tr class="odd">
<td style="text-align: left;"><p><strong>NOK</strong></p></td>
<td style="text-align: left;"><p><strong>OK</strong></p></td>
</tr>
<tr class="even">
<td style="text-align: left;"><div class="sourceCode" id="cb1"><pre class="sourceCode json"><code class="sourceCode json"><span id="cb1-1"><a href="#cb1-1" aria-hidden="true" tabindex="-1"></a><span class="fu">{</span></span>
<span id="cb1-2"><a href="#cb1-2" aria-hidden="true" tabindex="-1"></a>  <span class="dt">&quot;name&quot;</span><span class="fu">:</span> <span class="st">&quot;Belgacom&quot;</span><span class="fu">,</span></span>
<span id="cb1-3"><a href="#cb1-3" aria-hidden="true" tabindex="-1"></a>  <span class="dt">&quot;employerId&quot;</span><span class="fu">:</span> <span class="dv">93017373</span><span class="fu">,</span></span>
<span id="cb1-4"><a href="#cb1-4" aria-hidden="true" tabindex="-1"></a>  <span class="dt">&quot;enterprise&quot;</span><span class="fu">:</span> <span class="kw">null</span></span>
<span id="cb1-5"><a href="#cb1-5" aria-hidden="true" tabindex="-1"></a><span class="fu">}</span></span></code></pre></div></td>
<td style="text-align: left;"><div class="sourceCode" id="cb2"><pre class="sourceCode json"><code class="sourceCode json"><span id="cb2-1"><a href="#cb2-1" aria-hidden="true" tabindex="-1"></a><span class="fu">{</span></span>
<span id="cb2-2"><a href="#cb2-2" aria-hidden="true" tabindex="-1"></a>  <span class="dt">&quot;name&quot;</span><span class="fu">:</span> <span class="st">&quot;Belgacom&quot;</span><span class="fu">,</span></span>
<span id="cb2-3"><a href="#cb2-3" aria-hidden="true" tabindex="-1"></a>  <span class="dt">&quot;employerId&quot;</span><span class="fu">:</span> <span class="dv">93017373</span></span>
<span id="cb2-4"><a href="#cb2-4" aria-hidden="true" tabindex="-1"></a><span class="fu">}</span></span></code></pre></div></td>
</tr>
</tbody>
</table>

**The JSON properties have no specific order inside a JSON object.**

<table>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<tbody>
<tr class="odd">
<td style="text-align: left;"><div class="sourceCode" id="cb1"><pre class="sourceCode json"><code class="sourceCode json"><span id="cb1-1"><a href="#cb1-1" aria-hidden="true" tabindex="-1"></a><span class="fu">{</span></span>
<span id="cb1-2"><a href="#cb1-2" aria-hidden="true" tabindex="-1"></a>  <span class="dt">&quot;name&quot;</span><span class="fu">:</span> <span class="st">&quot;Belgacom&quot;</span><span class="fu">,</span></span>
<span id="cb1-3"><a href="#cb1-3" aria-hidden="true" tabindex="-1"></a>  <span class="dt">&quot;employerId&quot;</span><span class="fu">:</span> <span class="dv">93017373</span></span>
<span id="cb1-4"><a href="#cb1-4" aria-hidden="true" tabindex="-1"></a><span class="fu">}</span></span></code></pre></div></td>
<td style="text-align: left;"><div class="sourceCode" id="cb2"><pre class="sourceCode json"><code class="sourceCode json"><span id="cb2-1"><a href="#cb2-1" aria-hidden="true" tabindex="-1"></a><span class="fu">{</span></span>
<span id="cb2-2"><a href="#cb2-2" aria-hidden="true" tabindex="-1"></a>  <span class="dt">&quot;employerId&quot;</span><span class="fu">:</span> <span class="dv">93017373</span><span class="fu">,</span></span>
<span id="cb2-3"><a href="#cb2-3" aria-hidden="true" tabindex="-1"></a>  <span class="dt">&quot;name&quot;</span><span class="fu">:</span> <span class="st">&quot;Belgacom&quot;</span></span>
<span id="cb2-4"><a href="#cb2-4" aria-hidden="true" tabindex="-1"></a><span class="fu">}</span></span></code></pre></div></td>
</tr>
</tbody>
</table>

**Dates are written in ISO 8601 full-date format: yyyy-MM-dd**

See [OpenAPI 3.0 data types](https://github.com/OAI/OpenAPI-Specification/blob/main/versions/3.0.3.md#data-types) and [RFC 3339 section 5.6](https://tools.ietf.org/html/rfc3339#section-5.6).

``` json
{
  "birthday": "1930-07-19"
}
```

**Date/time are written in ISO 8601 date-time format: yyyy-MM-dd’T’HH:mm:ss.SSSXXX**

See [JSON Schema Validation 7.3.1. date-time](https://tools.ietf.org/html/draft-fge-json-schema-validation-00#section-7.3.1) and [RFC 3339 section 5.6](https://tools.ietf.org/html/rfc3339#section-5.6).
The fraction part for sub second precision is optional and may be of any length.

<div class="formalpara-title">

**Example UTC**

</div>

``` json
{
  "lastModification": "2016-04-24T09:26:01.5214Z"
}
```

<div class="formalpara-title">

**Example with timezone**

</div>

``` json
{
  "lastModification": "2016-04-24T11:26:00+02:00"
}
```
