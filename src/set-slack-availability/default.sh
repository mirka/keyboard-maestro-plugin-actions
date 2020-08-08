#!/bin/bash

value=$(echo "$KMPARAM_Availability" | tr '[:upper:]' '[:lower:]')

curl -s "https://slack.com/api/users.setPresence?token=$KMPARAM_OAuth_token&presence=$value"
