## Prerequisite

Before you follow instructions in this page, you must first build and push the Nexus image to your registry as described in the following directory:

[nexus](/nexus)


## Instructions

1. Star nexus on OpenShift

```
# Login to OpenShift cluster
oc login ...

# Start nexus using the provided template
oc process -f nexus-persistent.yaml -o yaml | oc create -f -

# Expose a deployment configuration as a service and use the specified port
oc expose dc nexus --port=8081

# Create a route for the dc service
oc expose svc/nexus
```

2.1. Check storage

```
oc apply -f nexus-storage-pod.yaml
oc exec -it nexus-storage-pod  /bin/bash
```

3. Tear down

```
oc delete dc nexus
oc delete svc nexus
oc delete route nexus
oc delete pod nexus-storage-pod
oc delete pvc nexus-pvc
```
