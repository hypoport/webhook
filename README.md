# hypoport/webhook

Listens for Webhook requests and triggers TeamCity builds.

# todo

- [ ] Continuous Deployment des Webhooks einrichten (natürlich, indem er das für sich selbst triggert...)

## Usage

- Run the hypoport/webhook container as a service

```bash
    docker service create \
      --name webhook \
      -p 9000:9000 \
      -e WEBHOOK_AUTH=changeit \
      -e WEBHOOK_SLACK_TOKEN=<token> \
      --update-order start-first \
      hypoport/webhook:latest
```

- Follow the webhook logs

```bash
    docker service logs -f webhook 
```

- Manually test the webhook (simulates a Docker Hub Webhook)

```bash
    curl -X POST 'http://localhost:9000/hooks/docker-hub?tcBuildTypeId=pku_ExplorationDay_WebhookTest&auth=<token>' \
         -H 'Content-Type: application/json' \
         -d '{"push_data": {"tag": "new-tag"}, "repository": {"repo_name": "repo/name"}}'
```

## Supported Triggers

See `hooks.json` for the actual config.

- From Slack: `/webhook [repo] [tag] [buildTypeId]`
- [From Docker Hub](https://docs.docker.com/docker-hub/webhooks/)

## Supported Actions

- [Trigger a build on TeamCity via api](trigger-teamcity-build.md)
