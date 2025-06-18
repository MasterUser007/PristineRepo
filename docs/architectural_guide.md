# ExoSuite Architectural Guide

## Overview

ExoSuite is a modular symbolic mathematics engine consisting of 3 integrated components:
- **PrimeEngineAI** for prime discovery
- **FactorEngine** for symbolic factoring
- **QuantumHash** for cryptographic transformation

Each module runs independently but shares a common symbolic core.

---

## Core Components

### 🔹 Symbolic Core (Shared)
- `symbolic_factoring.py`: filtering and truncation rules
- `shared_data_exchange.py`: common exchange protocols
- `black_box_io.py`: standard I/O for black-box testing

### 🔹 GPU Compute
- `gpu_miller_rabin.py`: accelerated primality tests
- `docker-compose.yml`: containerized deployment

---

## APIs & Interoperability

- FastAPI-based REST endpoints per engine
- Swagger docs at `/docs`
- Shared ports: 8001 (prime), 8002 (factor), 8003 (hash)
- Prometheus metrics at port `9000`

---

## Deployment Layers

1. **Local Dev**
   - Uvicorn + Docker
2. **Containerized**
   - Docker Compose or ECS
3. **Cloud Infra**
   - Terraform: EC2 + ALB + HTTPS
   - Route53 for domain setup
4. **Sync/Automation**
   - GitHub Actions: sync + changelog
   - `sync_exosuite_repos.py`: repo parity

---

## Extension Strategy

- Extend symbolic logic via `symbolic_factoring.py`
- New pipelines added in `examples/`
- Expose new APIs in `api/main.py`

---

## Governance

All changes to any engine must be mirrored across:
- Codebase structure
- Shared modules
- Infrastructure setup
- Documentation standards