#!/bin/bash
# pipes-transaction-dashboard-nft.json
curl -X POST http://admin:admin@grafana-prometheus.cloudapps.uat.ocp.bfsonlinebanking.syd.non.c1.macquarie.com/api/v2/grafana/dashboards/ \
     -d @pipes-transaction-dashboard-nft.json
#curl -X POST http://admin:admin@grafana-prometheus.cloudapps.uat.ocp.bfsonlinebanking.syd.non.c1.macquarie.com/api/dashboards/db \
#     -d @pipes-transaction-dashboard-nft.json
#curl -X GET http://admin:admin@grafana-prometheus.cloudapps.uat.ocp.bfsonlinebanking.syd.non.c2.macquarie.com/api/dashboards/db 
