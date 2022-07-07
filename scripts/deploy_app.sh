#!/bin/bash



gcloud container clusters get-credentials $1 --zone $2

kubectl apply -f $3
kubectl create configmap img-configmap --from-file=im1.png
kubectl create configmap img2-configmap --from-file=im2.png
kubectl create configmap system-configmap --from-file=system.json
kubectl create configmap template-configmap --from-file=template.json
kubectl apply -f $4



