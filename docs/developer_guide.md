# ExoSuite Developer Guide

This guide provides developers with everything needed to build, test, deploy, and extend the ExoSuite engine.

## 📦 Project Structure

- `engine_core.py`: Main entry point and processing pipeline
- `symbolic_factoring.py`: Symbolic filters and rule-based pruning
- `gpu_miller_rabin.py`: GPU-based primality check
- `black_box_io.py`: Handles input/output for black-box testing
- `api/main.py`: FastAPI server exposing factoring/prime/hash endpoints
- `examples/`: CLI demos and integration workflows
- `tests/`: Unit and black-box test suites

## 🧪 Testing

Run local tests:
```bash
pytest tests/
```

Black-box test validation:
```bash
pytest tests/test_exosuite.py
```

## 🖥️ Local API Run

```bash
uvicorn api.main:app --reload
```

Open Swagger docs:
- `http://localhost:8000/docs`

## 🐳 Docker

```bash
docker build -t exosuite-engine .
docker run -p 8000:8000 exosuite-engine
```

## ☁️ Terraform Cloud Deployment

```bash
cd infra/terraform
terraform init
terraform apply
```

Use `Makefile` for convenience:
```bash
make apply
```

## 🔐 Pre-commit Hooks

```bash
pre-commit install
pre-commit run --all-files
```

## 📚 Docs

Edit in `docs/` and preview with:
```bash
mkdocs serve
```

## 🛠 Extensions

- Add symbolic filters to `symbolic_factoring.py`
- Add new API routes in `api/main.py`
- Add integration flows in `examples/`

---

This engine is part of the ExoSuite stack and should maintain parity with all other modules.