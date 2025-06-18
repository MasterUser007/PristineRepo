commit-all:
    pwsh -ExecutionPolicy Bypass -File ./scripts/pristine.ps1

validate:
    npx jest

release:
    pwsh ./scripts/release.ps1
