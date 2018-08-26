

## Starting Service

```bash
docker run -it -d --name my_mailstorage -v IMAPSTORAGE:/home -p 25:25 -p 110:110 -p 143:143 -p 465:465 -p 567:567 guenterbailey/mailstorage:latest
```

In */home* is stored the Useraccounts and a hidden directory to restore after container upgrade the useraccounts (the hidden directory is only a helper, then this version has no SQL Database (commin soon...)).

### optional Docker run variables

* ```MYHOSTNAME=imap.archiv.local``` => set in postfix main.cf file
* ```MYDOMAIN=archiv.local``` => set in postfix main.cf file
* ```MESSAGE_SIZE_LIMIT=10485760``` => limit postfix message size (currently only as option in postfix, but my focus is only to use as imap Archive and to send E-Mail)
* ```MAILBOX_SIZE_LIMIT=1073741824``` => postfix mailbox size limit (has no effect, use dovecot)


### or use docker-compose to start container

```
version: '3'

services:
  mailstorage:
    restart: always
    image: guenterbailey/mailstorage:latest
    environment:
      - MYHOSTNAME=imap.archiv.local
      - MYDOMAIN=archiv.local
      - MESSAGE_SIZE_LIMIT=10485760
      - MAILBOX_SIZE_LIMIT=1073741824
    networks:
      - mailbackend
    volumes:
      - my_mailstorage:/home
    ports:
      - "25:25"
      - "110:110"
      - "143:143"
      - "465:465"
      - "567:567"

networks:
  mailbackend:

volumes:
  my_mailstorage:
```

## ADD IMAP User

```bash
docker exec -it my_mailstorage bash -lc 'sh /addmailuser.sh "USERNAME" "PASSWORD"'
```

The IMAP user can added with the *addmailuser.sh* scriptd.



## MIT License
this project is licensed under MIT.
