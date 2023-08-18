---
title: Bad Request
description: The input message is incorrect. Look for more details in the `issues` property.
weight: 1
---

**Status code** 400 Bad Request


The following issue types may be returned by any API:

| Issue type                                                  | description                                                        |
|-------------------------------------------------------------|--------------------------------------------------------------------|
| `urn:problem-type:belgif:input-validation:schemaViolation`  | violation of the OpenAPI schema                                    |
| `urn:problem-type:belgif:input-validation:unknownParameter` | Request contains an unknown parameter (see [???](#rule-req-valid)) |

    POST /enterprises/abc

    {
      "mandator": {
        "enterpriseNumber": "123456"
      }
    }

**returns**

    HTTP/1.1 400 Bad Request
    Content-Type: application/problem+json

    {
      "type": "urn:problem-type:belgif:badRequest",
      "href": "https://www.belgif.be/specification/rest/api-guide/problems/badRequest.html",
      "status": 400,
      "title": "Bad Request",
      "detail": "The input message is incorrect",
      "issues": [
        {
          "type": "urn:problem-type:belgif:input-validation:schemaViolation",
          "in": "path",
          "name": "enterpriseNumber",
          "value": "abc",
          "detail": "value should be numeric"
        },
        {
          "type": "urn:problem-type:belgif:input-validation:schemaViolation",
          "in": "body",
          "name": "mandator.enterpriseNumber",
          "value": "123456",
          "detail": "An enterprise number should be 10 digits long"
        }
     ]
    }
