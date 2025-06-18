#!/bin/bash
echo "Starting ExoSuite stack with Prometheus and Grafana..."

docker-compose -f docker-compose.prometheus.yml up --build