# flink-k8s

- Flink Native kubernetes <https://nightlies.apache.org/flink/flink-docs-release-1.20/docs/deployment/resource-providers/native_kubernetes/>
- Harbor container registry: <https://goharbor.io/docs/2.12.0/install-config/harbor-ha-helm/>
- Kubernetes in Docker: <https://kind.sigs.k8s.io/>
- helm <https://helm.sh>
- <https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/>

```bash
echo Aa123456789 | docker login --username test --password-stdin localhost:40443
docker tag <image> core.harbor.domain:40443/<REPOSITORY>/<IMAGE>:<TAG> 
docker push core.harbor.domain:40443/<REPOSITORY>/<IMAGE>:<TAG>
```

```bash
cat  ~/.docker/config.json | jq '{ auths: { "core.harbor.domain:40443": .auths."core.harbor.domain:40443" } }' > /tmp/docker-config.json
kubectl create secret generic internal-registry-creds --from-file=.dockerconfigjson=/tmp/docker-config.json --type=kubernetes.io/dockerconfigjson

```

## Attemps

1. attempt number #1 failed because of a known issue: <https://github.com/goharbor/harbor/issues/20524> (Image pull issue from Harbor registry which is deployed on the same cluster.)

2. Attemp number #2: Setup ngrok to expose the harbor registry to the outside world. This way, we can pull images from the harbor registry without any issues.
   - ngrok: <https://ngrok.com/>
   - ngrok http <https://localhost:40443>
   - SUCCESS: The image was pulled successfully from the harbor registry.
