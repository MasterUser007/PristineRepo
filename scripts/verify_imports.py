import importlib
import os, sys

sys.path.insert(0, os.path.abspath("ExoSuite/src"))

try:
    mod = importlib.import_module("cache_manager")
    assert hasattr(mod, "CACHE_PERSIST_PATH"), "CACHE_PERSIST_PATH not found."
except Exception as e:
    print(f"Import verification failed: {e}")
    exit(1)

print("✅ Import verification passed.")
