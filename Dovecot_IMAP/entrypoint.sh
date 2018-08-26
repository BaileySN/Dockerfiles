#!/bin/bash
set -e

if [ ! -e "/etc/provissioned_true" ]; then
    if [[ ! -z "$MYHOSTNAME" ]]; then
        sed -i 's/myhostname = imap.archiv.local/myhostname = '$MYHOSTNAME'/g' /etc/postfix/main.cf
    fi
    
    if [[ ! -z "$MYDOMAIN" ]]; then
        sed -i 's/mydomain = archiv.local/mydomain = '$MYDOMAIN'/g' /etc/postfix/main.cf
    fi
    
    export MYNET=$(/sbin/ip route|awk '/default/ { print $3 }')
    if [[ ! -z "$MYNETWORK" ]]; then
        MNETWORK="127.0.0.0/8, $MYNET, $MYNETWORK"
        echo "mynetworks = 127.0.0.0/8, $MYNET" >> /etc/postfix/main.cf
    else
        MNETWORK="127.0.0.0/8, $MYNET"
        echo "mynetworks = 127.0.0.0/8, $MYNET" >> /etc/postfix/main.cf
    fi
    
    if [[ ! -z "$MESSAGE_SIZE_LIMIT" ]]; then
        sed -i 's/message_size_limit = 10485760/message_size_limit = '$MESSAGE_SIZE_LIMIT'/g' /etc/postfix/main.cf
    fi
    
    if [[ ! -z "$MAILBOX_SIZE_LIMIT" ]]; then
        sed -i 's/mailbox_size_limit = 1073741824/mailbox_size_limit = '$MAILBOX_SIZE_LIMIT'/g' /etc/postfix/main.cf
    fi
    
    if [[ ! -d "$MAILBACK" ]]; then
        mkdir -p $MAILBACK
    else
        if [ -e "$MAILBACK/user.db" ]; then
            echo "restore user.db"
            cat "$MAILBACK/user.db" > /etc/passwd
            cat "$MAILBACK/user.db" > /etc/passwd-
        fi
        
        if [ -e "$MAILBACK/group.db" ]; then
            echo "restore group.db"
            cat "$MAILBACK/group.db" > /etc/group
            cat "$MAILBACK/group.db" > /etc/group-
        fi
        
        if [ -e "$MAILBACK/shadow.db" ]; then
            echo "restore shadow.db"
            cat "$MAILBACK/shadow.db" > /etc/shadow
            cat "$MAILBACK/shadow.db" > /etc/shadow-
        fi
    fi
    
    touch "/etc/provissioned_true"
    
else
    echo "already provisioned"
fi

newaliases

/usr/bin/supervisord -c /etc/supervisor/supervisord.conf
