---
title: Payload Too Large
weight: 8
description: The consumer request was refused because its payload is too large.
---

> The property `limit` contains the maximum payload size expressed in bytes.

**Status code** 413 Payload Too Large


    POST /attachments

    <very large binary attachment>

returns

    HTTP/1.1 413 Payload Too Large
    Content-Type: application/problem+json

    {
       "type": "urn:problem-type:belgif:payloadTooLarge",
       "href": "https://www.belgif.be/specification/rest/api-guide/problems/payloadTooLarge.html",
       "status": 413,
       "title": "Payload Too Large",
       "detail": "Request message must not be larger than 10 MB",
       "limit": 10485760
    }
