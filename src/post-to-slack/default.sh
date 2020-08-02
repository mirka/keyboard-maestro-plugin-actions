#!/bin/bash

if [ "$KMPARAM_Icon_Type" = "Emoji" ]; then
	ICON_TYPE="icon_emoji"
else
	ICON_TYPE="icon_url"
fi

function escape_for_json(){
  echo -n "$1" | python -c 'import json,sys; print json.dumps(sys.stdin.read())'
}

USERNAME=$(escape_for_json "$KMPARAM_Username")
MESSAGE=$(escape_for_json "$KMPARAM_Message")
PAYLOAD="payload={\"channel\": \"$KMPARAM_Channel_or_DM\", \"username\": ""$USERNAME"", \"text\": ""$MESSAGE"", \"$ICON_TYPE\": \"$KMPARAM_Icon\"}" 

curl -X POST --data-urlencode "$PAYLOAD" $KMPARAM_Webhook_URL
