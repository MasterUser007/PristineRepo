Write-Host "🛠 Running repository health check..."

# Verify Repository Status
On branch main Changes not staged for commit:   (use "git add <file>..." to update what will be committed)   (use "git restore <file>..." to discard changes in working directory)   (commit or discard the untracked or modified content in submodules) 	modified:   clean_exosuite_clone (modified content)  Untracked files:   (use "git add <file>..." to include in what will be committed) 	.github/ 	job47_error.log 	job_37_error.log 	job_39_error.log 	job_41_error.log 	job_43_error.log 	job_45_error.log 	job_47_error.log 	job_49_error.log 	job_53_error.log 	job_55_error.log 	job_57_error.log 	job_59_error.log 	job_61_error.log 	security_harden.ps1 	setup.ps1  no changes added to commit (use "git add" and/or "git commit -a") = git status
Write-Host "📌 Repo Status: 
On branch main Changes not staged for commit:   (use "git add <file>..." to update what will be committed)   (use "git restore <file>..." to discard changes in working directory)   (commit or discard the untracked or modified content in submodules) 	modified:   clean_exosuite_clone (modified content)  Untracked files:   (use "git add <file>..." to include in what will be committed) 	.github/ 	job47_error.log 	job_37_error.log 	job_39_error.log 	job_41_error.log 	job_43_error.log 	job_45_error.log 	job_47_error.log 	job_49_error.log 	job_53_error.log 	job_55_error.log 	job_57_error.log 	job_59_error.log 	job_61_error.log 	security_harden.ps1 	setup.ps1  no changes added to commit (use "git add" and/or "git commit -a")"

# Detect Uncommitted Changes & Auto-Stage
if (On branch main Changes not staged for commit:   (use "git add <file>..." to update what will be committed)   (use "git restore <file>..." to discard changes in working directory)   (commit or discard the untracked or modified content in submodules) 	modified:   clean_exosuite_clone (modified content)  Untracked files:   (use "git add <file>..." to include in what will be committed) 	.github/ 	job47_error.log 	job_37_error.log 	job_39_error.log 	job_41_error.log 	job_43_error.log 	job_45_error.log 	job_47_error.log 	job_49_error.log 	job_53_error.log 	job_55_error.log 	job_57_error.log 	job_59_error.log 	job_61_error.log 	security_harden.ps1 	setup.ps1  no changes added to commit (use "git add" and/or "git commit -a") -match "Changes not staged") {
    Write-Host "⚠ Uncommitted changes detected. Committing automatically..."
    git add .
    git commit -m "Auto-fix: Staged uncommitted changes"
}

Write-Host "✅ Repo health check completed!"
