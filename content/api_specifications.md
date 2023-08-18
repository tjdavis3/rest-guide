---
title: API specifications
weight: 100
---

The contract-first principle SHOULD be followed when developing an API.
In this approach, the specifications of the REST API are created first and not generated from the code.

A code-first approach may sometimes be necessary however, as current state of technology does not always fully support contract-first development.
In this case, special attention should be given that the API specifications remain stable and loosely coupled to the API implementation technology.

## OpenAPI (Swagger)

OpenAPI is the dominating standard for API documentation, having gained wide industry support.
It is based on [Swagger](http://swagger.io/), which has been standardized as [OpenAPI 3.0](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.md).

Specifications of the API SHOULD be provided using  [**OpenAPI 3.0**](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.3.md).
OpenAPI uses the [OpenAPI Schema Object](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.3.md#schemaObject) to describe the JSON representation of resources, which is a variant of [**JSON Schema**](https://json-schema.org/specification-links.html#draft-5), with some significant incompatibilities.

{{% alert title="Notice" color="info" %}}
[OpenAPI 3.1](https://spec.openapis.org/oas/v3.1.0.html) improves upon OpenAPI 3.0, but to avoid interoperability problems it SHOULD NOT be used yet because it is not yet widely supported by most tooling.
{{% /alert %}}

The OpenAPI standard also includes a list of supported primitive [data types](https://github.com/OAI/OpenAPI-Specification/blob/main/versions/3.0.3.md#data-types).

You can visualize OpenAPI files using some of the tools listed in [Tools](#openapi-tools).

Any additional documentation SHOULD be linked from the API’s OpenAPI definition using the `externalDocs` property.

OpenAPI files SHOULD be made available in YAML format, and OPTIONALLY in JSON format as well.

YAML is a superset of JSON which allows a simpler notation, and also allows comments.
According to usage, a conversion step to JSON might be necessary considering limitations of tools.

When an API has many operations, use [tags](https://github.com/OAI/OpenAPI-Specification/blob/main/versions/3.0.3.md#tagObject) to group them together.
This will make the visual representation (SwaggerUI) more readable.

HTTP header parameters that may be present on all or most operations of an API SHOULD NOT be documented explicitly in the OpenAPI specification, as this would clutter the spec and make it difficult to keep up to date. Rather, refer API users to general documentation on these headers.

Operation-specific HTTP header parameters SHOULD be documented.

Following are examples of HTTP headers that shouldn’t be documented explicitly for each operation:

- `Accept-Language`

- `Authorization`

Examples of headers that should be specified on operations that support them:

- `ETag`

- `If-Modified-Since`

The OpenAPI specification file and other API documentation SHOULD be placed under a special `doc` resource under the API root location.
Access to these documentation resources SHOULD be granted to any user or potential user of the API.

The swagger specification file is, [by convention](https://github.com/OAI/OpenAPI-Specification/blob/main/versions/3.0.3.md#documentStructure), named `openapi.json` or `openapi.yaml`, as specified in the [OpenAPI 3.0 specification](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.3.md#document-structure).

Resources representing reference data (code lists) specific to an API SHOULD be placed under a `refData` resource.
As reference data is typically static, consider supporting [???](#Caching) headers for these resources.

Note that these are exceptions to the rule that API resource URLs shouldn’t have a file extension.

     /doc
         /openapi.json
         /openapi.yaml
         /<optional other documentation>
     /refData
         /<list1OfCodes>
            /<code1>
            /<code2>
            /...
         /<list2OfCodes>
            /...
     /<resource1>
         /...
     /<resource2>
         /...
     ...

Absent optional properties in a request are set by the API provider to their `default` value if one is specified in the OpenAPI specification.

Add example response values to the OpenAPI specification under the `examples` property.


OpenAPI 3.0

``` YAML
  /enterprises/{enterpriseNumber}:
    get:
      operationId: getEnterprise
      parameters:
      - in: path
        name: enterpriseNumber
        required: true
        schema:
          type: string
      responses:
        "200":
          description: successful operation
          content:
            application/json:
              schema:
                $ref: '#/definitions/Enterprise'
              examples:
                success:
                  {
                    "name": "Belgacom",
                    "enterpriseNumber": "0202239951"
                  }
```

<div class="warning">
{{% alert title="Warning" color="warning" %}}

Any additional examples should be put in external documentation or specified using a `x-examples` custom extension following the OpenAPI 3.0 format.

{{% /alert %}}
</div>

Instead of specifying everything directly in the `openapi.yaml`  file of an API, OpenAPI allows to reference data types and other definitions from other reusable files.
These files SHOULD follow the OpenAPI file format as well and may include data type definitions, but also parameter, path items and response objects.

To work around limitations of certain tools, a conversion step to inline the definitions into the `openapi.yaml` file may be necessary.

Duplication of types in multiple APIs SHOULD be avoided. Rather, put the type in a reusable OpenAPI file.
Files reusable from multiple APIs SHOULD be organized in this structure:

    <domain>/<version>/<domain-version>.yaml
    <domain>/<subdomain>/<version>/<domain-subdomain-version>.yaml

Definitions SHOULD be grouped per (sub)domain in a file.
Each file has its own lifecycle, with a major version number in its directory and file name, that is increased when backwards compatibility is broken.
This version, with optionally a minor and patch version added to it, MUST be specified in the `info` section in the swagger file as well.

While it is not strictly necessary for external definitions to be put in a valid OpenAPI file, doing so makes it possible to use standard OpenAPI tooling on them.

<div class="formalpara-title">

**/person/identifier/v1/person-identifier-v1.yaml**

</div>

``` YAML
openapi: "3.0.3"
info:
  title: person-identifier
  description: data types for person identifiers
  version: "1.1.2"
paths: {} # empty paths property required to be a valid OpenAPI file
components:
  schemas:
    Ssn:
      description: "Social Security Number issued by the Social Security Administration"
      type: string
      pattern: \d{3}-\d{2}-\d{4}
```

A type can be referenced from another OpenAPI file:

``` YAML
"$ref": "./person/identifier/v1/person-identifier-v1.yaml#/definitions/SSN"
```

Common definitions for use  are available in the [openapi-\* GitHub repositories](https://github.com/tjdavis3?q=openapi&type=&language=), organized per domain.
Types in these schemas SHOULD be used instead of defining your own variants.

The technical types referenced in this style guide are available in the [openapi-common](https://github.com/tjdavis3/openapi-common) and [openapi-problem](https://github.com/tjdavis3/problem) repositories.

In addition, they will also be made available on https URLs both in YAML and JSON format through content negotiation (see [???](#Media Types)), with YAML being the default format.

## JSON data types

Data type names SHOULD be defined in American English and use *UpperCamelCase* notation.
For abbreviations as well, all letters except the first one should be lowercased.

Do not use underscores (\_), hyphens (-) or dots (.) in a data type name, nor use a digit as first letter.

Overly generic terms like `info(rmation)` and `data` SHOULD NOT be used as data type name or part of it.

A data type name SHOULD refer to the business meaning rather than how it is defined.

| KO                  | OK       |
|---------------------|----------|
| SSN                | SSN     |
| CustomerInformation | Customer |
| LanguageEnumeration | Language |

The `description` property MAY provide a textual description of a JSON data type.
The `title` property MUST NOT be used because it hides the actual data type name in visualization tools like Swagger UI.

<table>
<colgroup>
<col style="width: 50%" />
<col style="width: 50%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align: left;">KO</th>
<th style="text-align: left;">OK</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;"><div class="sourceCode" id="cb1"><pre class="sourceCode YAML"><code class="sourceCode yaml"><span id="cb1-1"><a href="#cb1-1" aria-hidden="true" tabindex="-1"></a><span class="fu">Pet</span><span class="kw">:</span></span>
<span id="cb1-2"><a href="#cb1-2" aria-hidden="true" tabindex="-1"></a><span class="at">  </span><span class="fu">title</span><span class="kw">:</span><span class="at"> a pet in the pet store</span></span>
<span id="cb1-3"><a href="#cb1-3" aria-hidden="true" tabindex="-1"></a><span class="at">  </span><span class="fu">type</span><span class="kw">:</span><span class="at"> object</span></span></code></pre></div></td>
<td style="text-align: left;"><div class="sourceCode" id="cb2"><pre class="sourceCode YAML"><code class="sourceCode yaml"><span id="cb2-1"><a href="#cb2-1" aria-hidden="true" tabindex="-1"></a><span class="fu">Pet</span><span class="kw">:</span></span>
<span id="cb2-2"><a href="#cb2-2" aria-hidden="true" tabindex="-1"></a><span class="at">  </span><span class="fu">description</span><span class="kw">:</span><span class="at"> a pet in the pet store</span></span>
<span id="cb2-3"><a href="#cb2-3" aria-hidden="true" tabindex="-1"></a><span class="at">  </span><span class="fu">type</span><span class="kw">:</span><span class="at"> object</span></span></code></pre></div></td>
</tr>
</tbody>
</table>

`additionalProperties` can be used to put restrictions on other properties of a JSON object than those specified in the schema.

`additionalProperties` SHOULD be used exclusively to describe an object representing a map of key-value pairs.
The keys of such maps don’t need to respect the naming rules for JSON properties (lowerCamelCase and English).

An example is the description a map of `embedded` resources, as described in [???](#embedding).
Other uses of `additionalProperties` than for maps are to be avoided, in order to support schema evolution.

An API SHOULD refuse requests containing unknown body (JSON), path or query request parameters. A [Bad Request](#Bad Request) problem response should be returned with an issue of type `urn:problem-type:input-validation:unknownParameter`.

If an operation does allow and process request parameters that are not defined in OpenAPI, its description should explicitly indicate this.

In specific situations, where a (known) input parameter is not needed anymore and can be safely ignored:

- either it can stay in the API definition with a deprecation flag and a "not used anymore" description

- or it can be removed from the API definition as long as the server ignores this specific parameter.

Unknown HTTP header parameters MUST be accepted.

When accepting unknown parameters, certain client errors cannot be recognized by servers, e.g. parameter name typing errors will be ignored and the client’s actual intent will not be met.

Unknown HTTP headers are usually metadata added automatically by technical components that do not change the API’s expected behavior and thereby can be ignored.

Properties SHOULD be declared readOnly when appropriate.

Properties can be declared `readOnly: true`.
This means that it MAY be sent as part of a response but MUST NOT be sent as part of the request.
Properties marked as readOnly being true SHOULD NOT be in the required list of the defined schema.

Examples are properties that are computed from other properties, or that represent a volatile state of a resource.

A fixed list of possible values of a property can be specified using `enum`.
However, this may make it harder to change the list of possible values, as client applications will often depend on the specified list e.g. by using code generation.

`enum` SHOULD only be used when the list of values is unlikely to change or when changing it has a big impact on clients of the API.

``` YAML
State:
  type: string
  enum:
  - proceSSNg
  - failed
  - done
```

When defining a type for an identifier or code, like the above example, the guidelines under [???](#Identifier) apply, even when not used as a URL path parameter of a document resource.

Decimal numbers for which the fractional part’s precision is important, like monetary amounts, SHOULD be represented by a `string`-based type, with `number` as format. Depending on the context, a regular expression can enforce further restrictions like the number of digits allowed before/after comma or on the presence of a `+`/`-` sign.

When `number` would be used as type instead of `string`, some technologies will convert the values to floating point numbers, leading to a loss of precision and unintended calculation errors.

This problem may also be avoided by using an equivalent integer representation, for example by expreSSNg a monetary amount in Euro cent rather than Euro.

Some more background on why floating point numbers can lead to loss of precision, can be found in [this blog post](https://husobee.github.io/money/float/2016/09/23/never-use-floats-for-currency.html).

[belgif openapi-money](https://github.com/belgif/openapi-money/blob/master/src/main/openapi/money/v1/money-v1.yaml) defines a string-based type for monetary values:

``` YAML
MonetaryValue:
  type: string
  format: number # number is a custom string format that is supported by some, but not all tooling
  pattern: '^(\-|\+)?((\d+(\.\d*)?)|(\.\d+))$'  # Variable number of digits, with at least one digit required, before or after the decimal point. Allows both positive and negative values.
  x-examples:
  - "100.234567"
  - "010"
  - "-.05"
  - "+1"
  - "10"
  - "100."
MonetaryAmount:
  description: A monetary amount
  type: object
  properties:
    value:
      "$ref": "#/components/schemas/MonetaryValue"
    currency:
      "$ref": "#/components/schemas/Currency"
  required: [value, currency]
  example:
    value: "0.01"
    currency: "USD"
```

It also defines integer-based types specific for monetary amounts expressed in Euro cent:

``` YAML
EuroCentPositiveAmount:
  description: Money amount in Euro cents >= 0
  type: integer # representation as Euro cent instead of Euro to avoid floating point rounding problems and need for custom 'number' format
  minimum: 0

EuroCentAmount:
  description: 'Money amount in Euro cents, also allows negative amounts.'
  type: integer # representation as Euro cent instead of Euro to avoid floating point rounding problems and need for custom 'number' format
```

## Tools

Following tools can be used to edit OpenAPI files

| Name                                           | Link                                                                          | Description                                                                                                                                                                                                |
|------------------------------------------------|-------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Swagger UI                                     | <https://swagger.io/swagger-ui/>                                              | Browser application. Graphical and text view of Swagger files. Does not support references to external files.                                                                                              |
| Zalando’s Swagger plugin                       | <https://github.com/zalando/intellij-swagger>                                 | Open Source plugin for IntelliJ. Text-only editor.                                                                                                                                                         |
| Stoplight Studio                               | <https://stoplight.io/studio/>                                                | Commercial editor with a free version. Graphical and text view, both web based or as desktop application. Supports validation of API style guides ([Spectral](https://stoplight.io/open-source/spectral)). |
| 42Crunch OpenAPI (Swagger) Editor for VS Code  | <https://marketplace.visualstudio.com/items?itemName=42Crunch.vscode-openapi> | Open Source plugin for Visual Studio Code. Text editor with SwaggerUI preview and multi-file support.                                                                                                      |
| 42Crunch OpenAPI (Swagger) Editor for IntelliJ | <https://plugins.jetbrains.com/plugin/14837-openapi-swagger-editor>           | Plugin for IntelliJ. Text editor with multi-file support.                                                                                                                                                  |
| IntelliJ OpenAPI Specifications                | <https://www.jetbrains.com/help/idea/openapi.html>                            | Plugin bundled with IntelliJ Ultimate (commercial). Text editor with SwaggerUI preview and multi-file support.                                                                                             |

Following tools can be used to generate server stubs and API client libraries from OpenAPI specification files.

| Name              | Link                                             | Comments                            |
|-------------------|--------------------------------------------------|-------------------------------------|
| openapi-generator | <https://openapi-generator.tech/>                | Started as fork of swagger-codegen. |
| swagger-codegen   | <https://github.com/swagger-api/swagger-codegen> |                                     |

## References

| Name                      | Link                                                         |
|---------------------------|--------------------------------------------------------------|
| OpenAPI 3.0 specification | <http://spec.openapis.org/oas/v3.0.3.html>                   |
| Swagger                   | <https://swagger.io/docs/specification/2-0/basic-structure/> |
