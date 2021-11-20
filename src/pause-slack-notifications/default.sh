#!/bin/bash

if [ "$KMPARAM_Notifications" = "Pause" ]; then
	curl -s "https://slack.com/api/dnd.setSnooze?token=$KMPARAM_OAuth_token&num_minutes=$KMPARAM_Pause_duration_in_minutes"
else
	curl -s "https://slack.com/api/dnd.endSnooze?token=$KMPARAM_OAuth_token"
fi
