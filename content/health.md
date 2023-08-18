---
title: Health
weight: 180
---

Each REST API SHOULD expose a health resource which returns the current availability status of the service.

When invoked without any access token, the resource simply returns its status.
The status code is either `200 OK` when the service is up or partially available, or `503 Service Unavailable` when the service is down or out of service.

<div class="formalpara-title">

**Service is up**

</div>

``` json
{
  "status": "UP"
}
```

When invoked by a client with additional health-check permissions, the resource MAY return additional details on the status of its subsystems or components.
This internal information should be hidden from external clients for security reasons.

<div class="formalpara-title">

**Service is down, with additional details**

</div>

``` json
{
  "status": "DOWN",
  "details": {
    "datastore": {
      "status": "DOWN",
      "errorMessage": "connection timeout"
    }
  }
}
```

The health resource is specified in [common-v1.yaml](https://github.com/belgif/openapi-common/blob/master/src/main/swagger/common/v1/common-v1.yaml).
Note that uppercase is used for the status values, which differs from the [???](#enum-rule), in order to align with existing health checks provided by frameworks like [Spring Boot](https://docs.spring.io/spring-boot/docs/2.3.1.RELEASE/reference/htmlsingle/#production-ready-health) and [MicroProfile Health](https://download.eclipse.org/microprofile/microprofile-health-2.2/microprofile-health-spec.html).
The format of additional component-level details is not specified.

<table>
<colgroup>
<col style="width: 16%" />
<col style="width: 33%" />
<col style="width: 50%" />
</colgroup>
<tbody>
<tr class="odd">
<td style="text-align: left;"><p><a href="#get">???</a></p></td>
<td style="text-align: left;"><p>/health</p></td>
<td style="text-align: left;"><p>Check the health status of the API.</p></td>
</tr>
<tr class="even">
<td colspan="3" style="text-align: left;"><p>Response</p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><p>body</p></td>
<td style="text-align: left;"><p>The status of the service. Component-level details may be shown when the client has additional permissions.</p></td>
<td style="text-align: left;"><div class="sourceCode" id="cb1"><pre class="sourceCode json"><code class="sourceCode json"><span id="cb1-1"><a href="#cb1-1" aria-hidden="true" tabindex="-1"></a><span class="fu">{</span></span>
<span id="cb1-2"><a href="#cb1-2" aria-hidden="true" tabindex="-1"></a>   <span class="dt">&quot;status&quot;</span><span class="fu">:</span> <span class="st">&quot;UP&quot;</span></span>
<span id="cb1-3"><a href="#cb1-3" aria-hidden="true" tabindex="-1"></a><span class="fu">}</span></span></code></pre></div>
<div class="sourceCode" id="cb2"><pre class="sourceCode json"><code class="sourceCode json"><span id="cb2-1"><a href="#cb2-1" aria-hidden="true" tabindex="-1"></a><span class="fu">{</span></span>
<span id="cb2-2"><a href="#cb2-2" aria-hidden="true" tabindex="-1"></a>   <span class="dt">&quot;status&quot;</span><span class="fu">:</span> <span class="st">&quot;DOWN&quot;</span></span>
<span id="cb2-3"><a href="#cb2-3" aria-hidden="true" tabindex="-1"></a><span class="fu">}</span></span></code></pre></div></td>
</tr>
<tr class="even">
<td colspan="3" style="text-align: left;"><p>Response codes</p></td>
</tr>
<tr class="odd">
<td style="text-align: left;"><p><a href="#http-200">200</a></p></td>
<td style="text-align: left;"><p>OK</p></td>
<td style="text-align: left;"><p>When service is <code>UP</code> or <code>DEGRADED</code></p></td>
</tr>
<tr class="even">
<td style="text-align: left;"><p><a href="#http-503">503</a></p></td>
<td style="text-align: left;"><p>Service Unavailable</p></td>
<td style="text-align: left;"><p>When service is <code>DOWN</code></p></td>
</tr>
</tbody>
</table>

## Status levels

The health resource returns one of the following status levels indicating the component or system:

| Status   | Status Code | Description                                                                    |
|----------|-------------|--------------------------------------------------------------------------------|
| UP       | 200         | is functioning as expected.                                                    |
| DEGRADED | 200         | is partly unavailable but service can be continued with reduced functionality. |
| DOWN     | 503         | is suffering unexpected failures                                               |

The status property also allows custom strings for other use cases.
