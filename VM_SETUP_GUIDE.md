# BlueShield Toolkit - VM Setup Guide (हिंदी/English)

## 🖥️ Virtual Machine में Setup करने के लिए Guide

### 📋 Prerequisites (आवश्यकताएं)

#### VM Requirements:
- **OS**: Kali Linux 2023.x या Ubuntu 22.04 LTS
- **RAM**: Minimum 4GB (8GB recommended)
- **Disk Space**: Minimum 30GB free space
- **CPU**: 2+ cores recommended
- **Network**: NAT या Bridged adapter

### 🚀 Step-by-Step Setup

#### Step 1: VM तैयार करें

1. **VirtualBox या VMware में Kali Linux install करें**
   ```bash
   # Kali Linux download करें:
   # https://www.kali.org/get-kali/
   ```

2. **VM Settings:**
   - RAM: 4GB minimum (8GB better)
   - Hard Disk: 30GB+ dynamic
   - Network: NAT (default) या Bridged
   - Enable Virtualization: VT-x/AMD-V

#### Step 2: Project को VM में Transfer करें

**Option A: USB/Shared Folder से**
```bash
# USB mount करें या shared folder enable करें
# Project folder को /home/kali/ में copy करें
cp -r "/path/to/BLUESHIELD TOOLKIT" /home/kali/
cd /home/kali/"BLUESHIELD TOOLKIT"
```

**Option B: Git से Clone करें (अगर GitHub पर है)**
```bash
cd /home/kali
git clone <repository-url>
cd "BLUESHIELD TOOLKIT"
```

**Option C: SCP से Transfer करें (Host से VM में)**
```bash
# Host machine से (Windows PowerShell):
scp -r "C:\Users\DELL\BLUESHIELD TOOLKIT" kali@<vm-ip>:/home/kali/

# या WinSCP जैसे tool use करें
```

**Option D: Zip करके Transfer करें**
```bash
# Windows में zip बनाएं, फिर VM में:
# 1. Zip file को USB/shared folder से copy करें
# 2. VM में extract करें:
unzip "BLUESHIELD TOOLKIT.zip" -d /home/kali/
cd /home/kali/"BLUESHIELD TOOLKIT"
```

#### Step 3: Permissions Set करें

```bash
# Scripts को executable बनाएं
chmod +x install.sh
chmod +x scripts/*.sh
chmod +x attacks/*.sh

# Verify करें
ls -la install.sh
ls -la scripts/
ls -la attacks/
```

#### Step 4: System Update करें

```bash
# Kali Linux में
sudo apt update
sudo apt upgrade -y

# Network interface check करें
ip addr show
# या
ifconfig
```

#### Step 5: Installation Run करें

```bash
# Root access के साथ install script run करें
sudo ./install.sh
```

**Installation में 10-15 minutes लग सकते हैं**

#### Step 6: Services Start करें

```bash
# सभी services start करें
sudo ./scripts/start_blueshield.sh

# Status check करें
./scripts/status_blueshield.sh
```

#### Step 7: Kibana Setup करें

```bash
# Kibana index pattern setup करें
./scripts/setup_kibana_index.sh
```

#### Step 8: Access करें

**VM के अंदर से:**
```bash
# Browser में खोलें
firefox http://localhost:5601  # Kibana
firefox http://localhost:3000  # Grafana
```

**Host Machine से (अगर Bridged Network है):**
- VM का IP address पता करें:
  ```bash
  ip addr show | grep inet
  # या
  hostname -I
  ```
- Host browser में:
  - Kibana: `http://<vm-ip>:5601`
  - Grafana: `http://<vm-ip>:3000`

**अगर NAT Network है:**
- Port forwarding setup करें (VirtualBox/VMware में)
- या VM के अंदर ही browser use करें

### 🔧 VM-Specific Configuration

#### Network Interface Setup

**Zeek और Suricata के लिए network interface configure करें:**

```bash
# Network interface पता करें
ip link show

# Zeek config में interface update करें
sudo nano configs/zeek/node.cfg
# interface=eth0 को अपने interface से replace करें
# (जैसे: interface=enp0s3, interface=ens33, etc.)

# Suricata config में भी update करें
sudo nano configs/suricata/suricata.yaml
# interface: eth0 को अपने interface से replace करें
```

#### Firewall Setup (अगर enable है)

```bash
# UFW disable करें (development के लिए)
sudo ufw disable

# या specific ports allow करें:
sudo ufw allow 5601/tcp  # Kibana
sudo ufw allow 3000/tcp  # Grafana
sudo ufw allow 9200/tcp  # Elasticsearch
```

#### Memory Settings

**Elasticsearch के लिए memory limit:**
```bash
# /etc/elasticsearch/jvm.options edit करें
sudo nano /etc/elasticsearch/jvm.options

# Memory settings (VM के RAM के अनुसार):
# -Xms1g
# -Xmx1g
# (4GB RAM के लिए 1g, 8GB के लिए 2g)
```

### 🧪 Testing

```bash
# Attack simulation test करें
sudo ./attacks/simulate_port_scan.sh

# Logs check करें
tail -f /var/log/suricata/fast.log
tail -f /var/log/zeek/current/conn.log

# Elasticsearch indices check करें
curl http://localhost:9200/_cat/indices?v
```

### 🐛 Common VM Issues & Solutions

#### Issue 1: Network Interface Not Found
```bash
# Solution: Interface name check करें
ip addr show
# Config files में correct interface name use करें
```

#### Issue 2: Services Not Starting
```bash
# Logs check करें
sudo journalctl -u elasticsearch -n 50
sudo journalctl -u kibana -n 50

# Memory issue हो सकता है - VM RAM increase करें
```

#### Issue 3: Can't Access from Host
```bash
# VM IP check करें
hostname -I

# Port forwarding setup करें (VirtualBox):
# Settings → Network → Advanced → Port Forwarding
# Add rules:
#   Kibana: Host 5601 → Guest 5601
#   Grafana: Host 3000 → Guest 3000
```

#### Issue 4: Slow Performance
```bash
# VM settings optimize करें:
# - CPU cores increase करें
# - RAM increase करें
# - Enable hardware acceleration
# - Disable unnecessary services
```

### 📝 Quick VM Setup Script

एक quick setup script भी बना सकते हैं:

```bash
#!/bin/bash
# vm_setup.sh

echo "VM Setup Starting..."

# Network interface detect करें
INTERFACE=$(ip route | grep default | awk '{print $5}' | head -1)
echo "Detected interface: $INTERFACE"

# Config files update करें
sed -i "s/interface=eth0/interface=$INTERFACE/g" configs/zeek/node.cfg
sed -i "s/interface: eth0/interface: $INTERFACE/g" configs/suricata/suricata.yaml

# Firewall disable करें
sudo ufw disable

# Install run करें
sudo ./install.sh

echo "VM Setup Complete!"
```

### ✅ Verification Checklist

- [ ] VM में Kali Linux installed है
- [ ] Project files transfer हो गए हैं
- [ ] Scripts executable हैं
- [ ] Network interface पता है
- [ ] Installation successful है
- [ ] Services running हैं
- [ ] Kibana accessible है
- [ ] Grafana accessible है
- [ ] Attack simulations काम कर रहे हैं

### 🎯 Next Steps

1. **Kibana में logs explore करें**
2. **Attack simulations run करें**
3. **Dashboards customize करें**
4. **Detection rules modify करें**
5. **Training scenarios practice करें**

---

## 📞 Help

अगर कोई problem आए:
1. Logs check करें: `./scripts/status_blueshield.sh`
2. Service logs देखें: `sudo journalctl -u <service-name> -f`
3. README.md में troubleshooting section देखें

**Happy Learning! 🛡️**



