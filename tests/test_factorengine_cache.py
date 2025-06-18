import sys, os
# Ensure src is on path
sys.path.insert(0, os.path.abspath(os.path.dirname(__file__) + '/../src'))

from cache_manager import CacheManager
from exosuite_core import orchestrate_factoring, cache_manager

def test_factorengine_cache_behavior():
    cache_manager.symbolic.cache.clear()
    cache_manager.hash.cache.clear()
    cache_manager.factor.cache.clear()
    # First run: cache miss
    res1 = orchestrate_factoring(29)
    assert res1['factor_cache_hit'] is False
    # Second run: cache hit
    res2 = orchestrate_factoring(29)
    assert res2['factor_cache_hit'] is True
