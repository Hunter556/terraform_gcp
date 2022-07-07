#!/bin/bash

gcloud container clusters get-credentials $1 --zone $2
kubectl delete all --all

