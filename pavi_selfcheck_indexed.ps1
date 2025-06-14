# ML-INSTRUMENTED
# pavi_selfcheck_indexed.ps1
# Instant, index-driven self-check for Pavi using precomputed pavi_state_index.json

$indexPath = './pavi_state_index.json'
$ok = $true

Write-Host '== Pavi Self-Check (Indexed) =='

if (!(Test-Path $indexPath)) {
    Write-Host "[FAIL] State index missing: $indexPath" -ForegroundColor Red
    $ok = $false
    return
}

try {
    $index = Get-Content $indexPath -Raw | ConvertFrom-Json
    Write-Host "[OK] State index loaded." -ForegroundColor Green
} catch {
    Write-Host "[FAIL] State index not valid JSON: $_" -ForegroundColor Red
    $ok = $false
    return
}

foreach ($item in $index.PSObject.Properties) {
    $name = $item.Name
    $meta = $item.Value

    if ($meta.required -eq $true) {
        if ($meta.status -eq 'present') {
            Write-Host "[OK] $name present." -ForegroundColor Green
        } else {
            Write-Host "[FAIL] $name missing." -ForegroundColor Red
            $ok = $false
        }
    }

    # ML-instrumentation check and debug
    if ($name -like '*.ps1' -or $name -like '*.py') {
        if (Test-Path $name) {
            $content = Get-Content $name -Raw
            Write-Host "DEBUG content for ${name}:" -ForegroundColor Cyan
            Write-Host $content -ForegroundColor White
            # Ensure .instrumented property exists before assignment
            if (-not ($meta.PSObject.Properties.Name -contains 'instrumented')) {
                $meta | Add-Member -MemberType NoteProperty -Name instrumented -Value $false
            }
            # Simple instrumentation check
            if ($content -match '# ML-INSTRUMENTED') {
                $meta.instrumented = $true
            } else {
                $meta.instrumented = $false
            }
        } else {
            Write-Host "[WARN] $name not found on disk for instrumentation check." -ForegroundColor Yellow
            if (-not ($meta.PSObject.Properties.Name -contains 'instrumented')) {
                $meta | Add-Member -MemberType NoteProperty -Name instrumented -Value $false
            }
            $meta.instrumented = $false
        }

        if ($meta.instrumented -eq $true) {
            Write-Host "[OK] $name ML-instrumented." -ForegroundColor Green
        } else {
            Write-Host "[WARN] $name NOT ML-instrumented." -ForegroundColor Yellow
            $ok = $false
        }
    }

    # Last log status
    if ($meta.PSObject.Properties.Name -contains 'last_result' -and $meta.last_result -match 'fail|error') {
        Write-Host "[WARN] $name last log result: $($meta.last_result)" -ForegroundColor Yellow
    }
}

if ($ok) {
    Write-Host "[Pavi] STATUS: Indexed self-check PASSED. All required states correct." -ForegroundColor Cyan
    Write-Host "[Pavi] Ready for your next command. No action needed if you see this message!" -ForegroundColor Green
} else {
    Write-Host "[Pavi] STATUS: Indexed self-check FAILED. See above." -ForegroundColor Red
    Write-Host "[Pavi] Ready for your next command. No action needed if you see this message!" -ForegroundColor Green
}
