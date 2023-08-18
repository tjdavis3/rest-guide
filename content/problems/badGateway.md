---
title: Bad Gateway
description: The API, acting as a gateway or proxy to an API provided by a third party, received an invalid response from the upstream server.
weight: 12
---

**Status code** 502 Bad Gateway


    HTTP/1.1 502 Bad Gateway
    Content-Type: application/problem+json

    {
      "type": "urn:problem-type:belgif:badGateway",
      "href": "https://www.belgif.be/specification/rest/api-guide/problems/badGateway.html",
      "status": 502,
      "title": "Bad Gateway",
      "detail": "Error in communication with upstream service"
    }
