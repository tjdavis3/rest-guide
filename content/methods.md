---
title: HTTP Methods
weight: 50
---

## GET

**GET must be used to retrieve a representation of a resource.** It is a strict read-only method, which should never modify the state of the resource.

## HEAD

**HEAD should be used to only retrieve the HTTP response headers​.** HEAD returns the same response as GET, except that the API returns an empty body. It is strictly read-only.

## POST

**POST must be used to [create a new resource](#create-resource) in a collection or to execute a [controller](#Controller) resource.**

When using for resource creation, the POST request’s body contains the suggested state representation of the new resource to be added to the server-owned collection. The response should contain a Location HTTP header containing the URI of the newly created resource, while the body contains either its (partial or full) representation or is empty.

POST operations may have side effects (i.e. modify state), and are not required to be idempotent.

## PUT

**PUT must be used to update a stored resource under a consumer supplied URI.** It could be used to insert a new resource in case the client application decides on the resource identifier.

If the URI refers to an already existing resource, the enclosed entity SHOULD be considered as a new version to replace the one residing on the server. If the target resource is successfully modified in accordance with the state of the enclosed representation, then a 200 (OK)​ response SHOULD be sent to indicate successful completion of the request.

If the URI does not point to an existing resource, and that URI is capable of being defined as a new resource, the server can create the resource with that URI. The server MUST inform the client by sending a 201 (Created)​ response to indicate succesful creation.

PUT operations may have side effects (i.e. modify state), but MUST be idempotent.

## PATCH

**PATCH must be used to update partially a representation of a resource.**

The enclosed entity contains a set of instructions describing how a resource currently residing on the origin server should be modified to produce a new version.
The PATCH method affects the resource identified by the Request-URI, and it also MAY have side effects on other resources; i.e., new resources may be created, or existing ones modified, by the application of a PATCH.​
PATCH operations are not required to be idempotent, however they will often be in pratice.

See [???](#Partial update) on how to specify the set of instructions describing how a resource on the server should be modified.

**Compatibility**

The PATCH http method may not be supported in all components participating in the communication (e.g. HTTP client, intermediary proxy).
If these can’t be upgraded to add support, client and server may agree to work around this by implementing PATCH as POST operations with HTTP header 'X-HTTP-Method-Override: PATCH'.

## DELETE

**DELETE must be used to remove a resource from its parent.** Once a DELETE request has been processed for a given resource, the resource can no longer be found by clients. Therefore, any future attempt to retrieve the resource’s state representation, using either GET or HEAD, must result in a 404 (“Not Found”)​ status returned by the API.

## OPTIONS

OPTIONS should be used to retrieve metadata that describes a resource’s available interactions.

## How to use each method

| Method  | Collection | Document | Controller | Request body                           | Response body |
|---------|------------|----------|------------|----------------------------------------|---------------|
| GET     | Yes        | Yes      | Yes        | Empty                                  | Resource(s)   |
| HEAD    | Yes        | Yes      | Yes        | Empty                                  | Empty         |
| POST    | Yes        | No       | Yes        | Representation of the created resource 
                                                or controller info                      | Optional      |
| PUT     | No         | Yes      | No         | Representation of the updated resource | Optional      |
| PATCH   | No         | Yes      | No         | Fields of the resource to update       | Optional      |
| DELETE  | Yes        | Yes      | No         | Empty                                  | Optional      |
| OPTIONS | Yes        | Yes      | No         | Empty                                  | Optional      |
