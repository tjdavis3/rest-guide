---
title: Service Unavailable
weight: 13
description: The service is unavailable, because of a planned or unplanned downtime.
---

**Status code** 503 Service Unavailable

If present, `retryAfter` or `retryAfterSec` indicate when to retry, respectively at a specific time or as a number of seconds after the reply.
The [Retry-After HTTP header](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Retry-After) conveys the same information.

**Retry after a specific time**

    HTTP/1.1 503 Service Unavailable
    Retry-After: Thu, 05 Aug 2021 10:30:00 GMT
    Content-Type: application/problem+json
    {
      "type": "urn:problem-type:belgif:serviceUnavailable",
      "href": "https://www.belgif.be/specification/rest/api-guide/problems/serviceUnavailable.html",
      "instance": "d9e35127-e9b1-4201-a211-2b52e52508df",
      "status": 503,
      "title": "Service is unavailable",
      "detail": "The service is unavailable due to a scheduled maintenance, and is expected to be available again at 10h30 on Aug 5th, 2021",
      "retryAfter": "2021-08-05T10:30:00Z"
    }

**Retry after a number of seconds**

    HTTP/1.1 503 Service Unavailable
    Retry-After: 120
    Content-Type: application/problem+json
    {
      "type": "urn:problem-type:belgif:serviceUnavailable",
      "href": "https://www.belgif.be/specification/rest/api-guide/problems/serviceUnavailable.html",
      "instance": "d9e35127-e9b1-4201-a211-2b52e52508df",
      "status": 503,
      "title": "Service is unavailable",
      "detail": "The service experiences an unplanned downtime. Please try again after 120 seconds.",
      "retryAfterSec": 120
    }

**Without indication when to retry**

    HTTP/1.1 503 Service Unavailable
    Content-Type: application/problem+json
    {
      "type": "urn:problem-type:belgif:serviceUnavailable",
      "href": "https://www.belgif.be/specification/rest/api-guide/problems/serviceUnavailable.html",
      "instance": "d9e35127-e9b1-4201-a211-2b52e52508df",
      "status": 503,
      "title": "Service is unavailable",
      "detail": "The service experiences an unplanned downtime."
    }
