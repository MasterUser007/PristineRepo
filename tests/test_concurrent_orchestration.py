import sys, os
sys.path.insert(0, os.path.abspath(os.path.dirname(__file__) + '/../src'))
from exosuite_core import orchestrate_factoring, cache_manager

def test_concurrent_orchestration_basic():
    cache_manager.symbolic.cache.clear()
    cache_manager.factor.cache.clear()
    cache_manager.hash.cache.clear()
    res = orchestrate_factoring(91)  # 91 = 7*13
    assert res['PrimeEngineAI'] == [7,13]
    assert res['FactorEngine'] is False  or isinstance(res['FactorEngine'], bool)
    assert res['QuantumHash'] == [7,13]
    # Cache hits on second call
    res2 = orchestrate_factoring(91)
    assert res2['symbolic_cache_hit']
    assert res2['factor_cache_hit']
    assert res2['hash_cache_hit']
