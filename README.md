# hypoport/webhook

Listens for Webhook requests and triggers TeamCity builds.

# todo

- [x] Lauschen auf Webhooks, speziell welche vom Docker Hub, wie unter [docs.docker.com](https://docs.docker.com/docker-hub/webhooks/) beschrieben
- [x] Triggern eines Builds oder Deployments in TeamCity
- [x] Absichern des Webhooks per "API-Key". Siehe dazu die Doku unter [adnanh/webhook/.../Hook-Rules.md](https://github.com/adnanh/webhook/blob/master/docs/Hook-Rules.md)
- [x] Alles in einem Docker-Image kapseln (wie wollen wir mit Updates/temporären Downtimes des Webhooks umgehen?)
- [x] als non-privileged User laufen lassen
- [ ] HTTPS aktivieren
- [ ] Webhook als Service einrichten - ggf. als Docker Service (Swarm), damit rolling updates unterbrechungsfrei ermöglicht werden

## Usage

- Prepare a Docker Volume
 
Necessary only once or when changes are made on the hooks config.
This can be skipped, but then the run command below needs to be modified accordingly. 

```bash
    docker volume create --name hooks
    docker run --rm -v hooks:/target -v $(PWD):/source alpine:edge sh -c 'cp -a /source/* /target/'
```

- Run the hypoport/webhook container

```bash
    docker run --rm -it \
        --name webhook \
        -p 9000:9000 \
        -e WEBHOOK_AUTH=changeit \
        -e WEBHOOK_SLACK_TOKEN=token \
        -v hooks:/etc/hooks hypoport/webhook:latest
```

- Manually test the webhook (simulates a Docker Hub Webhook)

```bash
    curl -X POST "http://localhost:9000/hooks/docker-hub?tcBuildTypeId=pku_ExplorationDay_WebhookTest&auth=changeit" \
         -H "Content-Type: application/json" \
         -d@docker-hub/example-payload.json
```

## Supported Triggers

See `hooks.json` for the actual config.

- From Slack: `/webhook [repo] [tag] [buildTypeId]`
- [From Docker Hub](https://docs.docker.com/docker-hub/webhooks/)

## Supported Actions

- [Trigger a build on TeamCity via api](trigger-teamcity-build.md)
