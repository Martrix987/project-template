#!/usr/bin/env bash
# Sends a Telegram message while an AFK run is active (flag file .claude/afk.active).
# Called by the afk skill with a text argument, or by a Notification hook with JSON on stdin.
# Usage: telegram-notify.sh "text" | telegram-notify.sh --test | (hook) telegram-notify.sh

set -u

readonly TIMEOUT_SECONDS=10

scriptDir="$(cd "$(dirname "$0")" && pwd)"
projectDir="$(cd "$scriptDir/../.." && pwd)"
flagFile="$projectDir/.claude/afk.active"
projectName="$(basename "$projectDir")"

isTest=false
if [ "${1:-}" = "--test" ]; then
    isTest=true
    shift
fi

# Outside an AFK run the hook stays silent, so normal sessions never send messages.
if [ "$isTest" = false ] && [ ! -f "$flagFile" ]; then
    exit 0
fi

if [ -z "${TELEGRAM_BOT_TOKEN:-}" ] || [ -z "${TELEGRAM_CHAT_ID:-}" ]; then
    echo "telegram-notify: TELEGRAM_BOT_TOKEN or TELEGRAM_CHAT_ID is not set" >&2
    exit 1
fi

# Reads one string field from the hook JSON without needing jq.
readJsonField() {
    local fieldName="$1"
    local json="$2"
    printf '%s' "$json" \
        | sed -n "s/.*\"$fieldName\"[[:space:]]*:[[:space:]]*\"\([^\"]*\)\".*/\1/p" \
        | head -n 1
}

if [ "$isTest" = true ]; then
    text="✅ Test message: notifications work"
elif [ $# -gt 0 ]; then
    text="$*"
else
    hookInput="$(cat)"
    notificationType="$(readJsonField "notification_type" "$hookInput")"
    hookMessage="$(readJsonField "message" "$hookInput")"
    case "$notificationType" in
        permission_prompt) text="⏸ Waiting for your approval: ${hookMessage:-permission needed}" ;;
        idle_prompt)       text="💤 Stopped and waiting for you" ;;
        *)                 text="🔔 ${hookMessage:-Needs your attention}" ;;
    esac
fi

if ! curl -s -m "$TIMEOUT_SECONDS" -X POST \
    "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage" \
    --data-urlencode "chat_id=${TELEGRAM_CHAT_ID}" \
    --data-urlencode "text=[$projectName] $text" > /dev/null; then
    echo "telegram-notify: sending failed" >&2
    exit 1
fi
