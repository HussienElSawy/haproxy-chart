# haproxy-helm

A Helm chart for deploying [HAProxy](https://www.haproxy.org/) in Kubernetes.

## Features

- Configurable HAProxy frontend and backend
- Stats and monitoring endpoints
- Customizable backend servers
- Resource requests and limits
- Supports HTTP and TCP modes

## Prerequisites

- Kubernetes cluster (v1.16+ recommended)
- Helm 3.x

## Installation

```sh
helm install my-haproxy ./haproxy-helm
```

## Configuration

You can customize the deployment by editing `values.yaml` or using `--set` flags.

### Example `values.yaml`

```yaml
replicaCount: 2

image:
  repository: haproxy
  tag: "2.8"
  pullPolicy: IfNotPresent

service:
  type: ClusterIP
  frontend_port: 80
  stats_port: 8181

haproxy:
  default:
    mode: http
    log: httplog
  defaults:
    connect_timeout: "5000ms"
    client_timeout: "50000ms"
    server_timeout: "50000ms"
  backend_balance: roundrobin
  backendServers:
    - name: service1
      address: service1.namespace.svc.cluster.local:8080
    - name: service2
      address: service2.namespace.svc.cluster.local:8080
```

### Customizing Backend Servers

Add or remove entries under `haproxy.backendServers` to define your backend services.

### Resource Limits

Modify the `resource` section to set CPU and memory requests/limits.

## Usage

After installation, HAProxy will listen on the configured `frontend_port` and expose stats on `stats_port`.

- **Frontend:** Handles incoming traffic and routes to backend servers.
- **Stats:** Access HAProxy stats UI at `http://<haproxy-service>:8181/`

## Uninstall

```sh
helm uninstall my-haproxy
```

## Files

- `values.yaml`: Default configuration values
- `templates/`: Kubernetes manifests
- `templates/configmap.yaml`: HAProxy configuration
- `templates/deployment.yaml`: Deployment spec
- `templates/service.yaml`: Service spec