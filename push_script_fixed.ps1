Write-Host "Nettoyage du dépôt Git corrompu..."
Remove-Item -Recurse -Force .git
git init
git branch -m main
git remote add origin https://github.com/MohammedFaris11/tracker_Flutter.git

Write-Host "Correction du .gitignore..."
Add-Content -Path .gitignore -Value "`n# Flutter ignores`nbuild/`n.dart_tool/`n.idea/`n.vscode/`n*.iml`n"

Write-Host "Commit 1: Setup & Core..."
git add .
git reset HEAD lib/data/repositories/auth_repository.dart
git reset HEAD lib/data/repositories/vehicle_repository.dart
git reset HEAD lib/data/repositories/fuel_entry_repository.dart
git reset HEAD lib/data/repositories/maintenance_category_repository.dart
git reset HEAD lib/data/repositories/maintenance_repository.dart

git commit -m "chore: Initial setup and Firebase core"
git push -u -f origin main
Write-Host "Attente de 2 minutes..."
Start-Sleep -Seconds 120

Write-Host "Commit 2: Auth Service..."
git add lib/data/repositories/auth_repository.dart
git commit -m "feat: Add Auth Service"
git push origin main
Write-Host "Attente de 2 minutes..."
Start-Sleep -Seconds 120

Write-Host "Commit 3: Vehicle Service..."
git add lib/data/repositories/vehicle_repository.dart
git commit -m "feat: Add Vehicle Service"
git push origin main
Write-Host "Attente de 2 minutes..."
Start-Sleep -Seconds 120

Write-Host "Commit 4: Fuel Service..."
git add lib/data/repositories/fuel_entry_repository.dart
git commit -m "feat: Add Fuel Service"
git push origin main
Write-Host "Attente de 2 minutes..."
Start-Sleep -Seconds 120

Write-Host "Commit 5: Maintenance Category Service..."
git add lib/data/repositories/maintenance_category_repository.dart
git commit -m "feat: Add Maintenance Category Service"
git push origin main
Write-Host "Attente de 2 minutes..."
Start-Sleep -Seconds 120

Write-Host "Commit 6: Maintenance Service..."
git add lib/data/repositories/maintenance_repository.dart
git commit -m "feat: Add Maintenance Service"
git push origin main

Write-Host "Terminé!"
