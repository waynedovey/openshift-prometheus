#!/bin/bash

GLUSTER_SHARE=
export GUID=`/usr/local/bin/pipeline_dns -c ansible | tr -s '.' ' ' | awk '{print $2}'`

oc create -f - <<API
apiVersion: v1
kind: PersistentVolume
metadata:
  name: prometheus
spec:
  capacity:
    storage: 50Gi
  accessModes:
    - ReadWriteMany
  persistentVolumeReclaimPolicy: Recycle
  nfs:
    server: ${GLUSTER_SHARE}
    path: /gluster/${GUID}/prometheus
API

sleep 5

oc create -f - <<API
apiVersion: v1
kind: PersistentVolume
metadata:
  name: grafana
spec:
  capacity:
    storage: 50Gi
  accessModes:
    - ReadWriteMany
  persistentVolumeReclaimPolicy: Recycle
  nfs:
    server: ${GLUSTER_SHARE}
    path: /gluster/${GUID}/grafana
API

sleep 5

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

sleep 5

oc create -f - <<API
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: grafana-claim
spec:
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 50Gi
API

sleep 5

oc volume dc/prometheus \
          --add --overwrite --name=data-volume \
          --type=persistentVolumeClaim --claim-name=prometheus-claim 2>&1 | tee -a $LOGFILE

