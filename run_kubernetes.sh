#!/usr/bin/env bash

# This tags and uploads an image to Docker Hub

# Step 1:
# This is your Docker ID/path
dockerpath=kapil24nagar/mlpred

# Step 2
# Run the Docker Hub container with kubernetes
r=$(kubectl get pod mlpred 2> /dev/null;echo $?)

if [ "_$r" == "_1" ] ; then
    kubectl run mlpred \
    --image=$dockerpath \
    --image-pull-policy="Always" \
    --overrides='{"apiVersion": "v1", "spec":{"imagePullSecrets": [{"name": "regcred"}]}}'
fi


# Step 3:
# List kubernetes pods
kubectl get pods
echo "Please wait for pod to start";
sleep 8
kubectl get pods
sleep 5
# Step 4:
# Forward the container port to a host
kubectl port-forward mlpred 8080:80
kubectl logs mlpred