#!/bin/bash
source /etc/profile 

oadm new-project prometheus --node-selector="region=infra"
oc project prometheus 
sleep 5

oc create -f prometheus-dc-test.yaml
oadm policy add-cluster-role-to-user cluster-reader system:serviceaccount:prometheus:default
oadm policy add-cluster-role-to-user cluster-reader system:serviceaccount:prometheus:metrics
oc create -f prometheus-service.yaml 
oc create -f prometheus-configmap-test.yaml
oc create -f sa-metrics.yaml
oc expose service prometheus 

oadm pod-network make-projects-global nft
oadm pod-network make-projects-global wow
oadm pod-network make-projects-global prometheus
oadm pod-network make-projects-global openshift-infra

#bash prometheus-pvc-pv.sh
git clone https://github.com/waynedovey/gluster-ose.git
chmod +x ./gluster-ose/create-pv-pvc.sh
./gluster-ose/create-pv-pvc.sh
