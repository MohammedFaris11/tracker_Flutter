Write-Host "Fixing the commits..."
git rm --cached lib/data/repositories/auth_repository.dart
git rm --cached lib/data/repositories/vehicle_repository.dart
git rm --cached lib/data/repositories/fuel_entry_repository.dart
git rm --cached lib/data/repositories/maintenance_category_repository.dart
git rm --cached lib/data/repositories/maintenance_repository.dart

git commit --amend --no-edit
git push -f origin main

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
