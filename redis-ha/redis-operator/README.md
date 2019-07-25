## Download repo

```
git clone https://github.com/oneoneonepig/YAML-Templates.git
```

## Install CRD and create instance

```
kubectl apply -f crd.yaml
until kubectl get crd redisfailovers.databases.spotahome.com >/dev/null 2>&1; do echo "Waiting for redis-operator CRD creation..."; sleep 3; done && echo "redis-operator CRD creation complete"

kubectl apply -f basic.yaml
```

## Scale redis to desired replicas

```
kubectl edit redisfailovers redisfailover
-> spec.redis.replicas: 6
```

## Create HPA object (min/6,max/6)

```
kubectl apply -f hpa-v1.yaml
```

## Create ConfigMap and monitoring pod

```
kubectl create configmap redis-monitor-script --from-file=./run.sh
kubectl apply -f monitor-pod.yaml
```
