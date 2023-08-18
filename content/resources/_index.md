---
title: Resources
weight: 40
no_list: true
---

A REST APIs exposes a set of *resources*. Resources model the *data and functionality of a system*. A resource can be data, processing logic, files, or anything else that a service may have access to.

## Resource URI

Any resource is uniquely identified by a Uniform Resource Identifier or URI ([RFC 3986​](https://tools.ietf.org/html/rfc3986)).

<div class="note">

URI = scheme "://" authority "/" path \[ "?" query \] \[ "#" fragment \]​  
​example: https://example.com/employers/406798006​?lang=nl

</div>

URI must be intuitively structured.

The **URI notation MUST use *lowerCamelCase*** to enhance readability and to separate compound names.
As lowerCamelCase is used for JSON property names as well, the casing is consistent throughout the API.
Trailing slashes MUST NOT be used.

​<span class="green">GOOD: http://example.com/REST/demo/v1/socialSecretariats/331</span>  
<span class="red">BAD: http://example.com/REST/demo/v1/Social_Secretariats/331</span>  
​<span class="red">BAD: http://example.com/REST/demo/v1/social-secretariats/331</span>  
​<span class="red">BAD: http://example.com/REST/demo/v1/socialSecretariats/331/</span>

The URI **SHOULD NOT contain a file extension**.

A notable exception to this rule is the swagger/OpenAPI file (see [???](#doc-resource)).

Instead, look at how to express [???](#Media Types) using HTTP headers.

​<span class="green">GOOD: http://example.com/REST/demo/v1/socialSecretariats​/331</span>  
<span class="red">​BAD: http://example.com/REST/demo/v1/socialSecretariats​/331.json</span>

The query part of a URI may be used to filter the resource output.

The query component of a URI contains a set of parameters to be interpreted as a variation or derivative of the resource. The query component can provide clients with additional interaction capabilities such as ad hoc searching and filtering.

​<span class="green">http://example.com/REST/demo/v1/socialSecretariats​**?q=sdworx**</span>  
Filter the resource collection using a search string.

<span class="green">http://example.com/REST/demo/v1/socialSecretariats/331​**?select=(name,address)**</span>  
Filter the resource properties to the ones specified in the `select` query parameter.

<span class="green">http://example.com/REST/demo/v1/socialSecretariats/331​**?lang=nl**</span>  
Only return translatable properties in dutch.

When a single query parameter can have multiple values, the parameter SHOULD be repeated for each value.

<div class="formalpara-title">

**Request**

</div>

    GET {API}/employers/93017373?embed=employees&embed=mainAddress


<div class="formalpara-title">

**OpenAPI 3.0 definition**

</div>

``` YAML
parameters:
- name: embed
  in: query
  style: form
  explode: true
  schema:
    type: array
    items:
      type: string
      enum:
      - employees
      - mainAddress
```

## Resource Archetypes

There are three different resource archetypes:

- [Document](resources-document)

- [Collection](resources-collection)

- [Controller](resources-controller)

