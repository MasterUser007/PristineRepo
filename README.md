# PristineRepo

## Overview
PristineRepo contains a high-performance suite of tools (ExoSuite), which is comprised of multiple Patent-pending crytography tools. These engines: PrimeEngineAI, FactorEngine, and QuantumHash, along with a specialize layered symbolic cache engine that is the orchestration and symbiotic functions of the entire ExoSuite ecosystem; designed with speed and accuracy in mind, ExoSuite leverages **symbolic filtering**, **GPU-accelerated sieving**, and **probabilistic validation** to optimize computational efficiency. Designed for cryptographic applications, mathematical research, and high-speed numeric processing, it systematically eliminates unnecessary candidates before running intensive primality tests. All to produce the fastest, most powerful self-learning suite of its kind.

## Features
- **Symbolic Filtering & Truncation** – Excludes non-prime candidates early based on digit structure and modular arithmetic.
- **GPU-Accelerated Sieving** – Uses CUDA to parallelize composite detection.
- **Infinitesimal Remainder Analysis** – Lightweight heuristic filters before deeper validation.
- **GMP Miller-Rabin Primality Testing** – Probabilistic validation with deterministic fallback (ECPP for large numbers).
- **Modular Architecture** – Each pipeline stage operates independently for extensibility.
- **Machine Learning Hooks** – Adaptive filtering using ML-assisted symbolic rule evolution.
- **Cloud-Optimized Deployment** – Containerized infrastructure for scalable compute environments.

## Installation

### Requirements
- Python 3.8+
- CUDA-enabled GPU (optional for acceleration)
- GMP library for large-number arithmetic
- Docker (recommended for containerized deployments)

### Setup
```sh
git clone https://github.com/PristineRepo/PristineRepo.git
cd PristineRepo
pip install -r requirements.txt

