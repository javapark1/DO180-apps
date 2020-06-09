#!/usr/bin/env bash

# Prepares local storage to be mounted in the pod and runs the nexus container
sudo mkdir /var/local/nexus
sudo chown -R 1001:1001 /var/local/nexus
sudo semanage fcontext -a -t container_file_t '/var/local/nexus(/.*)?'
sudo restorecon -Rv /var/local/nexus
sudo podman run --name nexus -d -v /var/local/nexus:/opt/nexus/sonatype-work nexus
