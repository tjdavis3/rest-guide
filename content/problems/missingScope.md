---
title: Missing Scope
weight: 5
description: The consumer access token doesn’t have the required scope to invoke the operation. The `requiredScopes` property lists the required scopes.
---

**Status code** 403 Forbidden


    GET /enterprises/202239951
    Authorization: Bearer ds4d2f13sdds2q13qxcgbdf245

    HTTP/1.1 403 Forbidden
    Content-Type: application/problem+json

    {
       "type": "urn:problem-type:belgif:missingScope",
       "href": "https://www.belgif.be/specification/rest/api-guide/problems/missingScope.html",
       "status": 403,
       "title": "Missing Scope",
       "detail": "Forbidden to consult the enterprise resource",
       "requiredScopes": ["enterprise-read"]
    }
