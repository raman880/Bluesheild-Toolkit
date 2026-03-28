# BlueShield Toolkit

A comprehensive defensive cybersecurity platform designed to function as a mini Security Operations Center (SOC) within a single Kali Linux system. This project integrates powerful open-source tools to provide real-time monitoring, threat detection, and log analysis.

## 🛡️ Overview

The BlueShield Toolkit bridges the gap between academic knowledge and real-world cybersecurity operations by providing a controlled, interactive lab environment for:

- **Incident Detection**: Real-time monitoring of network and host activities
- **Log Analysis**: Centralized log collection and analysis
- **Forensic Investigation**: Deep-dive analysis capabilities
- **Blue Team Skill Development**: Hands-on training for SOC analysts

## 🚀 Features

- **Network Monitoring**: Zeek and Suricata for network traffic analysis
- **Host Monitoring**: OSQuery and Auditd for system-level monitoring
- **Log Aggregation**: Elastic Stack (Elasticsearch, Logstash, Kibana) for centralized logging
- **Data Shipping**: Filebeat for log collection and forwarding
- **Visualization**: Grafana dashboards for intuitive data visualization
- **Attack Simulations**: Pre-built scripts for testing detection capabilities
- **Automated Setup**: One-command installation script

## 📋 Prerequisites

- **Operating System**: Kali Linux (or Ubuntu/Debian-based system)
- **RAM**: Minimum 4GB (8GB+ recommended)
- **Disk Space**: Minimum 20GB free space
- **Network**: Active network interface for monitoring
- **Permissions**: Root/sudo access required for installation

## 🔧 Installation

### For Virtual Machine Setup

**If running in a VM, first run the VM setup script:**
```bash
# Run VM setup (auto-detects network interface)
sudo ./vm_setup.sh

# Then proceed with installation
sudo ./install.sh
```

**See `VM_SETUP_GUIDE.md` for detailed VM setup instructions.**

### Quick Install

```bash
# Clone or download the repository
cd "BLUESHIELD TOOLKIT"

# Make installation script executable
chmod +x install.sh

# Run installation (requires root)
sudo ./install.sh
```

The installation script will:
1. Update system packages
2. Install all required dependencies
3. Install and configure:
   - Zeek (network analysis)
   - Suricata (IDS/IPS)
   - OSQuery (host monitoring)
   - Auditd (audit logging)
   - Elastic Stack (Elasticsearch, Kibana)
   - Filebeat (log shipper)
   - Grafana (visualization)
4. Set up configuration files
5. Create necessary directories
6. Enable services

### Manual Installation

If you prefer manual installation, refer to individual tool documentation:
- [Zeek Documentation](https://docs.zeek.org/)
- [Suricata Documentation](https://suricata.readthedocs.io/)
- [OSQuery Documentation](https://osquery.readthedocs.io/)
- [Elastic Stack Documentation](https://www.elastic.co/guide/)

## 🎯 Usage

### Starting Services

```bash
# Start all BlueShield services
sudo ./scripts/start_blueshield.sh
```

### Stopping Services

```bash
# Stop all BlueShield services
sudo ./scripts/stop_blueshield.sh
```

### Accessing Dashboards

After starting services, access:

- **Kibana**: http://localhost:5601
  - Default: No authentication required (development mode)
  - Create index patterns for: `blueshield-*`

- **Grafana**: http://localhost:3000
  - Default credentials: `admin` / `admin`
  - Change password on first login

- **Elasticsearch**: http://localhost:9200
  - Check cluster health: `curl http://localhost:9200/_cluster/health`

### Running Attack Simulations

Test your detection capabilities with pre-built attack simulations:

```bash
# Port scan simulation
sudo ./attacks/simulate_port_scan.sh [target_host] [ports]

# SQL injection simulation
sudo ./attacks/simulate_sql_injection.sh [target_url] [endpoint]

# Brute force simulation
sudo ./attacks/simulate_brute_force.sh [target_host] [port] [attempts]

# XSS attack simulation
sudo ./attacks/simulate_xss.sh [target_url] [endpoint]

# DNS exfiltration simulation
sudo ./attacks/simulate_dns_exfiltration.sh [dns_server]
```

## 📁 Project Structure

```
BLUESHIELD TOOLKIT/
├── install.sh                 # Main installation script
├── README.md                  # This file
├── configs/                   # Configuration files
│   ├── zeek/                 # Zeek configurations
│   ├── suricata/             # Suricata configurations
│   ├── osquery/              # OSQuery configurations
│   ├── auditd/               # Auditd configurations
│   ├── elastic/              # Elastic Stack configurations
│   ├── filebeat/             # Filebeat configurations
│   └── grafana/              # Grafana configurations
├── rules/                     # Detection rules
│   ├── suricata/             # Suricata detection rules
│   └── zeek/                 # Zeek detection rules
├── scripts/                   # Management scripts
│   ├── start_blueshield.sh   # Start all services
│   └── stop_blueshield.sh    # Stop all services
├── attacks/                   # Attack simulation scripts
│   ├── simulate_port_scan.sh
│   ├── simulate_sql_injection.sh
│   ├── simulate_brute_force.sh
│   ├── simulate_xss.sh
│   └── simulate_dns_exfiltration.sh
└── dashboards/                # Grafana dashboard JSON files
```

## 🔍 Detection Capabilities

### Network-Based Detection

- **Port Scanning**: Detects rapid connection attempts
- **SQL Injection**: Identifies SQL injection patterns in HTTP requests
- **XSS Attacks**: Detects cross-site scripting attempts
- **Command Injection**: Identifies command injection patterns
- **Directory Traversal**: Detects path traversal attempts
- **Brute Force**: Identifies repeated authentication attempts
- **DNS Exfiltration**: Detects suspicious DNS queries
- **Malicious File Downloads**: Identifies suspicious file types

### Host-Based Detection

- **Process Monitoring**: Tracks process creation and execution
- **File System Changes**: Monitors critical file modifications
- **User Activity**: Tracks user logins and privilege escalations
- **Network Connections**: Monitors listening ports and connections
- **System Configuration**: Tracks system configuration changes

## 📊 Log Sources

The system collects logs from:

1. **Zeek**: Network protocol analysis logs
   - Connection logs
   - HTTP logs
   - DNS logs
   - SSL/TLS logs
   - File analysis logs

2. **Suricata**: IDS/IPS alerts and events
   - Alert logs
   - HTTP events
   - DNS events
   - TLS events
   - File events

3. **OSQuery**: Host-based telemetry
   - Process events
   - File events
   - Socket events
   - User events
   - System information

4. **Auditd**: System audit logs
   - System calls
   - File access
   - User activity
   - Privilege changes

5. **System Logs**: Standard Linux logs
   - Syslog
   - Auth logs
   - Kernel logs

## 🎓 Training Scenarios

### Scenario 1: Port Scan Detection
1. Run `./attacks/simulate_port_scan.sh`
2. Check Suricata alerts in Kibana
3. Analyze Zeek connection logs
4. Review Grafana dashboards

### Scenario 2: Web Application Attacks
1. Run SQL injection and XSS simulations
2. Review HTTP logs in Kibana
3. Analyze Suricata alerts
4. Correlate events across time

### Scenario 3: Brute Force Detection
1. Run brute force simulation
2. Check authentication logs
3. Review OSQuery process events
4. Analyze attack patterns

### Scenario 4: Data Exfiltration
1. Run DNS exfiltration simulation
2. Analyze DNS query patterns
3. Review network traffic
4. Identify exfiltration indicators

## 🔧 Configuration

### Zeek Configuration
- Main config: `/opt/blueshield/configs/zeek/node.cfg`
- Local policies: `/opt/blueshield/configs/zeek/local.zeek`
- Logs: `/var/log/zeek/`

### Suricata Configuration
- Main config: `/opt/blueshield/configs/suricata/suricata.yaml`
- Rules: `/opt/blueshield/rules/suricata/`
- Logs: `/var/log/suricata/`

### OSQuery Configuration
- Config: `/opt/blueshield/configs/osquery/osquery.conf`
- Logs: `/var/log/osquery/`

### Elastic Stack Configuration
- Elasticsearch: `/opt/blueshield/configs/elastic/elasticsearch.yml`
- Kibana: `/opt/blueshield/configs/elastic/kibana.yml`

### Filebeat Configuration
- Config: `/opt/blueshield/configs/filebeat/filebeat.yml`
- Logs: `/var/log/filebeat/`

## 🐛 Troubleshooting

### Services Not Starting

```bash
# Check service status
systemctl status elasticsearch
systemctl status kibana
systemctl status filebeat
systemctl status grafana-server

# Check logs
journalctl -u elasticsearch -f
journalctl -u kibana -f
journalctl -u filebeat -f
journalctl -u grafana-server -f
```

### No Data in Kibana

1. Verify Elasticsearch is running: `curl http://localhost:9200`
2. Check Filebeat status: `systemctl status filebeat`
3. Verify log paths in Filebeat config
4. Check Elasticsearch indices: `curl http://localhost:9200/_cat/indices`

### Detection Rules Not Triggering

1. Verify rules are loaded: Check Suricata/Zeek logs
2. Test with attack simulations
3. Review rule syntax
4. Check network interface configuration

## 📚 Learning Resources

- [Zeek Documentation](https://docs.zeek.org/)
- [Suricata Documentation](https://suricata.readthedocs.io/)
- [OSQuery Documentation](https://osquery.readthedocs.io/)
- [Elastic Stack Guide](https://www.elastic.co/guide/)
- [Grafana Documentation](https://grafana.com/docs/)

## 🤝 Contributing

Contributions are welcome! Please feel free to submit pull requests or open issues for:
- New detection rules
- Additional attack simulations
- Dashboard improvements
- Documentation enhancements
- Bug fixes

## ⚠️ Disclaimer

This toolkit is designed for **educational and training purposes only**. The attack simulation scripts should only be used in controlled lab environments. Users are responsible for ensuring compliance with all applicable laws and regulations.

## 📝 License

This project is provided as-is for educational purposes. Please review individual tool licenses:
- Zeek: BSD License
- Suricata: GPLv2
- OSQuery: Apache 2.0
- Elastic Stack: Various (see Elastic licensing)
- Grafana: Apache 2.0

## 🙏 Acknowledgments

This project integrates and builds upon excellent open-source security tools:
- Zeek (formerly Bro)
- Suricata
- OSQuery
- Elastic Stack
- Filebeat
- Grafana

## 📧 Support

For issues, questions, or contributions, please open an issue in the project repository.

---

**BlueShield Toolkit** - Making defensive cybersecurity training accessible, practical, and interactive.

