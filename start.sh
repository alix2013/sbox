#! /bin/sh

/usr/sbin/sshd


if [ -n "$CF_TOKEN" ]; then
    echo "CF is set: $CF_TOKEN"
    su - web -c "nohup cloudflared tunnel run --token $CF_TOKEN >> /tmp/cf.log 2>&1 &"
else
    # CF is not set or empty
    echo "CF is not set"
    su - web -c "nohup cloudflared --url ssh://localhost:2222 >> /tmp/cf.log 2>&1 &"
fi

 
# /usr/bin/shellinaboxd -t -s /:LOGIN  &
if [ -n "$PORT" ]; then
    /usr/bin/shellinaboxd -p $PORT -t -s /:LOGIN &
else
   /usr/bin/shellinaboxd -t -s /:LOGIN &
fi
#[ -n "$PORT" ] && /usr/bin/shellinaboxd -p $PORT -t -s /:LOGIN & || /usr/bin/shellinaboxd -t -s /:LOGIN &  
echo started 
sleep 5
cat /tmp/cf.log
/usr/bin/tail -f /tmp/cf.log

