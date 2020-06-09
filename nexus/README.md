## Introduction

This directory contains `Dockerfile` for building and testing a Nexus image on your local machine using `podman`. Upon completion of the steps in the [Instructions](#Instructions) section, you can deploy the Nexus image on OpenShift by following the instructions in the [nexus-openshift](/nexus-openshif) directory.

## Instructions

1. Download `nexus-2.14.3-02-bundle.tar.gz` from the Nexus download site:

[https://help.sonatype.com/repomanager2/download/download-archives---repository-manager-oss](https://help.sonatype.com/repomanager2/download/download-archives---repository-manager-oss)

Place `nexus-2.14.3-02-bundle.tar.gz` in this directory where `Dockerfile` is located.

2. Build:

```
sudo podman build -t nexus .
```

3. run_persistent.sh:

```
#!/usr/bin/env bash
sudo mkdir /var/local/nexus
sudo chown -R 1001:1001 /var/local/nexus
sudo semanage fcontext -a -t container_file_t '/var/local/nexus(/.*)?'
sudo restorecon -Rv /var/local/nexus
sudo podman run --name nexus -d -v /var/local/nexus:/opt/nexus/sonatype-work nexus
```

4. Verify:

```
sudo podman run --name nexus -d -v /var/local/nexus:/opt/nexus/sonatype-work nexus
sudo podman ps
sudo podman logs -f nexus
sudo podman ps
sudo podman ps --format="table {{.ID}} {{.Names}} {{.Image}}"
sudo podman logs -f nexus
sudo podman inspect -f '{{.NetworkSettings.IPAddress}}' nexus
curl -v 10.88.0.46:8081/nexus/
```

5. Push nexus image to quay.io

```
sudo podman login -u padogrid quay.io
sudo podman push localhost/nexus:latest quay.io/padogrid/nexus:latest
```

5.1. Push nexus image to docker.io

```
sudo podman login -u padogrid quay.io
sudo podman push localhost/nexus:latest docker.io/padogrid/nexus:latest
```

Go to [nexus-openshift](/nexus-openshift) to deploy Nexus on OpenShift.

