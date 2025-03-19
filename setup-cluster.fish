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

helm install postgre oci://registry-1.docker.io/bitnamicharts/postgresql -n databases --create-namespace --config conf/postgre/postgresql-values.yaml
