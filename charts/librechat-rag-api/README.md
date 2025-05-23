# rag-api

A Helm chart for rag-api (LibreChat)

## TL;DR;

```console
helm repo add hajowieland https://charts.wieland.tech
helm repo update
helm install my-release hajowieland/librechat-rag-api
```

## Introduction

This chart deploys the [RAG API](https://github.com/danny-avila/rag_api) for [LibreChat](https://librechat.ai).

## Prerequisites

- Postgres database (e.g. [CloudNativePG](https://cloudnative-pg.io))

You can reference the [CNPG Cluster's app Secret](https://cloudnative-pg.io/documentation/1.20/applications/) in `.postgresSecret.secretName`.

> To create the pgvector extension, superuser credentials are required. See [ci-values.yaml](./ci/ci-values.yaml) for an example on how to get superuser username and password from another Secret.

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

## Configuration

All RAG API configuration settings can be found here: https://github.com/danny-avila/rag_api/tree/v0.5.0?tab=readme-ov-file

Just add the Environment Variable in the `.env` section.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| config.env.CHUNK_OVERLAP | string | `"100"` |  |
| config.env.CHUNK_SIZE | string | `"1500"` |  |
| config.env.COLLECTION_NAME | string | `"testcollection"` |  |
| config.env.CONSOLE_JSON | string | `"True"` |  |
| config.env.DEBUG_RAG_API | string | `"False"` |  |
| config.env.EMBEDDINGS_MODEL | string | `"text-embedding-3-small"` |  |
| config.env.EMBEDDINGS_PROVIDER | string | `"openai"` |  |
| config.env.PDF_EXTRACT_IMAGES | string | `"False"` |  |
| config.env.RAG_USE_FULL_CONTEXT | string | `"False"` |  |
| config.env.VECTOR_DB_TYPE | string | `"pgvector"` |  |
| config.envSecrets.secretKeyRef | list | `[]` |  |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"Always"` |  |
| image.repository | string | `"ghcr.io/danny-avila/librechat-rag-api-dev-lite"` |  |
| image.tag | string | `"latest"` |  |
| imagePullSecrets | list | `[]` |  |
| ingress.annotations | object | `{}` |  |
| ingress.className | string | `""` |  |
| ingress.enabled | bool | `false` |  |
| ingress.hosts[0].host | string | `"chart-example.local"` |  |
| ingress.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.hosts[0].paths[0].pathType | string | `"ImplementationSpecific"` |  |
| ingress.tls | list | `[]` |  |
| livenessProbe.httpGet.path | string | `"/health"` |  |
| livenessProbe.httpGet.port | string | `"http"` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| persistence.accessMode | string | `"ReadWriteOnce"` |  |
| persistence.enabled | bool | `false` |  |
| persistence.existingClaim | string | `""` |  |
| persistence.size | string | `"10Gi"` |  |
| persistence.storageClass | string | `""` |  |
| podAnnotations | object | `{}` |  |
| podLabels | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| postgresSecret.dbnameKey | string | `"dbname"` |  |
| postgresSecret.enabled | bool | `false` |  |
| postgresSecret.hostKey | string | `"host"` |  |
| postgresSecret.passwordKey | string | `""` | if empty, set POSTGRES_PASSWORD in .config.env - or get superuser password from .config.secretKeyRef and set name: POSTGRES_PASSWORD |
| postgresSecret.portKey | string | `"port"` |  |
| postgresSecret.secretName | string | `""` |  |
| postgresSecret.userKey | string | `""` | # if empty, set POSTGRES_USER in .config.env |
| readinessProbe.httpGet.path | string | `"/health"` |  |
| readinessProbe.httpGet.port | string | `"http"` |  |
| replicaCount | int | `1` |  |
| resources | object | `{}` |  |
| securityContext | object | `{}` |  |
| service.port | int | `8000` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.automount | bool | `true` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| tolerations | list | `[]` |  |
| volumeMounts | list | `[]` |  |
| volumes | list | `[]` |  |

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```console
helm install my-release -f values.yaml hajowieland/miniflux
```
