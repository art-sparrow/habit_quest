icons:
		flutter pub run flutter_launcher_icons

splash:
		dart run flutter_native_splash:create

gen:
		dart run build_runner build --delete-conflicting-outputs

fmt:
		dart fix --apply && dart format lib test 

apk:
		flutter build apk --target=lib/main_production.dart -vv

dev-apk:
		flutter build apk --target=lib/main_development.dart -vv

aab:
		flutter build appbundle --target=lib/main_production.dart

obfuscate-apk:
		flutter build apk --target=lib/main_production.dart --obfuscate --split-debug-info=build/app/outputs/symbols

obfuscate-aab:
		flutter build appbundle --target=lib/main_production.dart --obfuscate --split-debug-info=build/app/outputs/symbols

ipa:
		flutter build ipa --target=lib/main_production.dart

rdr:
		flutter run --target=lib/main_development.dart --release

rpr:
		flutter run --target=lib/main_production.dart --release

pods:
		cd ios && pod install --repo-update --verbose && cd ..

.PHONY: git_push
git_push:
		dart fix --apply && dart format lib test 
		dart format --set-exit-if-changed lib test
		flutter analyze lib
		git add .
		git commit -m "Resolve linting errors"
		git push
