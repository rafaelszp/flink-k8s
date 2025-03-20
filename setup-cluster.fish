#!/usr/bin/fish


if string match -q -- flink (kind get clusters)
    printf "Delete existing kind cluster\n"
    kind delete cluster --name flink
end

printf "Setup kind cluster\n"
kind create cluster --name flink --config conf/kind-config.yaml

if test $status -ne 0
    printf "Failed to create kind cluster\n"
    exit 1
end

printf "Install Ingress Nginx\n"
kubectl apply -f conf/deploy-ingress-nginx.yaml

printf "Installing PostgreSQL\n\n"

docker exec -it flink-worker2 mkdir /bitnami/postgresql -p
docker exec -it flink-worker2 chmod +777 /bitnami/postgresql

kubectl create namespace databases

kubectl apply -f conf/postgre/postgres-pvc.yaml
kubectl apply -f conf/postgre/postgres-pv.yaml

helm install postgresql oci://registry-1.docker.io/bitnamicharts/postgresql -n databases --create-namespace --values conf/postgre/postgresql-values.yaml


printf "Installing Redis\n\n"



printf "Installing Harbor\n\n"
helm repo add harbor https://helm.goharbor.io
