#! /bin/sh

/usr/sbin/sshd
# /usr/bin/shellinaboxd -t -s /:LOGIN  &
[ -n "$PORT" ] && /usr/bin/shellinaboxd -p $PORT -t -s /:LOGIN || /usr/bin/shellinaboxd -t -s /:LOGIN  
echo started 
