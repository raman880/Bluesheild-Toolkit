#!/bin/bash

###############################################################################
# BlueShield Toolkit - VM Quick Setup Script
# यह script VM में automatic setup के लिए है
###############################################################################

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}BlueShield Toolkit - VM Setup${NC}"
echo -e "${GREEN}========================================${NC}"

# Check if running as root
if [ "$EUID" -ne 0 ]; then 
    echo -e "${RED}Please run as root (use sudo)${NC}"
    exit 1
fi

# Detect network interface
echo -e "${YELLOW}[*] Detecting network interface...${NC}"
INTERFACE=$(ip route | grep default | awk '{print $5}' | head -1)

if [ -z "$INTERFACE" ]; then
    # Fallback: first non-lo interface
    INTERFACE=$(ip link show | grep -v lo | grep -oP '(?<=^\d+: )\w+' | head -1)
fi

if [ -z "$INTERFACE" ]; then
    echo -e "${RED}[-] Could not detect network interface${NC}"
    echo -e "${YELLOW}[!] Please manually configure network interface in config files${NC}"
    INTERFACE="eth0"
else
    echo -e "${GREEN}[+] Detected interface: ${INTERFACE}${NC}"
fi

# Update Zeek configuration
if [ -f "configs/zeek/node.cfg" ]; then
    echo -e "${YELLOW}[*] Updating Zeek configuration...${NC}"
    sed -i "s/interface=eth0/interface=${INTERFACE}/g" configs/zeek/node.cfg
    sed -i "s/interface=enp0s3/interface=${INTERFACE}/g" configs/zeek/node.cfg
    sed -i "s/interface=ens33/interface=${INTERFACE}/g" configs/zeek/node.cfg
    echo -e "${GREEN}[+] Zeek configuration updated${NC}"
fi

# Update Suricata configuration
if [ -f "configs/suricata/suricata.yaml" ]; then
    echo -e "${YELLOW}[*] Updating Suricata configuration...${NC}"
    sed -i "s/interface: eth0/interface: ${INTERFACE}/g" configs/suricata/suricata.yaml
    sed -i "s/interface: enp0s3/interface: ${INTERFACE}/g" configs/suricata/suricata.yaml
    sed -i "s/interface: ens33/interface: ${INTERFACE}/g" configs/suricata/suricata.yaml
    echo -e "${GREEN}[+] Suricata configuration updated${NC}"
fi

# Disable firewall (for development)
echo -e "${YELLOW}[*] Configuring firewall...${NC}"
if command -v ufw &> /dev/null; then
    ufw --force disable 2>/dev/null || true
    echo -e "${GREEN}[+] Firewall disabled${NC}"
fi

# Make scripts executable
echo -e "${YELLOW}[*] Setting script permissions...${NC}"
chmod +x install.sh 2>/dev/null || true
chmod +x scripts/*.sh 2>/dev/null || true
chmod +x attacks/*.sh 2>/dev/null || true
echo -e "${GREEN}[+] Permissions set${NC}"

# Display VM information
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}VM Information:${NC}"
echo -e "${GREEN}========================================${NC}"
echo -e "Network Interface: ${INTERFACE}"
echo -e "IP Address: $(hostname -I | awk '{print $1}')"
echo -e "Hostname: $(hostname)"
echo -e "OS: $(lsb_release -d 2>/dev/null | cut -f2 || uname -a)"
echo -e "RAM: $(free -h | grep Mem | awk '{print $2}')"
echo -e "Disk: $(df -h / | tail -1 | awk '{print $4}') available"
echo -e "${GREEN}========================================${NC}"

echo -e "${YELLOW}Next steps:${NC}"
echo -e "1. Run installation: ${GREEN}sudo ./install.sh${NC}"
echo -e "2. Start services: ${GREEN}sudo ./scripts/start_blueshield.sh${NC}"
echo -e "3. Check status: ${GREEN}./scripts/status_blueshield.sh${NC}"
echo -e "4. Setup Kibana: ${GREEN}./scripts/setup_kibana_index.sh${NC}"
echo -e ""
echo -e "${GREEN}Access URLs:${NC}"
echo -e "  Kibana:  http://localhost:5601"
echo -e "  Grafana: http://localhost:3000"
echo -e "  From host: http://$(hostname -I | awk '{print $1}'):5601"
echo -e "${GREEN}========================================${NC}"



