# librechat

Helm Chart for LibreChat

## TL;DR;

```console
helm repo add hajowieland https://charts.wieland.tech
helm repo update
helm install my-release hajowieland/librechat
```

## Introduction

This chart deploys the [RAG API](https://github.com/danny-avila/rag_api) for [LibreChat](https://librechat.ai).

## Prerequisites

- Mongo database (e.g. [mongodb-kubernetes-operator](https://github.com/mongodb/mongodb-kubernetes-operator))

Then you can reference the MongoDB connection string Secret:

```yaml
config:
  envSecrets:
    secretRef: librechat
    secretKeyRef:
      - name: MONGO_URI
        secretName: librechat-mongo-admin-librechat
        secretKey: "connectionString.standard"
```

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm repo add hajowieland https://charts.wieland.tech
helm repo update
helm install my-release hajowieland/miniflux
```

The [Values](#values) section lists the values that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall the `my-release` deployment:

```console
helm uninstall my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Tips

The minimum required credentials are:

- https://www.librechat.ai/toolkit/creds_generator
- OPENAI_API_KEY _(can be a dummy)_

## User registration

By default, registration for new users is disabled for security purposes. The first to register will be assigned admin privileges.

Enable registration via:

```yaml
config:
  env:
    ALLOW_REGISTRATION: "true"
    # ALLOW_SOCIAL_REGISTRATION: "true" # if you plan to use OIDC (you need additional configuration)
```

## Deploy all components

You can optionally deploy other LibreChat components.

> Please set `.wait.enabled` to true to make sure all components below are up and running before starting LibreChat itself.

### Meilisearch

https://www.meilisearch.com

```yaml
meilisearch:
  enabled: true
```

### rag_api

https://github.com/danny-avila/rag_api

Check the requirements (Postgres database) here: https://github.com/hajowieland/charts/tree/main/charts/librechat-rag-api#prerequisites

```yaml
ragapi:
  enabled: true
```

### sandpack

To use the [Artifacts](https://www.librechat.ai/docs/features/artifacts) feature and host the sandpack library yourself:

```yaml
sandpack:
  enabled: true
```

### Prometheus Exporter

For more observability of your LibreChat deployment, you can enable the [librechat_exporter](https://github.com/virtUOS/librechat_exporter/tree/main).

See more info about configuration options here: https://github.com/hajowieland/charts/tree/main/charts/librechat-exporter

```yaml
exporter:
  enabled: true
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| config.env.ALLOW_EMAIL_LOGIN | string | `"true"` |  |
| config.env.ALLOW_REGISTRATION | string | `"false"` |  |
| config.env.ALLOW_SOCIAL_LOGIN | string | `"false"` |  |
| config.env.ALLOW_SOCIAL_REGISTRATION | string | `"false"` |  |
| config.envSecrets.secretKeyRef | list | `[]` |  |
| config.externalDomain | string | `""` | sets DOMAIN_CLIENT and DOMAIN_SERVER, should be the external URL like https://chat.example.com |
| config.librechatYaml | object | `{"version":"1.2.5"}` | Examples: https://github.com/LibreChat-AI/librechat-config-yaml |
| exporter.enabled | bool | `false` |  |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"ghcr.io/danny-avila/librechat"` |  |
| image.tag | string | `""` |  |
| imagePullSecrets | list | `[]` |  |
| ingress.annotations | object | `{}` |  |
| ingress.className | string | `""` |  |
| ingress.enabled | bool | `false` |  |
| ingress.hosts[0].host | string | `"chat.example.com"` |  |
| ingress.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.hosts[0].paths[0].pathType | string | `"ImplementationSpecific"` |  |
| ingress.tls | list | `[]` |  |
| livenessProbe.httpGet.path | string | `"/"` |  |
| livenessProbe.httpGet.port | string | `"http"` |  |
| livenessProbe.initialDelaySeconds | int | `15` |  |
| livenessProbe.timeoutSeconds | int | `3` |  |
| meilisearch.enabled | bool | `false` |  |
| meilisearch.environment.MEILI_ENV | string | `"production"` |  |
| meilisearch.environment.MEILI_NO_ANALYTICS | bool | `false` |  |
| meilisearch.persistence.enabled | bool | `false` |  |
| nameOverride | string | `""` |  |
| networkPolicies.enabled | bool | `true` |  |
| nodeSelector | object | `{}` |  |
| podAnnotations | object | `{}` |  |
| podLabels | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| ragapi.enabled | bool | `false` |  |
| readinessProbe.httpGet.path | string | `"/"` |  |
| readinessProbe.httpGet.port | string | `"http"` |  |
| readinessProbe.initialDelaySeconds | int | `15` |  |
| readinessProbe.timeoutSeconds | int | `3` |  |
| replicaCount | int | `1` |  |
| resources | object | `{}` |  |
| sandpack.applicationName | string | `"librechat-sandpack"` |  |
| sandpack.deployment.containerSecurityContext.readOnlyRootFilesystem | bool | `false` |  |
| sandpack.deployment.containerSecurityContext.runAsNonRoot | bool | `false` |  |
| sandpack.deployment.image.pullPolicy | string | `"Always"` |  |
| sandpack.deployment.image.repository | string | `"ghcr.io/librechat-ai/codesandbox-client/bundler"` |  |
| sandpack.deployment.image.tag | string | `"latest"` |  |
| sandpack.deployment.livenessProbe.enabled | bool | `true` |  |
| sandpack.deployment.livenessProbe.httpGet.path | string | `"/"` |  |
| sandpack.deployment.livenessProbe.httpGet.port | string | `"http"` |  |
| sandpack.deployment.livenessProbe.httpGet.scheme | string | `"HTTP"` |  |
| sandpack.deployment.ports[0].containerPort | int | `80` |  |
| sandpack.deployment.ports[0].name | string | `"http"` |  |
| sandpack.deployment.ports[0].protocol | string | `"TCP"` |  |
| sandpack.deployment.readinessProbe.enabled | bool | `true` |  |
| sandpack.deployment.readinessProbe.httpGet.path | string | `"/"` |  |
| sandpack.deployment.readinessProbe.httpGet.port | string | `"http"` |  |
| sandpack.deployment.readinessProbe.httpGet.scheme | string | `"HTTP"` |  |
| sandpack.enabled | bool | `false` |  |
| sandpack.service.ports[0].name | string | `"http"` |  |
| sandpack.service.ports[0].port | int | `80` |  |
| sandpack.service.ports[0].protocol | string | `"TCP"` |  |
| sandpack.service.ports[0].targetPort | int | `80` |  |
| securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` | filesystems needs to be writable - or LibreChat fails at startup |
| securityContext.runAsNonRoot | bool | `true` |  |
| securityContext.runAsUser | int | `1000` |  |
| service.port | int | `3080` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| tolerations | list | `[]` |  |
| wait | object | `{"enabled":false,"image":{"pullPolicy":"IfNotPresent","repository":"alpine/curl","tag":"8.12.1"}}` | initContainer to wait until all components (meilisearch, sandpack, ragapi) are ready before running LibreChat. |

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```console
helm install my-release -f values.yaml hajowieland/miniflux
```
