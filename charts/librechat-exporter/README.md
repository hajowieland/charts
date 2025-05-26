# librechat-exporter

A Prometheus metrics exporter for LibreChat

## TL;DR;

```console
helm repo add hajowieland https://charts.wieland.tech
helm repo update
helm install my-release hajowieland/librechat-exporter
```

## Introduction

This chart deploys [virtUOS/librechat_exporter](https://github.com/virtUOS/librechat_exporter): a Prometheus exporter for LibreChat.

## Prerequisites

- [LibreChat](https://github.com/hajowieland/charts/tree/main/charts/librechat)

You need to reference the LibreChat MongoDB Secret containing the connection string via:

```yaml
env:
  MONGODB_DATABASE: admin # Set your Mongo database name here
config:
  envSecrets:
    secretKeyRef:
      - name: MONGODB_URI
        secretName: librechat-mongo-admin-librechat # Set the MongoDB Secret name here
        secretKey: "connectionString.standard"
```

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm repo add hajowieland https://charts.wieland.tech
helm repo update
helm install my-release hajowieland/librechat-exporter
```

The [Values](#values) section lists the values that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall the `my-release` deployment:

```console
helm uninstall my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| config.envSecrets.secretKeyRef | list | `[]` |  |
| env.LOGGING_FORMAT | string | `"%(asctime)s - %(levelname)s - %(message)s"` |  |
| env.LOGGING_LEVEL | string | `"info"` |  |
| env.MONGODB_DATABASE | string | `"librechat"` |  |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"ghcr.io/virtuos/librechat_exporter"` |  |
| image.tag | string | `""` |  |
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
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| podAnnotations | object | `{}` |  |
| podLabels | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| readinessProbe.httpGet.path | string | `"/"` |  |
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
| serviceMonitor.enabled | bool | `false` |  |
| serviceMonitor.interval | string | `"30s"` |  |
| serviceMonitor.scrapeTimeout | string | `"30s"` |  |
| tolerations | list | `[]` |  |
| volumeMounts | list | `[]` |  |
| volumes | list | `[]` |  |

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```console
helm install my-release -f values.yaml hajowieland/miniflux
```
