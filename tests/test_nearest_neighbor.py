import pytest
import sys, os
# Ensure src on path
sys.path.insert(0, os.path.abspath(os.path.dirname(__file__) + '/../src'))
from exosuite_core import orchestrate_factoring

# Known primes list for test
PRIMES = [3, 5, 7, 11, 13, 17, 19, 23, 29]

@pytest.mark.parametrize("p", PRIMES)
def test_neighbors(p):
    # p is prime
    res_p = orchestrate_factoring(p)
    assert res_p["PrimeEngineAI"] == [p]
    assert res_p["QuantumHash"] == [p]
    # p+1 is composite
    res_next = orchestrate_factoring(p + 1)
    # composite number factoring should produce factors >1
    assert isinstance(res_next["PrimeEngineAI"], list)
    assert res_next["PrimeEngineAI"] != [p + 1]
