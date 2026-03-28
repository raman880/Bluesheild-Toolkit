# Windows से VM में Project Transfer करने के तरीके

## 🚀 Method 1: Shared Folder (सबसे आसान)

### VirtualBox में:
1. VM को shutdown करें
2. VM Settings → Shared Folders
3. "Add Shared Folder" click करें
4. Folder path: `C:\Users\DELL\BLUESHIELD TOOLKIT`
5. Folder name: `blueshield`
6. "Auto-mount" और "Make Permanent" check करें
7. VM start करें

### VM में:
```bash
# Shared folder mount check करें
ls /media/sf_blueshield/

# Project को home directory में copy करें
cp -r /media/sf_blueshield /home/kali/BLUESHIELD-TOOLKIT
cd /home/kali/BLUESHIELD-TOOLKIT

# Permissions set करें
chmod +x install.sh scripts/*.sh attacks/*.sh
```

## 📦 Method 2: Zip + USB/Network Transfer

### Windows में:
```powershell
# PowerShell में project folder को zip करें
Compress-Archive -Path "C:\Users\DELL\BLUESHIELD TOOLKIT" -DestinationPath "C:\Users\DELL\blueshield.zip"
```

### Transfer करें:
- **USB**: Zip file को USB में copy करें, VM में mount करें
- **Network**: SCP या WinSCP use करें
- **Email/Cloud**: Upload करें, VM में download करें

### VM में:
```bash
# Zip file extract करें
unzip blueshield.zip -d /home/kali/
cd /home/kali/"BLUESHIELD TOOLKIT"

# Permissions set करें
chmod +x install.sh scripts/*.sh attacks/*.sh
```

## 🌐 Method 3: SCP (Network Transfer)

### Windows PowerShell में:
```powershell
# VM का IP address पता करें (VM में: hostname -I)

# SCP से transfer करें
scp -r "C:\Users\DELL\BLUESHIELD TOOLKIT" kali@<vm-ip>:/home/kali/

# Example:
# scp -r "C:\Users\DELL\BLUESHIELD TOOLKIT" kali@192.168.1.100:/home/kali/
```

### WinSCP Use करें (GUI Tool):
1. WinSCP download करें: https://winscp.net/
2. VM से connect करें (SSH)
3. Drag & drop से project folder transfer करें

## 📋 Method 4: Git (अगर Repository है)

### VM में:
```bash
cd /home/kali
git clone <repository-url>
cd "BLUESHIELD TOOLKIT"
chmod +x install.sh scripts/*.sh attacks/*.sh
```

## ✅ Transfer के बाद Steps

```bash
# 1. VM setup script run करें
sudo ./vm_setup.sh

# 2. Installation run करें
sudo ./install.sh

# 3. Services start करें
sudo ./scripts/start_blueshield.sh

# 4. Status check करें
./scripts/status_blueshield.sh
```

## 🔍 Verification

Transfer successful है या नहीं check करें:

```bash
# Files check करें
ls -la
ls -la scripts/
ls -la attacks/
ls -la configs/

# Scripts executable हैं या नहीं
file install.sh
file scripts/start_blueshield.sh
```

---

**Note**: अगर file names में spaces हैं, तो quotes use करें:
```bash
cd "/home/kali/BLUESHIELD TOOLKIT"
```



