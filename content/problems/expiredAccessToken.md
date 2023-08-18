---
title: Expired Access Token
weight: 4
description: The access token passed in the `Authorization` HTTP header has expired and cannot be used anymore. Renew the access token and resubmit the request.

---

**Status code** 401 Unauthorized


    POST /enterprises
    Authorization: Bearer ds4d2f13sdds2q13qxcgbdf245

    HTTP/1.1 401 Unauthorized
    Content-Type: application/problem+json

    {
       "type": "urn:problem-type:belgif:expiredAccessToken",
       "href": "https://www.belgif.be/specification/rest/api-guide/problems/expiredAccessToken.html",
       "status": 401,
       "title": "Expired Access Token",
       "detail": "The Bearer access token found in the Authorization HTTP header has expired"
    }
