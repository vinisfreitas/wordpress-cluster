#!/bin/bash

docker build -t haproxy-wordpress:0.1 .
#Add tag to rename Docker image
docker stack deploy -c wordpress_cluster.yml wp_cluster
