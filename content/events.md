---
title: Events
weight: 170
---

When systems are in need of subscribe-notify capabilities, they tend to define their own custom event format.

To improve interoperability, this styleguide promotes and adopts the CloudEvents specification prepared by the Cloud Native Computing Foundation (CNCF): <https://cloudevents.io/>.

On October 24, 2019 they released a v1.0 version of this specification which thoroughly separates the core conceptual event model from any format and protocol details.
Moreover, some SDKs are in development to support integration of CloudEvents in some popular programming languages.

| Description                                         | Link                                                                                            |
|-----------------------------------------------------|-------------------------------------------------------------------------------------------------|
| CloudEvents overview                                | <https://github.com/cloudevents/spec/blob/main/README.md>                                       |
| Conceptual model                                    | <https://github.com/cloudevents/spec/blob/v1.0.2/cloudevents/spec.md>                           |
| JSON Event Format                                   | <https://github.com/cloudevents/spec/blob/v1.0.2/cloudevents/formats/json-format.md>            |
| HTTP Protocol Binding                               | <https://github.com/cloudevents/spec/blob/v1.0.2/cloudevents/bindings/http-protocol-binding.md> |
| Web Hooks for Event Delivery                        | <https://github.com/cloudevents/spec/blob/v1.0.2/cloudevents/http-webhook.md>                   |
| Extensions (Sequence, Claim Check, Partitioning, …​) | <https://github.com/cloudevents/spec/blob/v1.0.2/cloudevents/documented-extensions.md>          |

CloudEvents documentation
