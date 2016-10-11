#!/bin/bash
oadm new-project prometheus --node-selector="region=infra"
oc project prometheus 
sleep 5

oc create -f prometheus-dc.yaml
oc create -f prometheus-service.yaml 
oc create -f prometheus-configmap.yaml
oc create -f sa-metrics.yaml
oc expose service prometheus
