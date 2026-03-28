# 🚀 VM में Quick Start (हिंदी)

## ⚡ सबसे तेज़ तरीका (5 Steps)

### Step 1: Project को VM में Transfer करें

**Option A - Shared Folder (VirtualBox):**
```bash
# VM में:
cp -r /media/sf_blueshield /home/kali/BLUESHIELD-TOOLKIT
cd /home/kali/BLUESHIELD-TOOLKIT
```

**Option B - Zip Transfer:**
```bash
# Windows में zip बनाएं, फिर VM में:
unzip blueshield.zip -d /home/kali/
cd /home/kali/"BLUESHIELD TOOLKIT"
```

### Step 2: Permissions Set करें
```bash
chmod +x install.sh scripts/*.sh attacks/*.sh vm_setup.sh
```

### Step 3: VM Setup Run करें
```bash
sudo ./vm_setup.sh
```
यह script automatically:
- Network interface detect करेगा
- Config files update करेगा
- Firewall configure करेगा

### Step 4: Installation Run करें
```bash
sudo ./install.sh
```
⏱️ 10-15 minutes लगेंगे

### Step 5: Services Start करें
```bash
sudo ./scripts/start_blueshield.sh
./scripts/status_blueshield.sh
./scripts/setup_kibana_index.sh
```

## 🌐 Access करें

```bash
# VM के browser में:
firefox http://localhost:5601  # Kibana
firefox http://localhost:3000  # Grafana (admin/admin)
```

## 🧪 Test करें

```bash
# Attack simulation run करें
sudo ./attacks/simulate_port_scan.sh

# Kibana में logs देखें
```

## ❓ Problem आए तो?

```bash
# Status check करें
./scripts/status_blueshield.sh

# Logs देखें
sudo journalctl -u elasticsearch -n 50
```

---

**Detailed Guide**: `VM_SETUP_GUIDE.md` देखें
**Transfer Guide**: `TRANSFER_TO_VM.md` देखें



