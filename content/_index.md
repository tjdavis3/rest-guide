---
title: REST Guidelines
no_list: true
#menu:
#  main:
#    weight: 10
draft: false

cascade:
- type: "docs"
  _target:
    path: "/**"
---
# Introduction

This guide is a living document, updated when new interoperability issues arise or when REST-related standards evolve.

- REST is the defacto standard to communicate with web services from JavaScript and native mobile applications.

- REST has become the industry standard for developing APIs on the web ([Google](https://developers.google.com/apis-explorer), [Facebook](https://developers.facebook.com/docs/graph-api/reference), [Amazon](https://developer.amazon.com/public/apis), [Twitter](https://dev.twitter.com/rest/public), etc).

Topics not covered in this guide:

- Securing REST APIs. Guidelines are under development by the REST Security Working Group, based on the OpenID Connect and [OAuth 2.0](https://tools.ietf.org/html/rfc6749) standards.

- OpenAPI specifications for common data types can be found in the [openapi-\* GitHub repositories](https://github.com/belgif?q=openapi&type=&language=).

<!-- -->
{{% pageinfo color="primary" %}}
> This guide is based on the REST guild published by [the Belgian Interoperability Framework](https://www.belgif.be/).
>
> - Original Sources: <https://github.com/belgif/rest-guide>
{{% /pageinfo %}}
<div class="note">
{{% alert title="Note" color="primary" %}}
For brevity most URIs in examples are shortened, but in practice URIs should be in absolute notation.
{{% /alert %}}
</div>

**License**

    This work is licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

           http://www.apache.org/licenses/LICENSE-2.0

       Unless required by applicable law or agreed to in writing, software
       distributed under the License is distributed on an "AS IS" BASIS,
       WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
       See the License for the specific language governing permissions and
       limitations under the License.
