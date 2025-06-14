# ML-INSTRUMENTED
Import-Module ./pavi_ml.psm1

<#
.SYNOPSIS
  Full �docs ? lint ? test� pipeline end-to-end.
#>
param()

# 1) Build docs + link-check
Write-Host "`n1) mkdocs build + lychee link check" -ForegroundColor Cyan
mkdocs build --clean
lychee --exit-zero-on-error --recursive docs
if ($LASTEXITCODE -ne 0) { Write-Error '? Docs/link check failed'; exit $LASTEXITCODE }

# 2) Black formatting (skip known-bad files)
Write-Host "`n2) black --check" -ForegroundColor Cyan
$exclude = '^(?:examples[\\/]|orchestration[\\/]src[\\/]pipeline\.py$|orchestration[\\/]tests[\\/]test_pipeline_.*\.py$)'
black --check . --exclude $exclude
if ($LASTEXITCODE -ne 0) { Write-Error '? Black formatting failed'; exit $LASTEXITCODE }

# 3) isort import sorting
Write-Host "`n3) isort --check-only" -ForegroundColor Cyan
isort --check-only . `
  --skip-glob "examples/*" `
  --skip-glob "orchestration/src/pipeline.py" `
  --skip-glob "orchestration/tests/test_pipeline_*.py"
if ($LASTEXITCODE -ne 0) { Write-Error '? isort failed'; exit $LASTEXITCODE }

# 4) flake8 + mypy
Write-Host "`n4) flake8 + mypy" -ForegroundColor Cyan
flake8 .
mypy .
if ($LASTEXITCODE -ne 0) { Write-Error '? flake8/mypy failed'; exit $LASTEXITCODE }

# 5) pytest
Write-Host "`n5) pytest" -ForegroundColor Cyan
pytest --maxfail=1 --disable-warnings -q
if ($LASTEXITCODE -ne 0) { Write-Error '? pytest failed'; exit $LASTEXITCODE }

Write-Host "`n? All checks passed!" -ForegroundColor Green

