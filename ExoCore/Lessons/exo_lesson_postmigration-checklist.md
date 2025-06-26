**Lesson ID**: LSN-POSTMIGRATION-CHECKS  
**Date**: 2025-06-26  
**Result**: Prepared xo-lint, xo-drift, and xo-unify for system integrity and cohesion  

---

### 🔍 xo-lint.ps1

- Checks .ps1 syntax
- Flags unresolved stubs or placeholder markers

### 🌐 xo-drift.ps1

- Compares local vs S3 for Lessons/, MappingTree/, Telemetry/
- Useful for verifying cold-clone or remote sync

### 🧠 xo-unify.ps1

- Gathers JSON from telemetry engine outputs
- Produces Telemetry/unified_cognition.json for downstream advisory logic

---

### 🧠 Next

You can now run:

    pwsh .\ExoCore\exo-lint.ps1
    pwsh .\ExoCore\exo-drift.ps1
    pwsh .\ExoCore\exo-unify.ps1

to verify migration health and cognition consistency.
