# webhook
Listens for Webhook requests

`./webhook -hooks hooks.json -port 9000 -verbose`

`curl -X POST "http://***REMOVED***:9000/hooks/test-hook" -H "application/json" -d@docker-hub/example-payload.json`

- [ ] Lauschen auf Webhooks, speziell welche vom Docker Hub, wie unter [docs.docker.com](https://docs.docker.com/docker-hub/webhooks/) beschrieben
- [ ] Triggern eines Builds oder Deployments in TeamCity
- [ ] Webhook als Service einrichten
- [ ] Absichern des Webhooks (HTTPS, "API-Key"). Siehe dazu die Doku unter 
