# ExoSuite Monitoring Stack

This module documents how to set up, launch, and maintain the Prometheus + Grafana stack for monitoring plugin activity across all ExoSuite engines.

---

## 📦 Components

- **Prometheus**: Collects metrics from plugin endpoints
- **Grafana**: Visualizes plugin scores and usage stats
- **docker-compose.prometheus.yml**: Unified launch file
- **Makefile**: Start/stop shortcuts
- **.github/workflows/monitoring_stack.yml**: Optional CI runner

---

## 🚀 Quickstart (Local)

```bash
make monitoring-up
```

Then open:
- Prometheus: http://localhost:9090
- Grafana: http://localhost:3000 (admin/admin)

---

## 🧪 In CI/CD

Trigger the **Optional Monitoring Stack Test** action via GitHub → Actions.

---

## 🛑 Shutdown

```bash
make monitoring-down
```

This stops all containers and releases memory.

---

## 💾 Session Persistence

- Plugin logs: saved in `/logs/plugin_usage.log`
- Prometheus config is stored under `/monitoring/prometheus.yml`
- Dashboard definition in `/monitoring/grafana_exosuite_dashboard.json`

Use volume mounts or AWS EBS/S3 in production to preserve state between test sessions.