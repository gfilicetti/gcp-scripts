#!/bin/bash
# Create firewall rules for a new VPC to mimic the automatic ones you get with the 
# default network (plus http/s servers)
# References:
# - https://cloud.google.com/vpc/docs/using-firewalls#gcloud
#
# USAGE: fix-firewall-add-default-rules {NETWORK} {IP RANGE for INTERNAL} [PROJECT_ID] 
# EXAMPLE: fix-firewall-add-default-rules mynetwork 10.111.0.0/16 my-project
# if no project is given, the current gcloud project is used
 
# command line params
network=${1:-"default"}
internalrange=${2:-"10.128.0.0/9"}
project=${3:-`gcloud config get-value project`}

# constants
fullrange="0.0.0.0/0"
highpriority="1000"
lowpriority="65534"

# allow all traffic internally (using the address range passed in, 
# these should cover all the subnets in the network)
gcloud compute firewall-rules create $network-allow-internal \
    --network=$network \
    --source-ranges $internalrange \
    --rules=tcp:0-65535,udp:0-65535,icmp \
    --action=ALLOW \
    --priority=$lowpriority \
    --project=$project

# allow ICMP
gcloud compute firewall-rules create $network-allow-icmp \
    --network=$network \
    --source-ranges $fullrange \
    --rules=icmp \
    --action=ALLOW \
    --priority=$lowpriority \
    --project=$project

# allow RDP
gcloud compute firewall-rules create $network-allow-rdp \
    --network=$network \
    --source-ranges $fullrange \
    --rules=tcp:3389 \
    --action=ALLOW \
    --priority=$lowpriority \
    --project=$project

# allow SSH
gcloud compute firewall-rules create $network-allow-ssh \
    --network=$network \
    --source-ranges $fullrange \
    --rules=tcp:22 \
    --action=ALLOW \
    --priority=$lowpriority \
    --project=$project

# allow HTTP
gcloud compute firewall-rules create $network-allow-http \
    --network=$network \
    --target-tags http-server \
    --source-ranges $fullrange \
    --rules=tcp:80 \
    --action=ALLOW \
    --priority=$highpriority \
    --project=$project

# allow HTTPS
gcloud compute firewall-rules create $network-allow-https \
    --network=$network \
    --target-tags https-server \
    --source-ranges $fullrange \
    --rules=tcp:443 \
    --action=ALLOW \
    --priority=$highpriority \
    --project=$project

