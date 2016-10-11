#!/bin/bash
oadm new-project prometheus --node-selector="region=infra"
oc project prometheus 
sleep 5

oc create -f grafana-dc.yaml
oc create -f grafana-service.yaml 
#oc create -f grafana-configmap.yaml
oc create -f sa-metrics.yaml
oc expose service grafana
