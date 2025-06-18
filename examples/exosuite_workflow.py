# Example: Prime -> Factor -> Hash Pipeline

This example demonstrates how ExoSuite engines interact in sequence.

```python
from PrimeEngineAI.engine_core import main_factoring_engine as discover_prime
from FactorEngine.engine_core import main_factoring_engine as factor_number
from QuantumHash.engine_core import main_factoring_engine as quantum_hash_transform

# Step 1: Discover a prime number (simulate)
candidate = 1299827  # Substitute with output of discover_prime() if available

# Step 2: Factor (should be prime, so returns [candidate])
factors = factor_number(candidate)
print("Factors:", factors)

# Step 3: Transform via QuantumHash
hash_output = quantum_hash_transform(candidate)
print("QuantumHash Result:", hash_output)
```