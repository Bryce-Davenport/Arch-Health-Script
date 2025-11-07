#!/bin/bash     

echo "Arch Health Script ~v0.0.1"

echo "-----------[Updating]-----------"         
sudo pacman -Syu
echo "" 

echo "-----------[Testing DNS Latency]-----------"  
# Try to get the primary DNS from resolv.conf
DNS_SERVER=$(grep -m1 '^nameserver' /etc/resolv.conf | awk '{print $2}')

if [[ -n "$DNS_SERVER" ]]; then
    echo "Primary DNS: [$DNS_SERVER]"
    ping -c 4 "$DNS_SERVER"
else
    echo "No DNS server found in /etc/resolv.conf"
fi
echo "" 

echo "-----------[Available Storage]-----------"
echo "source          size  used  avail  %  target"
df -h --output=source,size,used,avail,pcent,target | grep -E '^/dev'
echo "" 

echo "-----------[System Uptime]-----------" 
echo "" 
echo -n "Readable format: "
uptime -p    # prints "up 2 hours, 5 minutes"

echo -n "Detailed load info: "
uptime       # prints full uptime, load averages, and users
echo "" 

echo "-----------[Security]-----------" 
echo "" 
echo "UFW Status:"
sudo ufw status
echo "" 
sudo ss -tulnp
echo "" 

echo "-----------[Networking Info]-----------" 
echo ""
echo "IP"
ip -br addr show
