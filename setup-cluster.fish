#!/usr/bin/fish


if string match -q -- flink (kind get clusters)
    printf "Delete existing kind cluster\n"
    kind delete cluster --name flink
end

printf "Setup kind cluster\n"
kind create cluster --name flink --config conf/kind-config.yaml


printf "Install Ingress Nginx\n"
kubectl apply -f conf/deploy-ingress-nginx.yaml
