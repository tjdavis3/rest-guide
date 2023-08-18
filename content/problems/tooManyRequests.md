---
title: Too Many Requests
weight: 9
description: The consumer quota was exceeded.
---

**Status code** 429 Too Many Requests

The property `limit` contains the number of requests allowed.
`retryAfter` or `retryAfterSec` indicate when the consumer may submit new requests again, respectively at a specific time or as a number of seconds after the reply.
The [Retry-After HTTP header](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Retry-After) conveys the same information.

**Retry after a specific time**

    HTTP/1.1 429 Too many requests
    Content-Type: application/problem+json
    Retry-After: Thu, 05 Aug 2021 10:30:00 GMT

    {
       "type": "urn:problem-type:belgif:tooManyRequests",
       "href": "https://www.belgif.be/specification/rest/api-guide/problems/tooManyRequests.html",
       "status": 429,
       "title": "Too Many Requests",
       "detail": "No more requests accepted before 2021-08-05T10:30:00Z",
       "limit": 200,
       "retryAfter": "2021-10-30T10:30:00Z",
       "retryAfterSec": 60
    }

**Retry after a number of seconds**

    HTTP/1.1 429 Too many requests
    Retry-After: 60
    Content-Type: application/problem+json
    {
      "type": "urn:problem-type:belgif:tooManyRequests",
       "href": "https://www.belgif.be/specification/rest/api-guide/problems/tooManyRequests.html",
       "status": 429,
       "title": "Too Many Requests",
       "detail": "No more requests accepted during next 60 seconds",
       "limit": 200,
       "retryAfterSec": 60
    }
