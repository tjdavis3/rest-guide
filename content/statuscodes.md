---
title: Status codes
weight: 60
---

The full list of HTTP status codes is documented [here](http://www.ietf.org/assignments/http-status-codes/http-status-codes.xml).

In order to conform to the REST uniform service contract, REST services should stick to this reduced list of status codes.

[This HTTP status codes chart](http://for-get.github.io/http-decision-diagram/httpdd.fsm.html) (takes a while to load) shows a decision tree to determine the usage of the correct HTTP status code.

## 1xx Informational

Request received, continuing process.

## 2xx Success

The action was successfully received, understood, and accepted.

<table>
<colgroup>
<col style="width: 14%" />
<col style="width: 57%" />
<col style="width: 28%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align: left;">Code</th>
<th style="text-align: left;">Description</th>
<th style="text-align: left;">Methods</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;"><p><span id="http-200"></span>200 OK</p></td>
<td style="text-align: left;"><p><strong>200 (“OK”) should be used to indicate nonspecific success</strong></p>
<p>In most cases, 200 is the code the client hopes to see. It indicates that the REST API successfully carried out whatever action the client requested, and that no more specific code in the 2xx series is appropriate. Unlike the 204 status code, a 200 response should include a response body.</p></td>
<td style="text-align: left;"><p><a href="#GET">GET</a>, <a href="#HEAD">HEAD</a>, <a href="#PUT">PUT</a>, <a href="#PATCH">PATCH</a>, <a href="#DELETE">DELETE</a>, <a href="#OPTIONS">OPTIONS</a></p></td>
</tr>
<tr class="even">
<td style="text-align: left;"><p><span id="http-201"></span>201 Created</p></td>
<td style="text-align: left;"><p><strong>201 (“Created”) must be used to indicate successful resource creation</strong></p>
<p>A REST API responds with the 201 status code whenever a collection creates, or a store adds, a new resource at the client’s request. The response body may be empty or contain a partial or full representation of the new resource.
There may also be times when a new resource is created as a result of some custom POST action, in which case 201 would also be an appropriate response.</p></td>
<td style="text-align: left;"><p>​<a href="#POST">POST</a></p>
<p><a href="#PUT">PUT</a> only in case it is used to create a new document resource.</p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><p><span id="http-202"></span>202 Accepted</p></td>
<td style="text-align: left;"><p><strong>202 (“Accepted”) must be used to indicate successful start of an asynchronous action</strong></p>
<p>A 202 response indicates that the client’s request will be handled asynchronously. This response status code tells the client that the request appears valid, but it still may have problems once it’s finally processed. A 202 response is typically used for actions that take a long while to process (see <a href="#long-running-tasks">???</a>).
A POST method may send 202 responses, but other methods should not.</p></td>
<td style="text-align: left;"><p>​<a href="#POST">POST</a></p></td>
</tr>
<tr class="even">
<td style="text-align: left;"><p><span id="http-204"></span>204 No Content</p></td>
<td style="text-align: left;"><p><strong>204 (“No Content”) should be used when the response body is intentionally empty</strong></p>
<p>The 204 status code is usually sent out in response to a PUT, POST, PATCH or DELETE request, when the REST API declines to send back any status message or representation in the response message’s body.</p></td>
<td style="text-align: left;"><p><a href="#POST">POST</a>, <a href="#HEAD">HEAD</a>, <a href="#PUT">PUT</a>, <a href="#PATCH">PATCH</a>, <a href="#DELETE">DELETE</a>, <a href="#OPTIONS">OPTIONS</a></p></td>
</tr>
</tbody>
</table>

## 3xx Redirection

Further action must be taken in order to complete the request.

<table>
<colgroup>
<col style="width: 14%" />
<col style="width: 57%" />
<col style="width: 28%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align: left;">Code</th>
<th style="text-align: left;">Description</th>
<th style="text-align: left;">Methods</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;"><p><span id="http-301"></span>301 Moved Permanently</p></td>
<td style="text-align: left;"><p><strong>301 (“Moved Permanently”) should be used to relocate resources</strong></p>
<p>The 301 status code indicates that the REST API’s resource model has been significantly redesigned and a new permanent URI has been assigned to the client’s requested resource. The REST API should specify the new URI in the response’s Location header.</p></td>
<td style="text-align: left;"><p>All:
<a href="#GET">GET</a>, <a href="#HEAD">HEAD</a>, <a href="#POST">POST</a>, <a href="#PUT">PUT</a>, <a href="#PATCH">PATCH</a>, <a href="#DELETE">DELETE</a>, <a href="#OPTIONS">OPTIONS</a></p></td>
</tr>
<tr class="even">
<td style="text-align: left;"><p><span id="http-303"></span>303 See Other</p></td>
<td style="text-align: left;"><p><strong>303 (“See Other”) should be used to refer the client to a different URI</strong></p>
<p>The 303 status code allows a REST API to send a reference to a resource without forcing the client to download its state. Instead, the client may send a GET request to the value of the Location header.</p>
<p>It can be used when a long-running action has finished its work, but instead of sending a potentially unwanted response body, it sends the client the URI of a response resource. This can be the URI of a temporary status message, or the URI to some already existing, more permanent, resource.</p></td>
<td style="text-align: left;"><p>All methods are acceptable.</p>
<p>Mostly used with
<a href="#POST">POST</a>.</p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><p><span id="http-304"></span>304 Not Modified</p></td>
<td style="text-align: left;"><p><strong>304 (“Not Modified”) should be used to preserve bandwidth</strong></p>
<p>This status code is similar to 204 (“No Content”) in that the response body must be empty. The key distinction is that 204 is used when there is nothing to send in the body, whereas 304 is used when there is state information associated with a resource but the client already has the most recent version of the representation. This status code is used in conjunction with conditional HTTP requests.</p></td>
<td style="text-align: left;"><p><a href="#GET">GET</a>, <a href="#HEAD">HEAD</a></p></td>
</tr>
<tr class="even">
<td style="text-align: left;"><p><span id="http-307"></span>307 Temporary Redirect</p></td>
<td style="text-align: left;"><p><strong>307 (“Temporary Redirect”) should be used to tell clients to resubmit the request to another URI</strong></p>
<p>A 307 response indicates that the REST API is not going to process the client’s request. Instead, the client should resubmit the request to the URI specified by the response message’s Location header.</p>
<p>A REST API can use this status code to assign a temporary URI to the client’s requested resource. For example, a <code>307</code> response can be used to shift a client request over to another host.</p></td>
<td style="text-align: left;"><p>All:
<a href="#GET">GET</a>, <a href="#HEAD">HEAD</a>, <a href="#POST">POST</a>, <a href="#PUT">PUT</a>, <a href="#PATCH">PATCH</a>, <a href="#DELETE">DELETE</a>, <a href="#OPTIONS">OPTIONS</a></p></td>
</tr>
</tbody>
</table>

## 4xx Client Error

The request contains bad syntax or cannot be fulfilled.

<table>
<colgroup>
<col style="width: 14%" />
<col style="width: 57%" />
<col style="width: 28%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align: left;">Code</th>
<th style="text-align: left;">Description</th>
<th style="text-align: left;">Method</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;"><p><span id="http-400"></span>400 Bad Request</p></td>
<td style="text-align: left;"><p><strong>400 (“Bad Request”) may be used to indicate nonspecific failure</strong>
400 is the generic client-side error status, used when no other 4xx error code is appropriate.</p></td>
<td style="text-align: left;"><p>All:
<a href="#GET">GET</a>, <a href="#HEAD">HEAD</a>, <a href="#POST">POST</a>, <a href="#PUT">PUT</a>, <a href="#PATCH">PATCH</a>, <a href="#DELETE">DELETE</a>, <a href="#OPTIONS">OPTIONS</a></p></td>
</tr>
<tr class="even">
<td style="text-align: left;"><p><span id="http-401"></span>401 Unauthorized</p></td>
<td style="text-align: left;"><p><strong>401 (“Unauthorized”) must be used when there is a problem with the client’s credentials.</strong></p>
<p>A 401 error response indicates that the client tried to operate on a protected resource without providing the proper authorization. It may have provided the wrong credentials or none at all.</p></td>
<td style="text-align: left;"><p>All:
<a href="#GET">GET</a>, <a href="#HEAD">HEAD</a>, <a href="#POST">POST</a>, <a href="#PUT">PUT</a>, <a href="#PATCH">PATCH</a>, <a href="#DELETE">DELETE</a>, <a href="#OPTIONS">OPTIONS</a></p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><p><span id="http-403"></span>403 Forbidden</p></td>
<td style="text-align: left;"><p><strong>403 (“Forbidden”) should be used to forbid access regardless of authorization state.</strong></p>
<p>A 403 error response indicates that the client’s request is formed correctly, but the REST API refuses to honor it. A 403 response is not a case of insufficient client credentials; that would be <code>401 (“Unauthorized”)</code>.</p></td>
<td style="text-align: left;"><p>All:
<a href="#GET">GET</a>, <a href="#HEAD">HEAD</a>, <a href="#POST">POST</a>, <a href="#PUT">PUT</a>, <a href="#PATCH">PATCH</a>, <a href="#DELETE">DELETE</a>, <a href="#OPTIONS">OPTIONS</a></p></td>
</tr>
<tr class="even">
<td style="text-align: left;"><p><span id="http-404"></span>404 Not Found</p></td>
<td style="text-align: left;"><p><strong>404 (“Not Found”) must be used when a client’s URI cannot be mapped to a resource.</strong></p>
<p>The 404 error status code indicates that the REST API can’t map the client’s URI to a resource.</p></td>
<td style="text-align: left;"><p>All:
<a href="#GET">GET</a>, <a href="#HEAD">HEAD</a>, <a href="#PUT">PUT</a>, <a href="#PATCH">PATCH</a>, <a href="#DELETE">DELETE</a>, <a href="#OPTIONS">OPTIONS</a>,
<a href="#POST">POST</a> (if parent resource not found)</p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><p><span id="http-405"></span>405 Method Not Allowed</p></td>
<td style="text-align: left;"><p><strong>405 (“Method Not Allowed”) must be used when the HTTP method is not supported.</strong></p>
<p>The API responds with a 405 error to indicate that the client tried to use an HTTP method that the resource does not allow.
For example, when a PUT or POST action is performed on a read-only resource supporting only GET and HEAD.</p>
<p>A 405 response must include the Allow header, which lists the HTTP methods that the resource supports. For example: <code>Allow: GET, POST</code></p></td>
<td style="text-align: left;"><p>All:
<a href="#GET">GET</a>, <a href="#HEAD">HEAD</a>, <a href="#POST">POST</a>, <a href="#PUT">PUT</a>, <a href="#PATCH">PATCH</a>, <a href="#DELETE">DELETE</a>, <a href="#OPTIONS">OPTIONS</a></p></td>
</tr>
<tr class="even">
<td style="text-align: left;"><p><span id="http-406"></span>406 Not Acceptable</p></td>
<td style="text-align: left;"><p><strong>406 (“Not Acceptable”) must be used when the requested media type cannot be served</strong></p>
<p>The 406 error response indicates that the API is not able to generate any of the client’s preferred media types, as indicated by the <code>Accept</code> request header. For example, a client request for data formatted as <code>application/xml</code> will receive a 406 response if the API is only willing to format data as <code>application/json</code>.</p></td>
<td style="text-align: left;"><p>All:
<a href="#GET">GET</a>, <a href="#HEAD">HEAD</a>, <a href="#POST">POST</a>, <a href="#PUT">PUT</a>, <a href="#PATCH">PATCH</a>, <a href="#DELETE">DELETE</a>, <a href="#OPTIONS">OPTIONS</a></p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><p><span id="http-409"></span>409 Conflict</p></td>
<td style="text-align: left;"><p><strong>409 (“Conflict”) should be used when a request conflicts with the current state of the target resource</strong></p>
<p>The 409 error response tells the client that they tried to put the REST API’s resources into an impossible or inconsistent state. For example, a REST API may return this response code when a client tries to DELETE a non-empty store resource.</p></td>
<td style="text-align: left;"><p><a href="#POST">POST</a>, <a href="#PUT">PUT</a>, <a href="#PATCH">PATCH</a>, <a href="#DELETE">DELETE</a></p></td>
</tr>
<tr class="even">
<td style="text-align: left;"><p><span id="http-412"></span>412 Precondition Failed</p></td>
<td style="text-align: left;"><p><strong>412 (“Precondition Failed”) should be used to support conditional operations</strong></p>
<p>The 412 error response indicates that the client specified one or more preconditions in its request headers, effectively telling the REST API to carry out its request only if certain conditions were met. A 412 response indicates that those conditions were not met, so instead of carrying out the request, the API sends this status code.</p>
<p><strong>Only use for <a href="http://tools.ietf.org/html/rfc7232">conditional HTTP requests</a>, not constraints expressed in the HTTP payload.</strong> Use <a href="#http-409"><code>409 Conflict</code></a> instead.</p></td>
<td style="text-align: left;"><p><a href="#POST">POST</a>, <a href="#PUT">PUT</a>, <a href="#PATCH">PATCH</a>, <a href="#DELETE">DELETE</a></p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><p><span id="http-413"></span>413 Payload Too Large</p></td>
<td style="text-align: left;"><p><strong>413 (“Payload Too Large”) should be used when a request is refused because its payload is too large</strong></p>
<p>The 413 error response indicates that the request is larger than the server is willing or able to process.</p></td>
<td style="text-align: left;"><p><a href="#POST">POST</a>, <a href="#PUT">PUT</a>, <a href="#PATCH">PATCH</a></p></td>
</tr>
<tr class="even">
<td style="text-align: left;"><p><span id="http-415"></span>415 Unsupported Media Type</p></td>
<td style="text-align: left;"><p><strong>415 (“Unsupported Media Type”) must be used when the media type of a request’s payload cannot be processed</strong></p>
<p>The 415 error response indicates that the API is not able to process the client’s supplied media type, as indicated by the <code>Content-Type</code> request header. For example, a client request including data formatted as <code>application/xml</code> will receive a 415 response if the API is only willing to process data formatted as application/json.</p></td>
<td style="text-align: left;"><p>All:
<a href="#GET">GET</a>, <a href="#HEAD">HEAD</a>, <a href="#POST">POST</a>, <a href="#PUT">PUT</a>, <a href="#PATCH">PATCH</a>, <a href="#DELETE">DELETE</a>, <a href="#OPTIONS">OPTIONS</a></p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><p><span id="http-429"></span>429 Too Many Requests</p></td>
<td style="text-align: left;"><p><strong>429 (“Too Many Requests”) should be used to indicate that the user has sent too many requests in a given amount of time.</strong></p>
<p>The response representations SHOULD include details explaining the condition, and MAY include a Retry-After header indicating how long to wait before making a new request. Note that this specification does not define how the origin server identifies the user, nor how it counts requests.</p>
<p>Responses with the 429 status code MUST NOT be stored by a cache.</p></td>
<td style="text-align: left;"><p>All:
<a href="#GET">GET</a>, <a href="#HEAD">HEAD</a>, <a href="#POST">POST</a>, <a href="#PUT">PUT</a>, <a href="#PATCH">PATCH</a>, <a href="#DELETE">DELETE</a>, <a href="#OPTIONS">OPTIONS</a></p></td>
</tr>
</tbody>
</table>

## 5xx Server Error

The server failed to fulfill an apparently valid request.

<table>
<colgroup>
<col style="width: 16%" />
<col style="width: 66%" />
<col style="width: 16%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align: left;">Code</th>
<th style="text-align: left;">Description</th>
<th style="text-align: left;">Methods</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;"><p><span id="http-500"></span>500 Internal Server Error</p></td>
<td style="text-align: left;"><p><strong>500 (“Internal Server Error”) should be used to indicate API malfunction</strong></p>
<p>500 is the generic REST API error response. Most web frameworks automatically respond with this response status code whenever they execute some request handler code that raises an exception.</p>
<p>A 500 error is never the client’s fault and therefore it is reasonable for the client to retry the exact same request that triggered this response, and hope to GET a different response.</p></td>
<td style="text-align: left;"><p>All:
<a href="#GET">GET</a>, <a href="#HEAD">HEAD</a>, <a href="#POST">POST</a>, <a href="#PUT">PUT</a>, <a href="#PATCH">PATCH</a>, <a href="#DELETE">DELETE</a>, <a href="#OPTIONS">OPTIONS</a></p></td>
</tr>
<tr class="even">
<td style="text-align: left;"><p><span id="http-502"></span>502 Bad Gateway</p></td>
<td style="text-align: left;"><p><strong>The 502 ("Bad Gateway") status code indicates that the server, while acting as a gateway or proxy, received an invalid response from an inbound server it accessed while attempting to fulfill the request.</strong></p></td>
<td style="text-align: left;"><p>All:
<a href="#GET">GET</a>, <a href="#HEAD">HEAD</a>, <a href="#POST">POST</a>, <a href="#PUT">PUT</a>, <a href="#PATCH">PATCH</a>, <a href="#DELETE">DELETE</a>, <a href="#OPTIONS">OPTIONS</a></p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><p><span id="http-503"></span>503 Service Unavailable</p></td>
<td style="text-align: left;"><p><strong>503 (“Service Unavailable”) indicates that the server is currently unable to handle the request due to a temporary overload or scheduled maintenance, which will likely be alleviated after some delay.</strong></p>
<p>The server MAY send a Retry-After header field to suggest an appropriate amount of time for the client to wait before retrying the request.</p></td>
<td style="text-align: left;"><p>All:
<a href="#GET">GET</a>, <a href="#HEAD">HEAD</a>, <a href="#POST">POST</a>, <a href="#PUT">PUT</a>, <a href="#PATCH">PATCH</a>, <a href="#DELETE">DELETE</a>, <a href="#OPTIONS">OPTIONS</a></p></td>
</tr>
</tbody>
</table>

## Status codes for each method

| Code                                    | GET | HEAD | PUT               | POST                | PATCH | DELETE | OPTIONS |
|-----------------------------------------|-----|------|-------------------|---------------------|-------|--------|---------|
| [200 OK](#http-200)                     | X   | X    | X                 | X (controller only) | X     | X      | X       |
| [201 Created](#http-201)                | \-  | \-   | X (creation only) | X                   | \-    | \-     | \-      |
| [202 Accepted](#http-202)               | \-  | \-   | \-                | X                   | \-    | \-     | X       |
| [204 No Content](#http-204)             | \-  | X    | X                 | X                   | X     | X      | \-      |
| [301 Moved Permanently](#http-301)      | X   | X    | X                 | X                   | X     | X      | X       |
| [303 See Other](#http-303)              | \-  | \-   | \-                | X                   | \-    | \-     | \-      |
| [304 Not Modified](#http-304)           | X   | X    | \-                | \-                  | \-    | \-     | \-      |
| [307 Temporary Redirect](#http-307)     | X   | X    | X                 | X                   | X     | X      | X       |
| [400 Bad Request](#http-400)            | X   | X    | X                 | X                   | X     | X      | X       |
| [401 Unauthorized](#http-401)           | X   | X    | X                 | X                   | X     | X      | X       |
| [403 Forbidden](#http-403)              | X   | X    | X                 | X                   | X     | X      | X       |
| [404 Not Found](#http-404)              | X   | X    | X                 | X                   | X     | X      | X       |
| [405 Method Not Allowed](#http-405)     | X   | X    | X                 | X                   | X     | X      | \-      |
| [406 Not Acceptable](#http-406)         | X   | X    | X                 | X                   | X     | X      | X       |
| [409 Conflict](#http-409)               | \-  | \-   | X                 | X                   | X     | X      | \-      |
| [412 Precondition Failed](#http-412)    | \-  | \-   | X                 | X                   | X     | X      | \-      |
| [413 Payload Too Large ](#http-413)     | \-  | \-   | X                 | X                   | X     | \-     | \-      |
| [415 Unsupported Media Type](#http-415) | X   | X    | X                 | X                   | X     | X      | X       |
| [429 Too Many Requests](#http-429)      | X   | X    | X                 | X                   | X     | X      | X       |
| [500 Internal Server Error](#http-500)  | X   | X    | X                 | X                   | X     | X      | X       |
| [502 Bad Gateway](#http-502)            | X   | X    | X                 | X                   | X     | X      | X       |
| [503 Service Unavailable](#http-503)    | X   | X    | X                 | X                   | X     | X      | X       |
