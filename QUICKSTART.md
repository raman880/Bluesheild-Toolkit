# BlueShield Toolkit - Quick Start Guide

## 🚀 Getting Started in 5 Minutes

### Step 1: Install the Toolkit

```bash
sudo ./install.sh
```

This will install and configure all required tools. The process may take 10-15 minutes depending on your system.

### Step 2: Start All Services

```bash
sudo ./scripts/start_blueshield.sh
```

Wait for all services to start (about 30 seconds).

### Step 3: Verify Services

```bash
./scripts/status_blueshield.sh
```

All services should show as "RUNNING".

### Step 4: Setup Kibana

```bash
./scripts/setup_kibana_index.sh
```

This creates the index pattern for viewing logs in Kibana.

### Step 5: Access Dashboards

- **Kibana**: Open http://localhost:5601 in your browser
- **Grafana**: Open http://localhost:3000 (login: admin/admin)

### Step 6: Run Your First Attack Simulation

```bash
# Simulate a port scan
sudo ./attacks/simulate_port_scan.sh

# Check alerts in Kibana
# Go to: Discover → Select "blueshield-*" index pattern
```

## 📊 Viewing Logs

### In Kibana:

1. Go to **Discover** (left sidebar)
2. Select index pattern: **blueshield-***
3. You'll see logs from:
   - Zeek (network analysis)
   - Suricata (IDS alerts)
   - OSQuery (host monitoring)
   - Auditd (system audit)

### In Grafana:

1. Login with admin/admin
2. Import the BlueShield dashboard (if available)
3. Or create your own dashboards using Elasticsearch as data source

## 🎯 Common Tasks

### Check Service Status
```bash
./scripts/status_blueshield.sh
```

### Stop All Services
```bash
sudo ./scripts/stop_blueshield.sh
```

### View Zeek Logs
```bash
tail -f /var/log/zeek/current/conn.log
```

### View Suricata Alerts
```bash
tail -f /var/log/suricata/fast.log
```

### Check Elasticsearch Indices
```bash
curl http://localhost:9200/_cat/indices?v
```

## 🔍 Testing Detection

Run different attack simulations and observe alerts:

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

After each simulation, check:
1. **Kibana Discover** for log entries
2. **Suricata alerts** in `/var/log/suricata/fast.log`
3. **Zeek notices** in Zeek logs

## 🐛 Troubleshooting

### Services won't start?

```bash
# Check logs
journalctl -u elasticsearch -n 50
journalctl -u kibana -n 50
journalctl -u filebeat -n 50

# Restart a service
sudo systemctl restart elasticsearch
```

### No data in Kibana?

1. Check Filebeat is running: `systemctl status filebeat`
2. Verify Elasticsearch has data: `curl http://localhost:9200/_cat/indices`
3. Check Filebeat logs: `journalctl -u filebeat -f`

### Can't access Kibana/Grafana?

1. Check services are running: `./scripts/status_blueshield.sh`
2. Check firewall: `sudo ufw status`
3. Verify ports are listening: `sudo netstat -tlnp | grep -E '5601|3000'`

## 📚 Next Steps

1. **Explore Kibana**: Create visualizations and dashboards
2. **Customize Rules**: Edit detection rules in `rules/` directory
3. **Add Dashboards**: Import Grafana dashboards for better visualization
4. **Learn More**: Read the full README.md for detailed documentation

## 💡 Tips

- Start with simple attack simulations to understand the flow
- Use Kibana's Discover to explore different log types
- Create saved searches in Kibana for common queries
- Set up alerts in Kibana for critical events
- Customize detection rules based on your environment

---

**Happy Hunting!** 🛡️



