---
title: Reserved words
weight: 120
---

A list of reserved words exists for common used practices

## Query parameters

| Term                                            | Description                                                                                                    | Example                | Ref                                 |
|-------------------------------------------------|----------------------------------------------------------------------------------------------------------------|------------------------|-------------------------------------|
| <span id="query-param-page"></span>page         | When a collection resources is paged, use this parameter to request a specific page. Page numbers are 1-based. | ?page=3&pageSize=20    | [???](#Pagination)                  |
| <span id="query-param-pageSize"></span>pageSize | When a collection resources is paged, use this parameter to specify the page size.                             | ?page=3&pageSize=20    | [???](#Pagination)                  |
| <span id="query-param-q"></span>q               | The standard search parameter to do a full-text search.                                                        | ?q=Belgacom            | [???](#Filtering)                   |
| <span id="query-param-select"></span>select     | Filter the resource properties to the ones specified.                                                          | ?select=(name,address) | [???](#document-consult)            |
| <span id="query-param-sort"></span>sort         | Multi-value query param with list of properties to sort on.                                                    
                                                   Default sorting direction is ascending. To indicate descending direction, the property may be prefixed with -.  | ?sort=age&sort=-name   | [???](#Collection)                  |
| embed                                           | Request to embed subresource                                                                                   | ?embed=mainAddress     | [???](#Embedding resources)         |
| <span id="query-param-lang"></span>lang         | language to filter multi-language descriptions                                                                 | ?lang=fr               | [???](#Multi-language descriptions) |

## JSON properties

<table>
<colgroup>
<col style="width: 12%" />
<col style="width: 37%" />
<col style="width: 37%" />
<col style="width: 12%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align: left;">Term</th>
<th style="text-align: left;">Description</th>
<th style="text-align: left;">Example</th>
<th style="text-align: left;">Ref</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;"><p><span id="rel-next"></span>next</p></td>
<td style="text-align: left;"><p>The next-reference contains the absolute URL of the next page in a paged collection result.</p></td>
<td style="text-align: left;"><div class="sourceCode" id="cb1"><pre class="sourceCode json"><code class="sourceCode json"><span id="cb1-1"><a href="#cb1-1" aria-hidden="true" tabindex="-1"></a><span class="er">&quot;next&quot;:</span> <span class="er">&quot;</span><span class="fu">{</span><span class="er">API</span><span class="fu">}</span><span class="er">/companies?page=3&amp;pageSize=2</span><span class="ot">[</span><span class="er">/companies?page=</span><span class="dv">3</span><span class="er">&amp;pageSize=</span><span class="dv">2</span><span class="er">^</span><span class="ot">]</span><span class="er">&quot;</span></span></code></pre></div></td>
<td style="text-align: left;"><p><a href="#Links">???</a></p></td>
</tr>
<tr class="even">
<td style="text-align: left;"><p><span id="rel-previous"></span>prev</p></td>
<td style="text-align: left;"><p>The previous-reference contains the absolute URL of the previous page in a paged collection result.</p></td>
<td style="text-align: left;"><div class="sourceCode" id="cb2"><pre class="sourceCode json"><code class="sourceCode json"><span id="cb2-1"><a href="#cb2-1" aria-hidden="true" tabindex="-1"></a><span class="er">&quot;prev&quot;:</span> <span class="er">&quot;</span><span class="fu">{</span><span class="er">API</span><span class="fu">}</span><span class="er">/companies?page=1&amp;pageSize=2</span><span class="ot">[</span><span class="er">/companies?page=</span><span class="dv">3</span><span class="er">&amp;pageSize=</span><span class="dv">2</span><span class="er">^</span><span class="ot">]</span><span class="er">&quot;</span></span></code></pre></div></td>
<td style="text-align: left;"><p><a href="#Links">???</a></p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><p><span id="rel-self"></span>self</p></td>
<td style="text-align: left;"><p>The self-reference contains the absolute URL of the resource itself.</p></td>
<td style="text-align: left;"><div class="sourceCode" id="cb3"><pre class="sourceCode json"><code class="sourceCode json"><span id="cb3-1"><a href="#cb3-1" aria-hidden="true" tabindex="-1"></a><span class="er">&quot;self&quot;:</span> <span class="er">&quot;</span><span class="fu">{</span><span class="er">API</span><span class="fu">}</span><span class="er">/companies/202239951</span><span class="ot">[</span><span class="er">/companies/</span><span class="dv">202239951</span><span class="er">^</span><span class="ot">]</span><span class="er">&quot;</span></span></code></pre></div></td>
<td style="text-align: left;"><p><a href="#Links">???</a></p></td>
</tr>
<tr class="even">
<td style="text-align: left;"><p><span id="rel-href"></span>href</p></td>
<td style="text-align: left;"><p>A reference (absolute URL) to another resource.</p></td>
<td style="text-align: left;"><div class="sourceCode" id="cb4"><pre class="sourceCode json"><code class="sourceCode json"><span id="cb4-1"><a href="#cb4-1" aria-hidden="true" tabindex="-1"></a><span class="er">&quot;href&quot;:</span> <span class="er">&quot;</span><span class="fu">{</span><span class="er">API</span><span class="fu">}</span><span class="er">/companies/202239951</span><span class="ot">[</span><span class="er">/companies/</span><span class="dv">202239951</span><span class="er">^</span><span class="ot">]</span><span class="er">&quot;</span></span></code></pre></div></td>
<td style="text-align: left;"><p><a href="#Links">???</a></p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><p><span id="rel-first"></span>first</p></td>
<td style="text-align: left;"><p>A reference (absolute URL) to the first page in a paged collection result.</p></td>
<td style="text-align: left;"><div class="sourceCode" id="cb5"><pre class="sourceCode json"><code class="sourceCode json"><span id="cb5-1"><a href="#cb5-1" aria-hidden="true" tabindex="-1"></a><span class="er">&quot;first&quot;:</span> <span class="er">&quot;</span><span class="fu">{</span><span class="er">API</span><span class="fu">}</span><span class="er">/companies?pageSize=2&quot;</span></span></code></pre></div></td>
<td style="text-align: left;"><p><a href="#Pagination">???</a></p></td>
</tr>
<tr class="even">
<td style="text-align: left;"><p><span id="rel-last"></span>last</p></td>
<td style="text-align: left;"><p>A reference (absolute URL) to the last page in a paged collection result.</p></td>
<td style="text-align: left;"><div class="sourceCode" id="cb6"><pre class="sourceCode json"><code class="sourceCode json"><span id="cb6-1"><a href="#cb6-1" aria-hidden="true" tabindex="-1"></a><span class="er">&quot;last&quot;:</span> <span class="er">&quot;</span><span class="fu">{</span><span class="er">API</span><span class="fu">}</span><span class="er">/companies?page=4&amp;pageSize=2&quot;,</span></span></code></pre></div></td>
<td style="text-align: left;"><p><a href="#Pagination">???</a></p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><p>items</p></td>
<td style="text-align: left;"><p>an array with the items of a collection result.</p></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"><p><a href="#Collection">???</a></p></td>
</tr>
<tr class="even">
<td style="text-align: left;"><p>total</p></td>
<td style="text-align: left;"><p>the total number of items in a collection result, after filtering.</p></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"><p><a href="#Collection">???</a></p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><p>page</p></td>
<td style="text-align: left;"><p>the index of a page in a paged collection result</p></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"><p><a href="#Pagination">???</a></p></td>
</tr>
<tr class="even">
<td style="text-align: left;"><p>pageSize</p></td>
<td style="text-align: left;"><p>the maximum number of items in a page of a paged collection result.</p></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"><p><a href="#Pagination">???</a></p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><p>embedded</p></td>
<td style="text-align: left;"><p>a map of embedded subresources, with URIs as property key and the resource as value</p></td>
<td style="text-align: left;"></td>
<td style="text-align: left;"><p><a href="#Embedding resources">???</a></p></td>
</tr>
</tbody>
</table>

## HTTP headers

[This list](https://en.wikipedia.org/wiki/List_of_HTTP_header_fields) includes all standardized and common non-standard HTTP headers.

Custom HTTP headers SHOULD be prefixed with the organization’s name.

Custom headers that are standardized across Belgian Government organizations use the `BelGov-` prefix.

`X-` headers were initially reserved for non-standardized parameters, but the usage of `X-` headers is deprecated ([RFC-6648](https://tools.ietf.org/html/rfc6648)).
Instead, it is recommended that company specific header' names should incorporate the organization’s name.
However, for backwards compatibility reasons, headers with the `X-` prefix may still be used.

| HTTP Header            | Type             | Description                                                                                                             | Reference                                                                                                         |
|------------------------|------------------|-------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------|
| Location               | Response         | Used in redirection, or when a new resource has been created.                                                           | [???](#Create a new resource​), [???](#POST), status codes [301](#http-301), [303](#http-303) and [307](#http-307) |
| Accept                 | Request          | Media type(s) that is(/are) acceptable for the response.                                                                | [???](#Media Types)                                                                                               |
| Content-Type           | Request/Response | The Media type of the body of the request.                                                                              | [???](#Media Types)                                                                                               |
| X-HTTP-Method-Override | Request          | Override the method specified in the request.                                                                           | [???](#PATCH)                                                                                                     |
| Retry-After            | Response         | Suggest amount of time for the client to wait before retrying the request when temporarily unavailable or quota reached | [???](#Service Unavailable), [???](#Too Many Requests), [???](#Too Many Failed Requests)                          |
| Allow                  | Response         | Valid methods for a specified resource.                                                                                 | [???](#http-405)                                                                                                  |
| ETag                   | Request          | Identifier for returned response content                                                                                | [???](#Conditional requests)                                                                                      |
| If-None-Match          | Response         | Return resource if ETag changed                                                                                         | [???](#Conditional requests)                                                                                      |
| Last-Modified          | Request          | Time on which resource was last modified                                                                                | [???](#Conditional requests)                                                                                      |
| If-Modified-Since      | Response         | Return resource only if changed since specified timestamp                                                               | [???](#Conditional requests)                                                                                      |
| Vary                   | Response         | Specifies which request headers change response content                                                                 | [???](#Client caching directives)                                                                                 |
| Cache-Control          | Response         | Indicates HTTP client how to cache responses                                                                            | [???](#Client caching directives)                                                                                 |

Standard HTTP Headers referenced in the style guide

| HTTP Header             | Type             | Description                                                         | Reference       |
|-------------------------|------------------|---------------------------------------------------------------------|-----------------|
| Company-Trace-Id         | Request/Response | Unique ID for tracing purposes, identifying the request or response | [???](#Tracing) |
| Company-Related-Trace-Id | Response         | BelGov-Trace-Id value used on related request                       | [???](#Tracing) |

    
## Resource names

| path                                                                         | Description                                                             | Reference |
|------------------------------------------------------------------------------|-------------------------------------------------------------------------|-----------|
| /docs | Browseable API documentation UI |
| /openapi.json | API documentation (swagger file and other)                              | ???       |
| /refData                                                                     | resources representing reference data used in the API (i.e. code lists) | ???       |
| /health                                                                      | API health status                                                       | ???       |
| /metrics | Metric responses | |

