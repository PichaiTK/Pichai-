<#
.SYNOPSIS
  add_license.ps1 - Create LICENSE (MIT) and push branch + create PR via gh (optional)

.USAGE
  .\add_license.ps1 [-Base <string>] [-Force]
#>

param(
  [string]$Base = "",
  [switch]$Force
)

if (-not (Test-Path ".git")) {
  Write-Error "Not a git repository (no .git). Run this script from the repo root."
  exit 1
}

# Find default branch (try origin/HEAD)
$defaultBranch = $Base
if (-not $defaultBranch) {
  try {
    $remoteHead = git remote show origin 2>$null | Select-String "HEAD branch" -SimpleMatch
    if ($remoteHead) {
      $defaultBranch = ($remoteHead -replace '.*HEAD branch: ','').Trim()
    } else {
      if (git show-ref --verify --quiet refs/heads/main) { $defaultBranch = "main" }
      elseif (git show-ref --verify --quiet refs/heads/master) { $defaultBranch = "master" }
    }
  } catch {}
}

if (-not $defaultBranch) { Write-Error "Cannot detect base branch. Provide -Base <branch>"; exit 1 }

Write-Host "Using base branch: $defaultBranch"

$ts = [int][double]::Parse((Get-Date -UFormat %s))
$branch = "add/license-mit-$ts"

git fetch origin $defaultBranch 2>$null
git checkout -b $branch

if ((Test-Path "LICENSE") -and -not $Force) {
  Write-Error "LICENSE already exists. Use -Force to overwrite."
  exit 1
}

$licenseText = @'
MIT License

Copyright (c) 2025 PichaiTK

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
'@

Set-Content -Path LICENSE -Value $licenseText -Encoding UTF8

git add LICENSE
git commit -m "chore: add MIT license (Copyright 2025 PichaiTK)"
git push -u origin $branch

Write-Host "Pushed branch $branch."

if (Get-Command gh -ErrorAction SilentlyContinue) {
  gh pr create --title "Add MIT License" --body "Add MIT License (Copyright 2025 PichaiTK)." --base $defaultBranch --head $branch
  Write-Host "PR created via gh CLI (if authenticated)."
} else {
  Write-Host "gh CLI not found. Create a PR manually at https://github.com/PichaiTK/myapp-multiplatform/pull/new/$branch?base=$defaultBranch"
}
