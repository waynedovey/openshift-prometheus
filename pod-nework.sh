# Required if openshift-ovs-multitenant is enabled 
oc adm pod-network make-projects-global prometheus
oc adm pod-network make-projects-global openshift-infra
