# web-check

A Helm chart for web-check all-in-one OSINT tool for analysing any website

## TL;DR;

```console
helm repo add hajowieland https://charts.wieland.tech
helm repo update
helm install my-release hajowieland/web-check
```

## Introduction

This chart deploys the All-in-one OSINT tool for analysing any website: [web-check](https://github.com/Lissy93/web-check).

## Prerequisites

API keys are required for the following external services:

- `BUILT_WITH_API_KEY`: BuiltWith API key ([get here](https://builtwith.com/signup)). This will show the main features of a site
- `CLOUDMERSIVE_API_KEY`: Cloudmersive API key ([get here](https://portal.cloudmersive.com/signup)). is will show known threats associated with the IP
- `GOOGLE_CLOUD_API_KEY`: Google API key ([get here](https://cloud.google.com/api-gateway/docs/authenticate-api-keys)). This can be used to return quality metrics for a site
- `REACT_APP_SHODAN_API_KEY`: Shodan API key ([get here](https://account.shodan.io/)). This will show associated host names for a given domain
- `REACT_APP_WHO_API_KEY`: WhoAPI key ([get here](https://whoapi.com/)). This will show more comprehensive WhoIs records than the default job
- `SECURITY_TRAILS_API_KEY` Security Trails API key ([get here](https://securitytrails.com/corp/api)). This will show org info associated with the IP
- `TORRENT_IP_API_KEY`: A torrent API key ([get here](https://iknowwhatyoudownload.com/en/api/)). This will show torrents downloaded by an IP
- `TRANCO_USERNAME` - Tranco email ([get here](https://tranco-list.eu/)). This will show the rank of a site, based on traffic
- `TRANCO_API_KEY` - Tranco API key ([get here](https://tranco-list.eu/)). This will show the rank of a site, based on traffic
- `URL_SCAN_API_KEY` - URLScan API key ([get here](https://urlscan.io/)). This will fetch miscalanious info about a site

You can provide those keys in the `.config.env` section or load them from an external Secret via `.config.envSecrets` or only specific ones in `.config.secretKeyRef`.

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

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| config.env.API_CORS_ORIGIN | string | `"*"` |  |
| config.env.API_ENABLE_RATE_LIMIT | string | `"false"` |  |
| config.env.API_TIMEOUT_LIMIT | string | `"60000"` |  |
| config.env.DISABLE_GUI | string | `"false"` |  |
| config.env.ENABLE_ANALYTICS | string | `"false"` |  |
| config.env.PUPPETEER_EXECUTABLE_PATH | string | `"/usr/bin/chromium"` | see: https://github.com/Lissy93/web-check/issues/108#issuecomment-2307696851 |
| config.envSecrets.secretKeyRef | list | `[]` |  |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"Always"` |  |
| image.repository | string | `"ghcr.io/lissy93/web-check"` |  |
| image.tag | string | `"latest"` |  |
| imagePullSecrets | list | `[]` |  |
| ingress.annotations | object | `{}` |  |
| ingress.className | string | `""` |  |
| ingress.enabled | bool | `false` |  |
| ingress.hosts[0].host | string | `"web-check.local"` |  |
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
| service.port | int | `3000` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.automount | bool | `false` |  |
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
