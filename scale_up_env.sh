#!/bin/bash

echo "=============== Check the Namespace ==============="
kubectl get ns | grep -i $NAMESPACE > ns.txt
if [[ -s ns.txt ]]; then
echo "::set-output name=env_exist::true"
if ! (( $(kubectl get ns master -o jsonpath='{.metadata.annotations}' | grep -q 'protected') )); then
    echo "=============== Scaling Deployments ==============="
    kubectl scale deploy -n $NAMESPACE --replicas=1 --all
    echo "============== Scaling StatefulSets ==============="
    kubectl scale statefulset -n $NAMESPACE --replicas=1 --all
else
    echo "Your Environment is PROTECTED, Can not be updated!"
fi
else
echo "::set-output name=env_exist::false"
echo "Your Environment does not exists"
fi