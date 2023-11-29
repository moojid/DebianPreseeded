#!/bin/bash
result=$(TELEPORT_CONFIG_FILE="" tctl tokens add --type=node --ttl=4h   -i /opt/machine-id/identity --auth-server tp.cellshop.us:443 2> /dev/null  | awk '/token:/{print $4}')
echo "sudo bash -c \"\$(curl -fsSL https://tp.cellshop.us/scripts/${result}/install-node.sh)\""
