
#!/bin/bash
wi="$(ifconfig | grep "wlan" | awk -F: '{print $1}')"
echo "$wi" > /root/scripts/DisablelModeMoni.txt
/usr/bin/sed -i '/wla/s/^/airmon-ng stop /' /root/scripts/DisablelModeMoni.txt
/usr/bin/bash /root/scripts/DisablelModeMoni.txt
