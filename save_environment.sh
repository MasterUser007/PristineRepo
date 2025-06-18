#!/bin/bash
echo "Saving current session environment..."

docker ps --format '{{.Names}}' > logs/active_services_$(date +%Y%m%d_%H%M%S).log
cp logs/plugin_usage.log logs/plugin_usage_backup_$(date +%Y%m%d_%H%M%S).log

echo "✅ Logs and environment snapshot saved."