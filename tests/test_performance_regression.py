import pytest
import time
from exosuite_core import orchestrate_factoring

# Maximum allowable orchestration time per input (seconds)
THRESHOLD = 0.1

# Test inputs: small, medium, large
INPUTS = [15, 10**6 + 3, 10**7 + 17]

@pytest.mark.parametrize("n", INPUTS)
def test_performance_regression(n):
    start = time.perf_counter()
    orchestrate_factoring(n)
    duration = time.perf_counter() - start
    assert duration < THRESHOLD, f"Orchestration for {n} took {duration:.3f}s, exceeding {THRESHOLD}s"
