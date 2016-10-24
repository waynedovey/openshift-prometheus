#!/bin/bash

oc create -f - <<API
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: prometheus-claim
spec:
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 50Gi
API

oc volume dc/prometheus \
          --add --overwrite --name=data-volume \
          --type=persistentVolumeClaim --claim-name=prometheus-claim 2>&1 | tee -a $LOGFILE
