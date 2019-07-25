## Download repo

```
git clone https://github.com/oneoneonepig/YAML-Templates.git
cd ./redis-ha/redis-operator/
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
if [[ -f "./run.sh" ]]; then
  kubectl delete configmap redis-monitor-script 
  kubectl create configmap redis-monitor-script --from-file=./run.sh
  kubectl delete pod -l app=redis-monitor
fi

kubectl apply -f monitor-pod.yaml
```

## Install redis 5 (Ubuntu)

```
if [[ $EUID -ne 0 ]]; then
  sudo su -
fi
apt update
apt install -y wget build-essential tcl
wget http://download.redis.io/releases/redis-5.0.5.tar.gz
tar xzf redis-5.0.5.tar.gz
cd redis-5.0.5
make install
# make test
redis-cli --version
```

## Install redis 5 (alpine)


```
apk update
apk install alpine-sdk linux-headers tcl
wget http://download.redis.io/releases/redis-5.0.5.tar.gz
tar xzf redis-5.0.5.tar.gz
cd redis-5.0.5
make install
# make test
redis-cli --version
```
