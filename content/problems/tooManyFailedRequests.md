---
title: Too Many Failed Requests
weight: 10
description: No more new requests are accepted because the consumer quota for failed requests was exceeded.
---

**Status code** 429 Too Many Requests

The property `limit` contains the number of failed requests allowed.
`retryAfter` or `retryAfterSec` indicate when the consumer may submit new requests again, respectively at a specific time or as a number of seconds after the reply.
The [Retry-After HTTP header](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Retry-After) conveys the same information.

    GET /enterprises/123invalidEnterpriseId

**Retry after a specific time**

    HTTP/1.1 429 Too many requests
    Content-Type: application/problem+json
    Retry-After: Thu, 05 Aug 2021 10:30:00 GMT

    {
       "type": "urn:problem-type:belgif:tooManyFailedRequests",
       "href": "https://www.belgif.be/specification/rest/api-guide/problems/tooManyFailedRequests.html",
       "status": 429,
       "title": "Too Many Failed Requests",
       "detail": "No more requests are accepted because of previous failures until 2021-08-05T10:30:00Z",
       "limit": 50,
       "retryAfter": "2021-08-05T10:30:00Z"
    }

**Retry after a number of seconds**

    HTTP/1.1 429 Too many requests
    Retry-After: 300
    Content-Type: application/problem+json
    {
       "type": "urn:problem-type:belgif:tooManyFailedRequests",
       "href": "https://www.belgif.be/specification/rest/api-guide/problems/tooManyFailedRequests.html",
       "status": 429,
       "title": "Too Many Failed Requests",
       "detail": "No more requests are accepted because of previous failures during next 300 seconds",
       "limit": 50,
       "retryAfterSec": 300
    }
