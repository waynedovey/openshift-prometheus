#!/bin/bash
#oc adm new-project prometheus --node-selector="region=infra"
oc adm new-project prometheus 
oc project prometheus 
sleep 5

oc new-app --name='grafana' --strategy='docker' .
oc expose service grafana
