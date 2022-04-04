# Random Scripts for Google Cloud
This repo contains various scripts I've written to make life easier in Google Cloud

## `argolis-enable-apis.sh`
This is a shortcut script that will enable the most used APIs for the given project.
### Parameters
1. `project-name`: Specify a project name. Default: Current project context.

## `argolis-fix-policy-defaults.sh`
This is a shortcut script that will change restrictive organization policies back to the Google defaults.
### Parameters
1. `project-name`: Specify a project name. Default: Current project context.

## `network-add-default-fw-rules.sh`
This script will add the standard firewall rules to the specified VPC network. Including:
- Open all ports for internal traffic
- ICMP
- Remote Desktop (3389)
- SSH (22)
- HTTP (80)
- HTTPS (443)
### Parameters
1. `network`: The VPC to use. Default: `default`
1. `internal-range`: The is the internal address range. Default: `10.128.0.0/9`
1. `project-name`: Specify a project name. Default: Current project context.

