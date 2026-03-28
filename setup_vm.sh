#!/bin/bash
# Complete VM Setup Script - सभी commands एक साथ

echo "=========================================="
echo "BlueShield Toolkit - Complete VM Setup"
echo "=========================================="

# Step 1: Permissions
echo "[1/7] Setting permissions..."
chmod +x install.sh vm_setup.sh scripts/*.sh attacks/*.sh 2>/dev/null

# Step 2: VM Setup
echo "[2/7] Running VM setup..."
sudo ./vm_setup.sh

# Step 3: Installation
echo "[3/7] Installing BlueShield Toolkit..."
echo "This will take 10-15 minutes..."
sudo ./install.sh

# Step 4: Start Services
echo "[4/7] Starting services..."
sudo ./scripts/start_blueshield.sh

# Wait a bit
sleep 10

# Step 5: Status Check
echo "[5/7] Checking service status..."
./scripts/status_blueshield.sh

# Step 6: Kibana Setup
echo "[6/7] Setting up Kibana..."
./scripts/setup_kibana_index.sh

# Step 7: Final Info
echo "[7/7] Setup Complete!"
echo ""
echo "=========================================="
echo "Access URLs:"
echo "  Kibana:  http://localhost:5601"
echo "  Grafana: http://localhost:3000 (admin/admin)"
echo "  Elasticsearch: http://localhost:9200"
echo ""
echo "VM IP: $(hostname -I | awk '{print $1}')"
echo "From host: http://$(hostname -I | awk '{print $1}'):5601"
echo "=========================================="



