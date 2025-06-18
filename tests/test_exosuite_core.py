import sys, os
root = os.path.abspath(os.path.dirname(__file__) + '/../../')
sys.path.insert(0, root)
sys.path.insert(0, os.path.join(root, 'ExoSuite', 'src'))
project_root = os.path.abspath(os.path.dirname(__file__) + '/..')
import pytest
from exosuite_core import orchestrate_factoring, cache_manager
from PrimeEngineAI.src.engine_core import main_factoring_engine as pef
from QuantumHash.src.engine_core import main_factoring_engine as qhf

@pytest.mark.parametrize("n", [15, 77])
def test_orchestrate_and_cache(n):
    # Clear caches before each test
    cache_manager.symbolic.cache.clear()
    cache_manager.hash.cache.clear()
    # First call should be cache miss
    res1 = orchestrate_factoring(n)
    assert res1["PrimeEngineAI"] == pef(input_number=n)
    assert res1["QuantumHash"] == qhf(input_number=n)
    assert res1["symbolic_cache_hit"] is False
    assert res1["hash_cache_hit"] is False
    # Second call should be cache hit
    res2 = orchestrate_factoring(n)
    assert res2["symbolic_cache_hit"] is True
    assert res2["hash_cache_hit"] is True
    assert res2["PrimeEngineAI"] == res1["PrimeEngineAI"]
    assert res2["QuantumHash"] == res1["QuantumHash"]
