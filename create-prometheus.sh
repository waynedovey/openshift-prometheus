#!/bin/bash
# Node Label Version
#oc adm new-project prometheus --node-selector="region=infra"
oc adm new-project prometheus 
oc project prometheus 
sleep 5

oc create -f prometheus-dc.yaml
oc adm policy add-cluster-role-to-user cluster-reader system:serviceaccount:prometheus:default
oc adm policy add-cluster-role-to-user cluster-reader system:serviceaccount:prometheus:metrics
oc create -f prometheus-service.yaml 
oc create -f prometheus-configmap.yaml
oc create -f sa-metrics.yaml
oc expose service prometheus

oc adm pod-network make-projects-global nft
oc adm pod-network make-projects-global wow
oc adm pod-network make-projects-global prometheus
oc adm pod-network make-projects-global openshift-infra

bash prometheus-pvc-pv.sh
