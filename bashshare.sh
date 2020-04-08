#!/bin/bash
CONFIG_NAME="$HOME/.config/bashshare.conf"
SHARE_ROOT="$(dirname -- "$(readlink -f -- "$0")")"

if [ -f "$CONFIG_NAME" ]; then
    source "$CONFIG_NAME"
    UUID=$(ssh $SERVER "uuid | sha512sum | sed \"s/ .*//\"")
    ssh $SERVER "mkdir -p $SHARE_DIRECTORY/$UUID/"
    scp -pr "$@" $SERVER:$SHARE_DIRECTORY/$UUID/
    ssh $SERVER "echo \"

$SHARE_URL/$UUID/
    
$@
    
\"  | mail -s \"[SHARE] $UUID\" $MAIL"
else
    echo "<<$CONFIG_NAME>> doit contenir la configurtion.
voir : https://github.com/bl0bmaster/bashshare
"
fi
