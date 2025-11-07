# Arch Health Script ~v0.0.1

A simple Bash utility that performs quick system maintenance and status checks on Arch Linux or any Arch-based system.

---

## Features

- Updates all packages (`pacman -Syu`)
- Tests DNS latency using the system’s current primary DNS server
- Displays available storage and usage
- Shows system uptime and CPU load
- Checks firewall (UFW) status
- Lists open ports and active network sockets
- Displays current IP address and interface information

---

## Script Source

```bash
#!/bin/bash     

echo "Arch Health Script ~v0.0.1"

echo "-----------[Updating]-----------"         
sudo pacman -Syu
echo "" 

echo "-----------[Testing DNS Latency]-----------"  
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
uptime -p

echo -n "Detailed load info: "
uptime
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
```

---

## Requirements

This script is designed for Arch-based distributions and uses the `pacman` package manager.

| Package | Purpose | Installed by Default |
|----------|----------|----------------------|
| `bash` | Runs the script | Yes |
| `sudo` | Required for privileged commands | Yes |
| `pacman` | Package management | Yes |
| `grep`, `awk`, `df`, `uptime` | Core utilities | Yes |
| `iputils` | Provides `ping` | Install if missing |
| `iproute2` | Provides `ss` and `ip` commands | Yes |
| `ufw` | Manages firewall | Optional but recommended |

### Install all dependencies:
```bash
sudo pacman -S --needed ufw iputils iproute2
```

---

## Installation and Usage

1. Clone or download this repository:
   ```bash
   git clone https://github.com/<your-username>/arch-health-script.git
   cd arch-health-script
   ```

2. Make the script executable:
   ```bash
   chmod +x maintain.sh
   ```

3. Run it:
   ```bash
   ./maintain.sh
   ```

The script can be run from any directory; it does not depend on relative paths.

---

## Example Output

```
Arch Health Script ~v0.0.1

-----------[Updating]-----------
:: Synchronizing package databases...
:: Starting full system upgrade...

-----------[Testing DNS Latency]-----------
Primary DNS: [1.1.1.1]
PING 1.1.1.1 (1.1.1.1) 56(84) bytes of data.
64 bytes from 1.1.1.1: icmp_seq=1 ttl=58 time=14.3 ms
64 bytes from 1.1.1.1: icmp_seq=2 ttl=58 time=14.5 ms
--- 1.1.1.1 ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1001ms

-----------[Available Storage]-----------
source          size  used  avail  %  target
/dev/nvme0n1p2  500G   45G   455G   9%  /
/dev/nvme0n1p1  512M   80M   432M  16%  /boot

-----------[System Uptime]-----------
Readable format: up 1 hour, 22 minutes
Detailed load info: 18:42:13 up  1:22,  2 users,  load average: 0.12, 0.08, 0.06

-----------[Security]-----------
UFW Status:
Status: active

Netid State  Recv-Q Send-Q Local Address:Port Peer Address:Port Process
tcp   LISTEN 0      128    0.0.0.0:22       0.0.0.0:*        users:(("sshd",pid=650,fd=3))
udp   UNCONN 0      0      0.0.0.0:68       0.0.0.0:*        users:(("dhclient",pid=512,fd=6))

-----------[Networking Info]-----------
lo        UNKNOWN  127.0.0.1/8 ::1/128
enp3s0    UP        10.0.0.105/24 fe80::b2a4:56ff:fe23:781b/64
```

---

## Notes

- If UFW is not installed, the script will print an error. You can comment out that line if you do not use UFW.
- The script does not make permanent system changes other than updating packages.
- Ideal for quick system health checks before and after updates or reboots.

---

**Author:** Bryce Davenport  
**License:** MIT  
**Version:** 0.0.1  
**Last Updated:** November 2025
