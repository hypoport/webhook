# webhook
Listens for Webhook requests

```
    export WEBHOOK_AUTH=changeit; webhook -port 9000 -hooks hooks.json -template -verbose
```

```
    curl -X POST "http://localhost:9000/hooks/test-hook?auth=changeit" \
         -H "Content-Type: application/json" \
         -d@docker-hub/example-payload.json
```

## Trigger build on teamcity via api

Der Guest User in TeamCity braucht die folgenden Rechte, um einen Build anonym triggern zu können:

- Customize build parameters
- Run build

`curl -X POST "http://teamcity.hypoport.local/teamCity/guestAuth/app/rest/buildQueue" -H "Content-Type: application/xml" -d@teamcity_build.xml`

**teamcity_build.xml**
```xml
<build>
  <buildType id="pku_ExplorationDay_WebhookTest"/>
  <properties>
    <property name="repo" value="foo/bar" />
    <property name="tag" value="latest" />
  </properties>
</build>
```

**Response**
```xml
<?xml version="1.0" encoding="UTF-8" standalone="yes"?><build id="13728362" buildTypeId="pku_ExplorationDay_WebhookTest" state="queued" href="/httpAuth/app/rest/buildQueue/id:13728362" webUrl="http://teamcity.hypoport.local/teamCity/viewQueued.html?itemId=13728362"><buildType id="pku_ExplorationDay_WebhookTest" name="webhook test" projectName="PKU - Privatkredit Unit :: Exploration Day" projectId="pku_ExplorationDay" href="/httpAuth/app/rest/buildTypes/id:pku_ExplorationDay_WebhookTest" webUrl="http://teamcity.hypoport.local/teamCity/viewType.html?buildTypeId=pku_ExplorationDay_WebhookTest"/><queuedDate>20181210T154002+0100</queuedDate><triggered type="user" date="20181210T154002+0100"><user username="marc.redemske" name="marc.redemske@europace.de" id="384" href="/httpAuth/app/rest/users/id:384"/></triggered><changes href="/httpAuth/app/rest/changes?locator=build:(id:13728362)"/><revisions count="0"/><compatibleAgents href="/httpAuth/app/rest/agents?locator=compatible:(build:(id:13728362))"/><artifacts href="/httpAuth/app/rest/builds/id:13728362/artifacts/children/"/><properties count="6"><property name="repo" value="foo/bar"/><property name="tag" value="latest"/><property name="teamcity.agent.ssh_key" value="/overrides/.ssh/id_rsa" inherited="true"/><property name="teamcity.agent.vault_key" value="/vault_key" inherited="true"/><property name="vault.address" value="https://vault.pku.rz-europace.local:8200" inherited="true"/><property name="vault.skip_verify" value="1" inherited="true"/></properties></build>
```

# todo

- [x] Lauschen auf Webhooks, speziell welche vom Docker Hub, wie unter [docs.docker.com](https://docs.docker.com/docker-hub/webhooks/) beschrieben
- [x] Triggern eines Builds oder Deployments in TeamCity
- [x] Absichern des Webhooks per "API-Key". Siehe dazu die Doku unter [adnanh/webhook/.../Hook-Rules.md](https://github.com/adnanh/webhook/blob/master/docs/Hook-Rules.md)
- [ ] HTTPS aktivieren (Let's enrypt?)
- [ ] unsere ip adresse aus git history entfernen, und nur mit Platzhaltern in der Readme dokumentieren
- [ ] Webhook als Service einrichten, als non-privileged User laufen lassen
- [ ] Alles in einem Docker-Image kapseln (wie wollen wir mit Updates/temporären Downtimes des Webhooks umgehen?)
