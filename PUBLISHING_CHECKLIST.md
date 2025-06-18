# Final Publishing Checklist

## Repository Structure (Organization: ExoSuiteOrg)

| Repository        | Purpose                                                        |
|-------------------|----------------------------------------------------------------|
| `ExoSuite`         | Master repo — all engines, full infra, docs, tests, sync logic |
| `PrimeEngineAI`    | Symbolic prime discovery engine                                |
| `FactorEngine`     | Symbolic + GPU factoring engine                                |
| `QuantumHash`      | Modular hash engine with symbolic filtering                    |
| `ExoSuite-Infra`   | Terraform, Docker, deployment stacks                           |
| `ExoSuite-Diagrams`| All visuals, dashboards, and architecture diagrams             |

## GitHub Publishing

- [ ] Create organization `ExoSuiteOrg` (private)
- [ ] For each repo:
  ```bash
  git init
  git remote add origin https://github.com/ExoSuiteOrg/<RepoName>.git
  git checkout -b main
  git add .
  git commit -m "Initial commit: v1.0.0"
  git push -u origin main
  git tag -a v1.0.0 -m "Initial release"
  git push origin v1.0.0
  ```
- [ ] Enable GitHub Actions workflows:
  - CI & coverage checks
  - Monitoring stack test
  - Sync-from-master dispatch
- [ ] Enable GitHub Pages for `ExoSuite` (branch: `gh-pages`)

## PyPI (Optional for each engine)

- [ ] Ensure `setup.py` classifiers and version are correct
- [ ] Build and upload:
  ```bash
  python setup.py sdist bdist_wheel
  twine upload dist/*
  ```
- [ ] Store PyPI token in GitHub Secrets

## GitHub Pages (MkDocs)

- [ ] Install `mkdocs-material`
- [ ] Deploy site:
  ```bash
  mkdocs gh-deploy --force
  ```

## Security & Governance

- [ ] Protect `main` branch (no force-push)
- [ ] Enable required reviews
- [ ] Add necessary GitHub Secrets (e.g., PyPI_TOKEN)