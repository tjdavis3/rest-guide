---
title: REST API
weight: 30
---

## Uniform interface

The REST uniform interface embraces all aspects of the HyperText Transfer Protocol, version 1.1 (HTTP/1.1) including its request methods, response codes, and message headers.​

The REST uniform interface is based on three fundamental elements:

1.  [???](#Resources) – How can we express where the data is being transferred to or from?

2.  [???](#HTTP Methods) – What are the protocol mechanisms used to transfer the data?

3.  [???](#Media Types) – What type of data is being transferred?

## API

An API bundles a set of resources which are *functionally related* and form an autonomous *unit of business logic*.

Compare an API to the concept of [*Services* in service-orientation](https://patterns.arcitura.com/soa-patterns/basics/serviceorientation/services) or the concept of [*Bounded Contexts* in Domain-Driven Development](https://martinfowler.com/bliki/BoundedContext.html).

**URI =** `https://`<span class="green">*host*</span>`/`<span class="green">*pathPrefix*</span>`/`<span class="green">*apiName*</span>`/v`<span class="green">*majorVersion*</span>`/`<span class="green">*resources*</span>

<span class="gray">*example:* https://services.socialsecurity.be/REST/employerProfile/v1/profiles</span>

`https://`  
Services are at least secured on transport level using a one-way TLS connection. The implicit port is 443.

host  
Hostname is determined by the environment where the service is deployed

pathPrefix  
Optional path prefix to discriminate between REST APIs and other resources on the same host. <span class="gray">(example: /REST)</span>

apiName  
Name of the API that groups a functional consistent set of resources. The API name consists of one or multiple *path segments* written in lowerCamelCase <span class="gray">(example: /referenceData/geography)</span>.

majorVersion  
Major version numbers are integers and start at 1. See [???](#API versioning).

resources  
All path segments identifying the actual resources.

## Richardson Maturity Model

The Richardson Maturity Model (developed by Leonard Richardson) breaks down the principal elements of a RESTful interface into three steps.
In order to be compliant to the *uniform interface* as described by Roy Fielding, all three levels must be fulfilled.

1.  **[???](#Resources)** — Level 1 tackles the question of handling complexity by using divide and conquer, breaking a large service endpoint down into multiple resources, each represented by a unique URI.

2.  **[???](#HTTP Methods)** — Level 2 introduces a standard set of verbs so that we handle similar situations in the same way, removing unnecessary variation.

3.  **[???](#Hypermedia controls)** — Level 3 introduces discoverability, providing a way of making a protocol more self-documenting.

All REST services **MUST at least respect level 2** and desirably achieve level 3.

- ['Architectural Styles and the Design of Network-based Software Architectures'](http://www.ics.uci.edu/~fielding/pubs/dissertation/top.htm) by Roy Fielding. This dissertation defined the REST architectural principles.

- ['Richardson Maturity Model'](http://martinfowler.com/articles/richardsonMaturityModel.html) by Martin Fowler

- ['The Maturity Heuristic'](http://www.crummy.com/writing/speaking/2008-QCon/act3.html) by Leonard Richardson
