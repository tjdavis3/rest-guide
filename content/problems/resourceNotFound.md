---
title: Resource Not Found
weight: 7
description: The requested resource cannot be found. The `detail` property reveals additional information about why the resource was not found.
---

**Status code** 404 Not Found


Either the resource path isn’t specified in the API’s OpenAPI specification.

    GET /enterprises

    HTTP/1.1 404 Not Found
    Content-Type: application/problem+json

    {
      "type": "urn:problem-type:belgif:resourceNotFound",
      "href": "https://www.belgif.be/specification/rest/api-guide/problems/resourceNotFound.html",
      "status": 404,
      "title": "Resource Not Found",
      "detail": "No resource /enterprises found"
    }

Either the path parameters don’t resolve to an existing resource. Look for the more details in the `issues` property.

    GET /enterprises/0206731645

    HTTP/1.1 404 Not Found
    Content-Type: application/problem+json

    {
      "type": "urn:problem-type:belgif:resourceNotFound",
      "href": "https://www.belgif.be/specification/rest/api-guide/problems/resourceNotFound.html",
      "status": 404,
      "title": "Resource not found",
      "detail": "No resource /enterprises/0206731645 found",
      "issues": [
          {
            "in": "path",
            "name": "enterpriseNumber",
            "detail": "the enterprise number 0206731645 is not assigned",
            "value": "0206731645"
          }
      ]
    }
