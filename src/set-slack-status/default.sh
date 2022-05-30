#!/bin/bash

function escape_for_json(){
  py=$(command -v python3 || command -v python)
  echo -n "$1" | $py -c 'import json,sys; print(json.dumps(sys.stdin.read()))'
}

emoji=$(escape_for_json "$KMPARAM_Status_emoji")
text=$(escape_for_json "$KMPARAM_Status_text")
both_empty=$([[ -z "$KMPARAM_Status_emoji" && -z "$KMPARAM_Status_text" ]]; echo "$?")

# Add params if values exist, or wanting to unset
if [[ ! -z "$KMPARAM_Status_emoji" || $both_empty -eq 0 ]]; then
  emoji_param="\"status_emoji\": $emoji"
  params+=("$emoji_param")
fi
if [[ ! -z "$KMPARAM_Status_text" || $both_empty -eq 0 ]]; then
  text_param="\"status_text\": $text"
  params+=("$text_param")
fi

# Calculate expiration unixtime (if set to more than 0)
if [[ ! -z "$KMPARAM_Clear_after_x_hours" && $(bc -l <<< "$KMPARAM_Clear_after_x_hours > 0") -eq 1 ]]; then
  unix_now=$(date +%s)
  offset=$(bc -l <<< "$KMPARAM_Clear_after_x_hours * 3600")
  integer_offset=$(printf "%.0f" $offset)
  expiry=$(($unix_now + $integer_offset))
else
  expiry=0
fi

expiration_param="\"status_expiration\": $expiry"
params+=("$expiration_param")

# Join params with ',' delimiter
for p in "${params[@]}"; do
  if [[ ! -z "$concated_params" ]]; then
    concated_params+=','
  fi
  concated_params+="$p"
done

payload="{ \"profile\": { $concated_params } }"

curl -s \
-H 'Content-Type: application/json; charset=UTF-8' \
-H "Authorization: Bearer $KMPARAM_OAuth_token" \
-d "$payload" \
https://slack.com/api/users.profile.set
