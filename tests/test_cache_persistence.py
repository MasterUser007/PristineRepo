import os
import json
import sys
import time
# Setup import path
sys.path.insert(0, os.path.abspath(os.path.dirname(__file__) + '/../src'))
from cache_manager import CacheManager, CACHE_PERSIST_PATH

def test_persistence_and_metrics(tmp_path):
    # Use tmp file for persistence
    p = tmp_path / "cache.json"
    os.environ['CACHE_PERSIST_PATH'] = str(p)
    # Initialize and clear
    cm = CacheManager()
    cm.symbolic.cache.clear(); cm.hash.cache.clear(); cm.factor.cache.clear()
    # Populate caches
    cm.symbolic.set(1, [1]); cm.hash.set(2, [2]); cm.factor.set(3, True)
    # Trigger hits/misses
    assert cm.symbolic.get(1) == [1]
    assert cm.symbolic.get(99) is None
    assert cm.hash.get(2) == [2]
    assert cm.factor.get(3) is True
    # Persist and load new manager
    cm.persist()
    cm2 = CacheManager()
    assert cm2.symbolic.get(1) == [1]
    assert cm2.hash.get(2) == [2]
    assert cm2.factor.get(3) is True
    # Check metrics recorded
    data = json.load(open(str(p)))
    metrics = data['metrics']
    assert 'symbolic_hits' in metrics and metrics['symbolic_hits'] >= 1
    assert 'hash_hits' in metrics and metrics['hash_hits'] >= 1
    assert 'factor_hits' in metrics and metrics['factor_hits'] >= 1
