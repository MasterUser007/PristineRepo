# Formal API Specification for ExoSuite

## Available APIs

- `orchestrate_factoring(n: int) -> dict`: Runs end-to-end factoring across engines.

### Preconditions
- `n` is positive integer.

### Postconditions
- Returns a dict with results and timing metrics.

---
## Updates
- **Cache Persistence & Metrics**: Caches persisted to disk at exit (`CACHE_PERSIST_PATH`). Hit/miss metrics collected for symbolic, hash, and factor caches.
- **Configurable TTL & Eviction**: `SYMBOLIC_CACHE_MAX`, `SYMBOLIC_CACHE_TTL`, `HASH_CACHE_TTL` via env vars.
- **Asynchronous Parallel Orchestration**: Engines invoked in parallel using `ThreadPoolExecutor`.
- **Nearest-Neighbor & Fuzz Testing**: System-level tests added for edge-case composites and Hypothesis-driven fuzz.
- **Performance Regression Gate**: CI performance test thresholds set (e.g., 0.1s per input).
