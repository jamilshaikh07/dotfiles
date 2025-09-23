#!/usr/bin/env bash
# tsh status → ENV + remaining validity only

command -v tsh >/dev/null 2>&1 || exit 0

status="$(tsh status 2>/dev/null)" || exit 0
[ -z "$status" ] && exit 0

# Extract cluster
cluster="$(printf '%s\n' "$status" | sed -n 's/.*Cluster:[[:space:]]*\(.*\)$/\1/p' | head -n1)"
if [ -z "$cluster" ]; then
  cluster="$(printf '%s\n' "$status" \
            | sed -n 's/.*\(Proxy\|Profile URL\):[[:space:]]*\(https\?:\/\/\)\?\(.*\)$/\3/p' \
            | sed -E 's#^https?://##; s#:/?##g' \
            | head -n1)"
fi

# Extract only the "valid for ..." part
valid_for="$(printf '%s\n' "$status" \
             | sed -n 's/.*Valid until.*\[\(valid for .*\)\]/\1/p' \
             | head -n1)"

# Map cluster → ENV
case "$cluster" in
  *teleport.dev.cloudservices.acquia.io*)       env="DEV-QA" ;;
  *us-east-1.teleport.cloudservices.acquia.io*) env="STG-PROD" ;;
  *)                                            env="$cluster" ;;
esac

[ -z "$env" ] && exit 0

# Output for i3blocks
if [ -n "$valid_for" ]; then
  echo "$env ($valid_for)"
  echo "$env"
else
  echo "$env"
  echo "$env"
fi

