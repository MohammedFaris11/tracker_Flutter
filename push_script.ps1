Write-Host "Annulation du dernier commit..."
git reset HEAD~1

Write-Host "Commit 1: Setup & Core..."
git add pubspec.yaml pubspec.lock
git add android/app/build.gradle.kts android/settings.gradle.kts
git add firebase.json android/app/google-services.json lib/firebase_options.dart
git add lib/main.dart lib/providers/auth_provider.dart
git add macos/ windows/
git commit -m "chore: Firebase configuration and core setup"
git push -u origin main
Write-Host "Attente de 2 minutes..."
Start-Sleep -Seconds 120

Write-Host "Commit 2: Auth Service..."
git add lib/data/repositories/auth_repository.dart
git commit -m "feat: Migrate Auth Service to Firebase"
git push origin main
Write-Host "Attente de 2 minutes..."
Start-Sleep -Seconds 120

Write-Host "Commit 3: Vehicle Service..."
git add lib/data/repositories/vehicle_repository.dart
git commit -m "feat: Migrate Vehicle Service to Firebase"
git push origin main
Write-Host "Attente de 2 minutes..."
Start-Sleep -Seconds 120

Write-Host "Commit 4: Fuel Service..."
git add lib/data/repositories/fuel_entry_repository.dart
git commit -m "feat: Migrate Fuel Service to Firebase"
git push origin main
Write-Host "Attente de 2 minutes..."
Start-Sleep -Seconds 120

Write-Host "Commit 5: Maintenance Category Service..."
git add lib/data/repositories/maintenance_category_repository.dart
git commit -m "feat: Migrate Maintenance Category Service to Firebase"
git push origin main
Write-Host "Attente de 2 minutes..."
Start-Sleep -Seconds 120

Write-Host "Commit 6: Maintenance Service..."
git add lib/data/repositories/maintenance_repository.dart
git commit -m "feat: Migrate Maintenance Service to Firebase"
git push origin main

Write-Host "Commit 7: Remaining Changes..."
git add -A
git commit -m "chore: final repository updates"
git push origin main

Write-Host "Terminé!"
