---
title: Controller
weigth: 45
---

A controller resource models a procedural concept. Controller resources are like executable functions, with parameters and return values; inputs and outputs.

A REST API can rely on controller resources to perform application-specific actions that cannot be logically mapped to one of the standard methods (standard CRUD-operations).

A controller resource name is a verb instead of a noun.

The HTTP method on a controller SHOULD be:

- POST for actions with side effects (state change) or actions without side effects but requiring a request body

- GET for idempotent actions without side effects

Withdrawal from an account:

`POST /accounts/123/withdraw`

Sending a notification to an employer:

`POST /employers/93017373/sendNotification`

Converting money from one currency to another (using GET because of no side effects):

`GET /convertMoney?from=EUR&amount=45&to=USD`

## Controller vs document

Before using a controller resource to represent an action, consider reifying the action as a collection or document resource (noun) describing the intent of the action.

[???](#long-running-tasks) are an example of actions modelled as a collection/document instead of a controller.

Withdrawal from an account as a controller resource:

`POST /account/123/withdraw`

or as a collection resource:

`POST /account/123/withdrawals`

Using a noun improves extensibility in this case.
For instance, a GET operation could be added to consult a history of all withdrawals executed on the account.
