Docs:

- https://docs.pact.io/pact_broker/advanced_topics/api_docs/webhooks/
- https://docs.pact.io/pact_broker/webhooks/#example-cicd-and-webhook-configuration
- https://docs.pact.io/pact_broker/webhooks/template_library/

Example:

````json
{
  "tcBuildTypeId": "project_subproject_producer_pactVerify",
  "pactbroker": {
    "eventName": "${pactbroker.eventName}",
    "consumerName": "${pactbroker.consumerName}",
    "providerName": "${pactbroker.providerName}",
    "consumerVersionNumber": "${pactbroker.consumerVersionNumber}",
    "consumerVersionTags": "${pactbroker.consumerVersionTags}",
    "githubVerificationStatus": "${pactbroker.githubVerificationStatus}",
    "consumerLabels": "${pactbroker.consumerLabels}"
  }
}
````
