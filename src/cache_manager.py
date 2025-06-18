import os
import time
import json
from collections import OrderedDict

CACHE_PERSIST_PATH = os.getenv('CACHE_PERSIST_PATH', '/mnt/data/projects/ExoSuite/cache_data.json')
SYMBOLIC_CACHE_MAX = int(os.getenv('SYMBOLIC_CACHE_MAX', '10000'))
SYMBOLIC_CACHE_TTL = float(os.getenv('SYMBOLIC_CACHE_TTL', '60'))
HASH_CACHE_TTL = float(os.getenv('HASH_CACHE_TTL', '60'))

class SymbolicCacheLRU:
    '''LRU cache with TTL and metrics.'''
    def __init__(self, max_size=SYMBOLIC_CACHE_MAX, ttl=SYMBOLIC_CACHE_TTL):
        self.cache = OrderedDict()
        self.max_size = max_size
        self.ttl = ttl
        self.hits = 0
        self.misses = 0

    def get(self, key):
        entry = self.cache.get(key)
        if entry:
            value, ts = entry
            if time.time() - ts < self.ttl:
                self.hits += 1
                self.cache.move_to_end(key)
                return value
            else:
                del self.cache[key]
        self.misses += 1
        return None

    def set(self, key, value):
        self.cache[key] = (value, time.time())
        self.cache.move_to_end(key)
        while len(self.cache) > self.max_size:
            self.cache.popitem(last=False)

class LockFreeCache:
    '''Dict cache with TTL and metrics.'''
    def __init__(self, ttl=HASH_CACHE_TTL):
        self.cache = {}
        self.ttl = ttl
        self.hits = 0
        self.misses = 0

    def get(self, key):
        entry = self.cache.get(key)
        if entry:
            value, ts = entry
            if time.time() - ts < self.ttl:
                self.hits += 1
                return value
            else:
                del self.cache[key]
        self.misses += 1
        return None

    def set(self, key, value):
        self.cache[key] = (value, time.time())

class CacheManager:
    '''Cache manager with persistence and metrics.'''
    def __init__(self, max_size=SYMBOLIC_CACHE_MAX, ttl=SYMBOLIC_CACHE_TTL):
        self.symbolic = SymbolicCacheLRU(max_size, ttl)
        self.hash = LockFreeCache()
        self.factor = SymbolicCacheLRU(max_size, ttl)
        self._load()

    def _load(self):
        path = os.getenv('CACHE_PERSIST_PATH', CACHE_PERSIST_PATH)
        if os.path.exists(path):
            try:
                data = json.load(open(path))
                for k, v in data.get('symbolic', {}).items():
                    self.symbolic.set(int(k), v)
                for k, v in data.get('hash', {}).items():
                    self.hash.set(int(k), v)
                for k, v in data.get('factor', {}).items():
                    self.factor.set(int(k), v)
            except Exception:
                pass

    def persist(self):
        path = os.getenv('CACHE_PERSIST_PATH', CACHE_PERSIST_PATH)
        data = {
            'symbolic': {str(k): v for k, (v, _) in self.symbolic.cache.items()},
            'hash': {str(k): v for k, (v, _) in self.hash.cache.items()},
            'factor': {str(k): v for k, (v, _) in self.factor.cache.items()},
            'metrics': {
                'symbolic_hits': self.symbolic.hits,
                'symbolic_misses': self.symbolic.misses,
                'hash_hits': self.hash.hits,
                'hash_misses': self.hash.misses,
                'factor_hits': self.factor.hits,
                'factor_misses': self.factor.misses
            }
        }
        json.dump(data, open(path, 'w'))

import atexit
_cm = CacheManager()
atexit.register(_cm.persist)
