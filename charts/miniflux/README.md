# miniflux

A Helm chart for the miniflux feed reader

## TL;DR;

```console
helm repo add hajowieland https://charts.wieland.tech
helm repo update
helm install my-release hajowieland/miniflux
```

## Introduction

This chart deploys the minimalist and opionated feed reader [miniflux](https://miniflux.app).

## Prerequisites

- Postgres database (e.g. [CloudNativePG](https://cloudnative-pg.io))

You can reference the [CNPG Cluster's app Secret](https://cloudnative-pg.io/documentation/1.20/applications/) in `.postgresSecret.secretName`.

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

All Miniflux configuration settings can be found here: https://miniflux.app/docs/configuration.html

Just add the Environment Variable in the `.env` section.

### Admin Password

Credentials for the admin password can be provided via an external Secret and referenced in the values section like this for example:

```yaml
adminSecret:
  enabled: true
  secretName: "my-external-secret"
  secretKey: "keyInSecretForAdminPassword"
```

Alternatively set the Environment Variable `ADMIN_PASSWORD` in the `.env` section.

## Observability

You can enable metrics via `.metrics.enabled` which sets the Environment Variables `METRICS_ALLOWED_NETWORKS: 0.0.0.0/0` and `METRICS_COLLECTOR: 1`.

If you are using Prometheus Operator (or compatible alternatives like VictoriaMetrics), then you can also deploy a ServiceMonitor via:

```yaml
metrics:
  enabled: true
  serviceMonitor:
    enabled: true
```

A Grafana dashboard visualizing those metrics is also included and can be automatically provisioned to Grafana with its grafana-sc-dashboard sidecar:

```yaml
metrics:
  enabled: true
  dashboard:
    enabled: true
    grafana_label: grafana_dashboard
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| adminSecret | object | `{"enabled":false,"secretKey":"","secretName":""}` | Sets ADMIN_PASSWORD |
| affinity | object | `{}` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| env.ADMIN_USERNAME | string | `"admin"` |  |
| env.CREATE_ADMIN | string | `"1"` |  |
| env.POLLING_PARSING_ERROR_LIMIT | string | `"0"` |  |
| env.RUN_MIGRATIONS | string | `"1"` |  |
| env.WORKER_POOL_SIZE | string | `"10"` |  |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"ghcr.io/miniflux/miniflux"` |  |
| image.tag | string | `"2.2.8"` |  |
| imagePullSecrets | list | `[]` |  |
| ingress.annotations | object | `{}` |  |
| ingress.className | string | `""` |  |
| ingress.enabled | bool | `false` |  |
| ingress.hosts[0].host | string | `"chart-example.local"` |  |
| ingress.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.hosts[0].paths[0].pathType | string | `"ImplementationSpecific"` |  |
| ingress.tls | list | `[]` |  |
| livenessProbe.httpGet.path | string | `"/"` |  |
| livenessProbe.httpGet.port | string | `"http"` |  |
| logging.format | string | `"json"` |  |
| logging.level | string | `"info"` |  |
| metrics.dashboard | object | `{"enabled":false,"grafana_label":"grafana_dashboard","grafana_label_key":"1"}` | deploy Grafana dashboard |
| metrics.enabled | bool | `false` | sets envvars METRICS_ALLOWED_NETWORKS to 0.0.0.0/0 and METRICS_COLLECTOR to 1 |
| metrics.serviceMonitor.enabled | bool | `false` |  |
| metrics.serviceMonitor.interval | string | `"30s"` |  |
| metrics.serviceMonitor.scrapeTimeout | string | `"30s"` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| podAnnotations | object | `{}` |  |
| podLabels | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| postgresSecret | object | `{"enabled":false,"secretName":"","uriKey":"uri"}` | Sets DATABASE_URL |
| postgresSecret.uriKey | string | `"uri"` | Can be used for the "-app" Secret created by a CNPG cluster |
| readinessProbe.httpGet.path | string | `"/"` |  |
| readinessProbe.httpGet.port | string | `"http"` |  |
| replicaCount | int | `1` |  |
| resources | object | `{}` |  |
| securityContext.allowPrivilegeEscalation | bool | `false` |  |
| securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| securityContext.readOnlyRootFilesystem | bool | `true` |  |
| securityContext.runAsNonRoot | bool | `true` |  |
| securityContext.runAsUser | int | `65534` |  |
| service.port | int | `8080` |  |
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
