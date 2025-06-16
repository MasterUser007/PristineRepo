# Repo Hygiene Script (auto-generated)
Get-ChildItem -Path "$PWD\clean_exosuite_clone" -Recurse -Directory -Filter "__pycache__" | Remove-Item -Recurse -Force
Get-ChildItem -Path "$PWD\clean_exosuite_clone" -Recurse -Include *.pyc -File | Remove-Item -Force
Invoke-Expression "autoflake --in-place --remove-unused-variables --remove-all-unused-imports --recursive clean_exosuite_clone"
Invoke-Expression "black clean_exosuite_clone"
$env:PYTHONPATH = "$PWD\clean_exosuite_clone\src;$PWD\clean_exosuite_clone\ExoSuite"
Invoke-Expression "flake8 clean_exosuite_clone"
Invoke-Expression "pytest clean_exosuite_clone"
