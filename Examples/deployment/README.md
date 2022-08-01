# Example deployments

The yaml files in this folder are hard coded to point to an invalid license server, in order to use them you will need to replace comet.synergex.loc with a valid synergy license server url or ip address.

## synergy.yaml
Runs an SSH server that drops users into a 2 node fully setup synergy environment. Deploy into your test cluster as follows
```
kubectl apply -f synergy.yaml
kubectl expose deployment synergy-test --type="LoadBalancer" --target-port=22 --port=2022
```

## harmonycore.yaml
Runs a sample harmony core service using kestrel over http only. Deploy into your test cluster as follows
```
kubectl apply -f harmonycore.yaml
kubectl expose deployment harmonycore-test --type="LoadBalancer" --target-port=8085 --port=8085
```
