"""PrimeEngineAI/src/engine_core.py"""


def main_factoring_engine(n: int) -> list[int]:
    from math import isqrt

    factors = []
    d = 2
    while d <= isqrt(n):
        while n % d == 0:
            factors.append(d)
            n //= d
        d += 1 if d == 2 else 2
    if n > 1:
        factors.append(n)
    return factors
