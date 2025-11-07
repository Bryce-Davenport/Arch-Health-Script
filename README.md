# Arch Health Check Script

This Bash script performs a quick system health check on **Arch Linux** or any **Arch-based** distribution.

It includes:
- System update check
- DNS latency test
- Disk usage summary
- System uptime
- Basic security checks (UFW + open ports)

---

## Requirements

This script is intended for **Arch-based systems** and uses `pacman` for package management.

### Dependencies
| Package | Purpose | Default on Arch |
|----------|----------|-----------------|
| `bash` | Runs the script 
| `sudo` | Elevates privileges for commands 
| `pacman` | Package manager 
| `grep`, `awk`, `df`, `uptime` | System utilities
| `iputils` | Provides `ping` command |
| `iproute2` | Provides `ss` command | 
| `ufw` | Firewall management

To ensure all needed tools are available, run:
```bash
sudo pacman -S --needed ufw iputils iproute2
```

---

## Installation & Usage

1. **Download or clone** this repository:
   ```bash
   git clone https://github.com/<your-username>/arch-health-check.git
   cd arch-health-check
   ```

2. **Make the script executable:**
   ```bash
   chmod +x arch-health.sh
   ```

3. **Run it:**
   ```bash
   ./arch-health.sh
   ```

   The script can be run from **any directory** — it does not depend on its location.

## Notes
- UFW status will fail if `ufw` is not installed — you can comment that line out.
- No permanent changes are made to your system besides `pacman -Syu` updates.
- You can safely run this script periodically as a maintenance tool.

---

**Author:** AlpineDev 
**License:** MIT 
