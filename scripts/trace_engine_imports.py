import builtins
import traceback
import sys

original_import = builtins.__import__

def traced_import(name, globals=None, locals=None, fromlist=(), level=0):
    if "factoring" in name or "main_factoring_engine" in name:
        print(f"📦 Intercepted import: {name}", file=sys.stderr)
        traceback.print_stack(limit=6, file=sys.stderr)
        print("-" * 60, file=sys.stderr)
    return original_import(name, globals, locals, fromlist, level)

builtins.__import__ = traced_import
print("🛠️ Import tracer active...", file=sys.stderr)
