# etcd-druid-certs

Create Certificates and Issuers for an etcd-druid Etcd cluster

## TL;DR;

```console
helm repo add hajowieland https://charts.wieland.tech
helm repo update
helm install my-release hajowieland/etcd-druid-certs
```

## Introduction

This chart deploys all certificate-related resources required to deploy etcd clusters via [etcd-druid](https://gardener.github.io/etcd-druid/).

It creates [cert-manager](http://cert-manager.io) Custom Resources to deploy Issuers and Certificates for all etcd communication lines to be TLS encrypted.

## Prerequisites

- [cert-manager](http://cert-manager.io)

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm repo add hajowieland https://charts.wieland.tech
helm repo update
helm install my-release hajowieland/etcd-druid-certs
```

These commands deploy Certicates & Issuers which are reconciled by cert-manager and can then be referenced in an etcd-druid `Etcd` Custom Resource.

The [Values](#values) section lists the values that can be configured during installation.

### Etcd

The release name and replicas should match the name and desired replicas of the Etcd cluster you deploy the certificates for.
Also note that it needs to be in the same Namespace as your Etcd.

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
| etcdName | string | `""` | Set the name for the desired Etcd cluster - will be used in cert SANs |
| privateKey | object | `{"algorithm":"RSA","size":4096}` | Certicate algorithm and size to be used in the private keys |
| replicas | int | `3` | Replicas of the Etcd cluster |
| subject | object | `{"organizationalUnits":["Kubernetes"],"organizations":["STACKX Cloud"]}` | Personalize the subject field in the certificates |

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```console
helm install my-release -f values.yaml hajowieland/etcd-druid-certs
```
