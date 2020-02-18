# Hooky

Hooky is a webhook handler for [Anchore Engine](https://anchore.com/engine/) with interactive [Slack](https://slack.com/intl/en-be/) notifications and slash commands.

## TL;DR

```console
$ helm install my-release hooky .
```

## Introduction

This chart bootstraps a Hooky deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.14+
- Helm 3.0.2+

## Installing the Chart

To install the chart with the release name `my-release`:

```console
$ helm install my-release hooky .
```

The command deploys Hooky on the Kubernetes cluster in the default configuration. The [Parameters](#parameters) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Parameters

The following tables lists the configurable parameters of the Hooky chart and their default values.

| Parameter | Description | Default |
|-----------|-------------|---------|
| `replicaCount` | | `1` |
| `image.repository` | | `lazybit.ch/hooky` |
| `image.pullPolicy` | | `IfNotPresent` |
| `image.pullSecrets` | | `[]` |
| `nameOverride` | | `""` |
| `fullnameOverride` | | `""` |
| `serviceAccount.create` | | `true` |
| `serviceAccount.name` | | |
| `podSecurityContext` | | `{}` |
| `securityContext` | | `{}` |
| `service.type` | | `ClusterIP` |
| `service.port` | | `3000` |
| `ingress.enabled` | | `false` |
| `ingress.annotations` | | `{}` |
| `ingress.hosts[0].host` | | `chart-example.local` |
| `ingress.hosts[0].paths` | | `[]` |
| `ingress.tls` | | `[]` |
| `resources` | | `{}` |
| `nodeSelector` | | `{}` |
| `tolerations` | | `[]` |
| `affinity` | | `{}` |
| `livenessProbe.enabled` | | `true` |
| `readinessProbe.enabled` | | `true` |
| `slack.existingSecrets` | | `[]` |
| `slack.signingSecret` | | `""` |
| `slack.apiToken` | | `""` |
| `slack.channel` | | `""` |
| `anchore-engine.enabled` | | `true` |
| `anchore-engine.postgresql.enabled` | | `true` |
| `anchore-engine.postgresql.postgresDatabase` | | `anchore-engine` |
| `anchore-engine.postgresql.postgresUser` | | `postgres` |
| `anchore-engine.postgresql.replication.enabled` | | `true` |
| `anchore-engine.postgresql.replication.slaveReplicas` | | `2` |
| `anchore-engine.postgresql.replication.synchronousCommit` | | `"on"` |
| `anchore-engine.postgresql.replication.numSynchronousReplicas` | | `1` |
| `anchore-engine.postgresql.metrics.enabled` | | `true` |
| `anchore-engine.postgresql.persistence.resourcePolicy` | | `nil` |
| `anchore-engine.postgresql.persistence.size` | | `20Gi` |
| `anchore-engine.anchoreGlobal.logLevel` | | `DEBUG` |
| `anchore-engine.anchoreGlobal.defaultAdminPassword` | | `""` |
| `anchore-engine.anchoreGlobal.defaultAdminEmail` | | `no-reply@lazybit.ch` |
| `anchore-engine.anchoreGlobal.webhooksEnabled` | | `true` |
| `anchore-engine.anchoreGlobal.webhooks.webhook_user` | | `Null` |
| `anchore-engine.anchoreGlobal.webhooks.webhook_pass` | | `Null` |
| `anchore-engine.anchoreGlobal.webhooks.ssl_verify` | | `False` |
| `anchore-engine.anchoreGlobal.webhooks.general.url` | | `""` |
| `anchore-engine.anchoreGlobal.webhooks.tag_update.url` | | `""` |
| `anchore-engine.anchoreGlobal.webhooks.policy_eval.url` | | `""` |
| `anchore-engine.anchoreGlobal.webhooks.error_event.url` | | `""` |
| `anchore-engine.anchoreGlobal.webhooks.analysis_update.url` | | `""` |
| `anchore-engine.anchoreCatalog.events.notification.enabled` | | `true` |
| `anchore-engine.anchoreCatalog.events.notification.level` | | `["info", "warning", "error", "debug"]` |
| `anchore-engine.anchore-ui-redis.enabled` | | `false` |
| `anchore-engine.anchoreEnterpriseGlobal.enabled` | | `false` |

## Customize the installation

Install and configure the service using an existing `redis` instance:

```console
$ HOOKY_HOSTNAME=hooky.example.com helm upgrade --install \
    -n anchore-engine \
    --set image.pullSecrets[0].name="image-pull-secret" \
    --set image.pullPolicy=IfNotPresent \
    --set ingress.enabled=true \
    --set ingress.hosts[0].host=$HOOKY_HOSTNAME \
    --set ingress.hosts[0].paths[0]=/ \
    --set ingress.tls[0].secretName="ingress-tls-secret" \
    --set ingress.tls[0].hosts[0]=$HOOKY_HOSTNAME \
    --set slack.signingSecret="slack-signing-secret" \
    --set slack.apiToken="slack-api-token" \
    --set slack.channel=DEADBEEF \
    --set anchore-engine.anchoreGlobal.defaultAdminPassword="" \
    --set anchore-engine.anchoreGlobal.webhooks.general.url=https://$HOOKY_HOSTNAME/general_update \
    --set anchore-engine.anchoreGlobal.webhooks.tag_update.url=https://$HOOKY_HOSTNAME/tag_update \
    --set anchore-engine.anchoreGlobal.webhooks.policy_eval.url=https://$HOOKY_HOSTNAME/policy_eval \
    --set anchore-engine.anchoreGlobal.webhooks.error_event.url=https://$HOOKY_HOSTNAME/error_event \
    --set anchore-engine.anchoreGlobal.webhooks.analysis_update.url=https://$HOOKY_HOSTNAME/analysis_update \
    --set redis.existingSecrets[0].name=redis \
    --set redis.existingSecrets[0].key=redis-password \
    -f values.yaml \
    hooky .
```
