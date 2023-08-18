---
title: No Access Token
weight: 2
description: The consumer must pass a valid access token in the `Authorization` HTTP header for each request to a secure resource.
---

**Status code** 401 Unauthorized


    POST /enterprises
    Authorization: Bearer ds4d2f13sdds2q13qxcgbdf245

If no access token was found, the service returns:

    HTTP/1.1 401 Unauthorized
    Content-Type: application/problem+json

    {
       "type": "urn:problem-type:belgif:noAccessToken",
       "href": "https://www.belgif.be/specification/rest/api-guide/problems/noAccessToken.html",
       "status": 401,
       "title": "No Access Token",
       "detail": "No Bearer access token found in Authorization HTTP header"
    }
