#!/bin/bash

echo "=============== Check the Namespace ==============="
kubectl get ns | grep -i $NAMESPACE > ns.txt
if [[ -s ns.txt ]]; then
if ! (( $(kubectl get ns master -o jsonpath='{.metadata.annotations}' | grep -q 'protected') )); then
    echo "=============== Starting Environment Removing ==============="
    kubectl delete ns $NAMESPACE || true
    kubectl delete pv data-mysql-${NAMESPACE} || true
    gcloud compute disks delete "${NAMESPACE}-db" --zone=us-central1-a || true
    sleep 30;
else
    echo "Your Environment is PROTECTED, Can not be updated!"
fi
else
echo "Your Environment does not exists"
fi