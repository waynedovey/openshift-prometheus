#!/bin/bash
oadm new-project prometheus --node-selector="region=infra"
oc project prometheus 
sleep 5

oc new-app --name='grafana' --strategy='docker' .
oc expose service grafana
