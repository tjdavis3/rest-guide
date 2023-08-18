---
title: Media Types
weight: 70
---

The HTTP protocol supports content negotiation for media types of the response.

REST clients SHOULD specify the media type(s) that is(/are) acceptable for the response in the `Accept` HTTP header.

A REST response or request with payload MUST include the `Content-Type` HTTP header to indicate the media type of the HTTP payload.

Status code [406](#http-406) MUST be used to indicate that the requested media type could not be provided.

Status code [415](#http-415) MUST be used to indicate an unsupported media type in the request payload.

If a resource supports multiple content types through negotation, the response header `Vary: Accept` MUST be added to avoid undesired cache hits (also see [???](#Caching)).

Request HTTP headers:

    Accept: image/jpeg, image/png

Response HTTP headers:

    Content-Type: image/png
    Vary: Accept

**JSON**

The primary media type to support is **JSON** (Javascript Object Notation).
The choice for JSON is particularly made for supporting JavaScript clients.

Structured data MUST be made available in JSON format ([RFC 8259](https://tools.ietf.org/html/rfc8259)) with media type `application/json`.
JSON text MUST be encoded using **UTF-8**.

Some legacy clients erroneously decode JSON payloads using a non-UTF-8 encoding by default.
To work around this, a charset parameter may be added to the `Content-Type` HTTP header, even though it has no meaning according to the JSON RFC.

    Content-Type: application/json;charset=UTF-8

Media types of format `application/<subtype>+json` may be used for standardized JSON formats, though REST APIs should also accept requests using the generic `application/json` media type:

- `application/merge-patch+json` for JSON Merge Patch payloads (see [???](#Partial update))

- `application/problem+json` for Problem Detail for HTTP APIs (RFC 7807) payloads (see [???](#Error handling))

**XML**

On specific client request, a REST service can expose XML messages defined by **XML Schema**.

    Content-Type: application/xml;charset=UTF-8

Always stick to **UTF-8** encoding and specify the charset in the `Content-Type` HTTP header.

<div class="caution">

It is not recommended to implement both JSON / XML in each REST service.
It would require to define and implement two representations of the same data.
Automatic conversion between the two standards will almost never give a satisfying result.

</div>

**Media types in OpenAPI**

Payload media types can be specified in an OpenAPI specification.

For JSON, the media type specified in OpenAPI should not contain a `charset` parameter, because this is known to lead to problems in some server software when treating requests without the parameter in the `Accept` header.

**OpenAPI 3.0**

OpenAPI 3.0 allows to specify a different media type for each request or response format.
Default media types cannot be specified.

``` YAML
  /persons/{ssin}/photo:
    get:
      summary: Get the photo of the person
      operationId: getPhoto
      parameters:
      - $ref: "person/identifier/v1/person-identifier-v1.yaml#/components/parameters/SsinQueryParameter"
      responses:
        "200":
          description: successful operation
          content:
            image/jpeg:
              schema:
                type: string
                format: binary
        "400":
          description: SSIN has invalid structure
          content:
            application/problem+json:
              schema:
                $ref: "#/components/schemas/InvalidSsinProblem"
        "404":
          description: SSIN was not found
          content:
            application/problem+json:
              schema:
                $ref: "#/components/schemas/UnknownSsinProblem"
        default:
          "$ref": "./problem/v1/problem-v1.yaml#/components/responses/ProblemResponse"
```
