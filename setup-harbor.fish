#!/usr/bin/fish
#
#
printf "Installing Harbor\n\n"
kubectl create namespace harbor
helm install harbor ./conf/harbor -n harbor
