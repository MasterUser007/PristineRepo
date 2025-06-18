import sys, os
root = os.path.abspath(os.path.dirname(__file__) + '/../../')
sys.path.insert(0, root)
sys.path.insert(0, os.path.join(root, 'ExoSuite', 'src'))
project_root = os.path.abspath(os.path.dirname(__file__) + '/..')
import pytest
from cache_manager import CacheManager

def test_cache_manager_set_get():
    cm = CacheManager(max_size=2)
    assert cm.symbolic.get(1) is None
    cm.symbolic.set(1, [1])
    assert cm.symbolic.get(1) == [1]
    cm.symbolic.set(2, [2])
    cm.symbolic.set(3, [3])  # should evict 1
    assert cm.symbolic.get(1) is None
    assert cm.symbolic.get(2) == [2]
    assert cm.symbolic.get(3) == [3]
