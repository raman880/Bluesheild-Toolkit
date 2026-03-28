#!/usr/bin/env bash
set -euo pipefail

# Simple, safe BlueShield installer for Kali (non-destructive)
# What it does:
# 1) Restore Kali official sources.list
# 2) apt update & install basic deps (git,wget,curl,python3,docker)
# 3) Install suricata and zeek if available in apt
# 4) Enable docker and docker-compose (via package)
# 5) Put a docker-compose.yml (ELK + Grafana) in current folder (if not exists)
# 6) Print next steps

echo "=== BlueShield SAFE installer ==="

# 1) Restore official Kali source list
echo "[1/6] Restoring official Kali sources.list..."
sudo bash -c 'cat >/etc/apt/sources.list <<EOF
deb http://http.kali.org/kali kali-rolling main contrib non-free non-free-firmware
EOF'
sudo apt clean
sudo rm -rf /var/lib/apt/lists/*

# 2) Update and install basic packages
echo "[2/6] apt update and installing base packages..."
sudo apt update --fix-missing
sudo apt install -y apt-transport-https ca-certificates curl wget gnupg lsb-release \
  build-essential python3 python3-pip git jq

# 3) Install Suricata (Kali usually contains it)
echo "[3/6] Installing Suricata (if available)..."
if apt show suricata >/dev/null 2>&1; then
  sudo apt install -y suricata
  echo "Suricata installed."
else
  echo "Suricata package not found in apt. Skipping."
fi

# 4) Install Zeek (if available)
echo "[4/6] Installing Zeek (if available)..."
if apt show zeek >/dev/null 2>&1; then
  sudo apt install -y zeek
  echo "Zeek installed."
else
  echo "Zeek package not found in apt. Skipping."
fi

# 5) Install Docker & docker-compose
echo "[5/6] Installing docker.io and docker-compose..."
sudo apt install -y docker.io docker-compose
sudo systemctl enable --now docker

# 6) Prepare docker-compose for ELK + Grafana (light demo)
DC_FILE="./docker-compose.yml"
if [ -f "${DC_FILE}" ]; then
  echo "docker-compose.yml already exists in the folder; not overwriting."
else
  echo "[6/6] Creating a docker-compose.yml with a small ELK + Grafana stack..."
  cat > "${DC_FILE}" <<'YAML'
version: '3.7'
services:

  elasticsearch:
    image: docker.elastic.co/elasticsearch/elasticsearch:7.17.13
    environment:
      - discovery.type=single-node
      - xpack.security.enabled=false
      - ES_JAVA_OPTS=-Xms512m -Xmx512m
    ulimits:
      memlock:
        soft: -1
        hard: -1
    volumes:
      - esdata:/usr/share/elasticsearch/data
    ports:
      - "9200:9200"
    networks:
      - blueshield-net

  kibana:
    image: docker.elastic.co/kibana/kibana:7.17.13
    depends_on:
      - elasticsearch
    environment:
      - ELASTICSEARCH_HOSTS=http://elasticsearch:9200
    ports:
      - "5601:5601"
    networks:
      - blueshield-net

  grafana:
    image: grafana/grafana-oss:9.5.2
    ports:
      - "3000:3000"
    networks:
      - blueshield-net
    volumes:
      - grafana_data:/var/lib/grafana

volumes:
  esdata:
  grafana_data:

networks:
  blueshield-net:
YAML
  echo "docker-compose.yml created."
fi

# 7) Make sure scripts are executable
chmod +x ./start_blueshield.sh 2>/dev/null || true
chmod +x ./stop_blueshield.sh 2>/dev/null || true
chmod +x ./status_blueshield.sh 2>/dev/null || true

echo ""
echo "=== Installer finished ==="
echo "Next steps:"
echo "  1) If you want to bring up the ELK+Grafana stack, run: sudo ./start_blueshield.sh"
echo "  2) Suricata/Zeek may be installed if available. Check with: sudo systemctl status suricata  OR  sudo zeekctl status"
echo "  3) If any install failed, paste the full terminal output here and I will fix it."
