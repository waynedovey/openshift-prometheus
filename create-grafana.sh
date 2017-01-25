#!/bin/bash
source /etc/profile 
export DEPLOY_DNS_DOMAIN=`/usr/local/bin/pipeline_dns -c ''`

oadm new-project prometheus --node-selector="region=infra"
oc project prometheus 
sleep 5

oc new-app --name='grafana' --strategy='docker' .
oc expose service grafana --hostname="grafana.${DEPLOY_DNS_DOMAIN}"
