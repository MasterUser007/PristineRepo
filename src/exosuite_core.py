import os
from cache_manager import CacheManager
from concurrent.futures import ThreadPoolExecutor
from PrimeEngineAI.src.engine_core import main_factoring_engine as pef
from FactorEngine.src.miller_rabin import is_probably_prime
from QuantumHash.src.engine_core import main_factoring_engine as qhf

# Singleton cache manager
cache_manager = CacheManager()

def orchestrate_factoring(n: int) -> dict:
    """Orchestrate factoring with caching and parallel engine calls."""
    # Symbolic cache
    sym = cache_manager.symbolic.get(n)
    if sym is not None:
        pe_result = sym
        sym_hit = True
    else:
        sym_hit = False

    # FactorEngine cache
    fe_cached = cache_manager.factor.get(n)
    if fe_cached is not None:
        fe_result = fe_cached
        fe_hit = True
    else:
        fe_hit = False

    # Hash cache
    qh = cache_manager.hash.get(n)
    if qh is not None:
        qh_result = qh
        qh_hit = True
    else:
        qh_hit = False

    # Run missing engine calls in parallel
    with ThreadPoolExecutor() as executor:
        futures = {}
        if not sym_hit:
            futures['pe'] = executor.submit(pef, input_number=n)
        if not fe_hit:
            futures['fe'] = executor.submit(is_probably_prime, n)
        if not qh_hit:
            futures['qh'] = executor.submit(qhf, input_number=n)

    # Collect results and update caches
    if not sym_hit:
        pe_result = futures['pe'].result()
        cache_manager.symbolic.set(n, pe_result)
    if not fe_hit:
        fe_result = futures['fe'].result()
        cache_manager.factor.set(n, fe_result)
    if not qh_hit:
        qh_result = futures['qh'].result()
        cache_manager.hash.set(n, qh_result)

    return {
        'PrimeEngineAI': pe_result,
        'FactorEngine': fe_result,
        'QuantumHash': qh_result,
        'symbolic_cache_hit': sym_hit,
        'factor_cache_hit': fe_hit,
        'hash_cache_hit': qh_hit
    }
