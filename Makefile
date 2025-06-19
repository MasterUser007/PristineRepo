finalize:
    powershell -ep Bypass -File ./scripts/finalize-poc.ps1

release:
    git push origin main
    git tag -a v1.0.0 -m "Initial release"
    git push origin v1.0.0
