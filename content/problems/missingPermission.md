---
title: Missing Permission
weight: 6
description: The consumer doesn’t have the right to invoke an operation on the given resource.
---

> The refusal is not related to the consumer scope but to access to the specific resource itself (data access).

**Status code** 403 Forbidden


    PUT /enterprises/202239951
    Authorization: Bearer ds4d2f13sdds2q13qxcgbdf245

    HTTP/1.1 403 Forbidden
    Content-Type: application/problem+json

    {
       "type": "urn:problem-type:belgif:missingPermission",
       "href": "https://www.belgif.be/specification/rest/api-guide/problems/missingPermission.html",
       "status": 403,
       "title": "Missing Permission",
       "detail": "Not permitted to update the details of this enterprise"
    }
