---
title: Invalid Access Token
weight: 3
description: The consumer must pass a valid access token in the `Authorization` HTTP header for each request to a secure resource.
---

**Status code** 401 Unauthorized


    POST /enterprises
    Authorization: Bearer foo

    HTTP/1.1 401 Unauthorized
    Content-Type: application/problem+json

    {
       "type": "urn:problem-type:belgif:invalidAccessToken",
       "href": "https://www.belgif.be/specification/rest/api-guide/problems/invalidAccessToken.html",
       "status": 401,
       "title": "Invalid Access Token",
       "detail": "The Bearer access token found in the Authorization HTTP header is invalid"
    }
