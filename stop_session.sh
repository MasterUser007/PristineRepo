#!/bin/bash
echo "Stopping test session to avoid cost overrun..."
docker-compose -f docker-compose.prometheus.yml down
echo "✅ Session stopped and containers cleaned up."