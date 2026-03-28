# 🖥️ VM में Project चलाने के Commands

## 📋 Step-by-Step Commands (Copy-Paste करें)

### Step 1: Project Folder में जाएं
```bash
cd "/home/kali/BLUESHIELD TOOLKIT"
```
या अगर folder name अलग है:
```bash
cd ~/BLUESHIELD-TOOLKIT
# या
cd ~/blueshield
```

### Step 2: Permissions Set करें
```bash
chmod +x install.sh
chmod +x vm_setup.sh
chmod +x scripts/*.sh
chmod +x attacks/*.sh
```

### Step 3: VM Setup Run करें (Network Interface Auto-Detect)
```bash
sudo ./vm_setup.sh
```

### Step 4: Installation Run करें
```bash
sudo ./install.sh
```
⏱️ **यह 10-15 minutes लगेगा, wait करें**

### Step 5: Services Start करें
```bash
sudo ./scripts/start_blueshield.sh
```

### Step 6: Status Check करें
```bash
./scripts/status_blueshield.sh
```

### Step 7: Kibana Setup करें
```bash
./scripts/setup_kibana_index.sh
```

### Step 8: Browser में खोलें
```bash
firefox http://localhost:5601
```
या
```bash
firefox http://localhost:3000
```

---

## 🔄 Daily Use Commands

### Services Start करने के लिए:
```bash
sudo ./scripts/start_blueshield.sh
```

### Services Stop करने के लिए:
```bash
sudo ./scripts/stop_blueshield.sh
```

### Status Check करने के लिए:
```bash
./scripts/status_blueshield.sh
```

### Attack Simulation Run करने के लिए:
```bash
# Port scan
sudo ./attacks/simulate_port_scan.sh

# SQL injection
sudo ./attacks/simulate_sql_injection.sh http://localhost:8080 /login

# Brute force
sudo ./attacks/simulate_brute_force.sh 127.0.0.1 22 10

# XSS attack
sudo ./attacks/simulate_xss.sh http://localhost:8080 /search
```

---

## 🔍 Useful Check Commands

### Network Interface Check करें:
```bash
ip addr show
# या
ifconfig
```

### VM IP Address पता करें:
```bash
hostname -I
```

### Elasticsearch Check करें:
```bash
curl http://localhost:9200
```

### Elasticsearch Indices देखें:
```bash
curl http://localhost:9200/_cat/indices?v
```

### Services Status (Detailed):
```bash
systemctl status elasticsearch
systemctl status kibana
systemctl status filebeat
systemctl status grafana-server
systemctl status suricata
systemctl status osqueryd
```

### Logs देखने के लिए:
```bash
# Suricata alerts
tail -f /var/log/suricata/fast.log

# Zeek logs
tail -f /var/log/zeek/current/conn.log

# System logs
sudo journalctl -u elasticsearch -f
sudo journalctl -u kibana -f
sudo journalctl -u filebeat -f
```

---

## 🐛 Problem Fix Commands

### अगर Service Start नहीं हो रहा:
```bash
# Service restart करें
sudo systemctl restart elasticsearch
sudo systemctl restart kibana
sudo systemctl restart filebeat
```

### अगर Network Interface गलत है:
```bash
# Interface पता करें
ip link show

# Zeek config edit करें
sudo nano configs/zeek/node.cfg
# interface=eth0 को अपने interface से replace करें

# Suricata config edit करें
sudo nano configs/suricata/suricata.yaml
# interface: eth0 को अपने interface से replace करें
```

### अगर Firewall Block कर रहा है:
```bash
# Firewall disable करें
sudo ufw disable

# या specific ports allow करें
sudo ufw allow 5601/tcp
sudo ufw allow 3000/tcp
sudo ufw allow 9200/tcp
```

### अगर Memory Issue है:
```bash
# Free memory check करें
free -h

# Elasticsearch memory limit edit करें
sudo nano /etc/elasticsearch/jvm.options
# -Xms1g और -Xmx1g को अपने RAM के अनुसार set करें
```

---

## 📝 Complete Setup (एक बार में सभी Commands)

```bash
# 1. Project folder में जाएं
cd "/home/kali/BLUESHIELD TOOLKIT"

# 2. Permissions set करें
chmod +x install.sh vm_setup.sh scripts/*.sh attacks/*.sh

# 3. VM setup
sudo ./vm_setup.sh

# 4. Installation
sudo ./install.sh

# 5. Services start
sudo ./scripts/start_blueshield.sh

# 6. Status check
./scripts/status_blueshield.sh

# 7. Kibana setup
./scripts/setup_kibana_index.sh

# 8. Browser open
firefox http://localhost:5601
```

---

## ✅ Verification Commands

### सब कुछ ठीक है या नहीं check करें:
```bash
# 1. Services running हैं?
./scripts/status_blueshield.sh

# 2. Elasticsearch working है?
curl http://localhost:9200/_cluster/health

# 3. Kibana accessible है?
curl http://localhost:5601/api/status

# 4. Logs आ रहे हैं?
curl http://localhost:9200/_cat/indices?v
```

---

## 🎯 Quick Reference

| Task | Command |
|------|---------|
| Start all services | `sudo ./scripts/start_blueshield.sh` |
| Stop all services | `sudo ./scripts/stop_blueshield.sh` |
| Check status | `./scripts/status_blueshield.sh` |
| View Suricata alerts | `tail -f /var/log/suricata/fast.log` |
| View Zeek logs | `tail -f /var/log/zeek/current/conn.log` |
| Check Elasticsearch | `curl http://localhost:9200` |
| Open Kibana | `firefox http://localhost:5601` |
| Open Grafana | `firefox http://localhost:3000` |

---

**Note**: सभी commands VM के terminal में run करें, Windows PowerShell में नहीं!



