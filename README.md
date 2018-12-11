# webhook

Listens for Webhook requests

# todo

- [x] Lauschen auf Webhooks, speziell welche vom Docker Hub, wie unter [docs.docker.com](https://docs.docker.com/docker-hub/webhooks/) beschrieben
- [x] Triggern eines Builds oder Deployments in TeamCity
- [x] Absichern des Webhooks per "API-Key". Siehe dazu die Doku unter [adnanh/webhook/.../Hook-Rules.md](https://github.com/adnanh/webhook/blob/master/docs/Hook-Rules.md)
- [x] Alles in einem Docker-Image kapseln (wie wollen wir mit Updates/temporären Downtimes des Webhooks umgehen?)
- [x] als non-privileged User laufen lassen
- [ ] HTTPS aktivieren
- [ ] Webhook als Service einrichten

```
    docker run --rm -it --name webhook -p 9000:9000 --env WEBHOOK_AUTH=changeit --env WEBHOOK_SLACK_TOKEN=token -v hooks:/etc/hooks hypoport/webhook:latest
```

```
    curl -X POST "http://localhost:9000/hooks/docker-hub?auth=changeit" \
         -H "Content-Type: application/json" \
         -d@docker-hub/example-payload.json
```

- [Trigger build on teamcity via api](trigger-teamcity-build.md)
