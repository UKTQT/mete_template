#!/bin/bash

set -e

echo "🚀 ci_build.sh başlatılıyor..."

# 1. Null Safety kontrolü
echo ""
echo "🔍 Adım 1: Null Safety uyumluluk kontrolü"
bash scripts/check_nullsafety.sh

# 2. Format kontrolü
echo ""
echo "🧹 Adım 2: Kod formatı kontrol ediliyor (flutter format --set-exit-if-changed)"
flutter format . --set-exit-if-changed
echo "✅ Kod formatı düzgün."

# 3. Lint kontrolü
echo ""
echo "🧪 Adım 3: Lint kontrolü başlatılıyor (flutter analyze)"
flutter analyze
echo "✅ Lint hatası yok."

# 4. Testler
echo ""
echo "🧪 Adım 4: Unit ve widget testleri çalıştırılıyor (flutter test)"
flutter test
echo "✅ Tüm testler başarıyla geçti."

# 5. Build Runner (eğer gerekliyse)
echo ""
echo "⚙️  Adım 5: build_runner çalıştırılıyor (optional)"
bash scripts/build_runner.sh || echo "ℹ️  build_runner opsiyonel veya başarısız oldu, devam ediliyor."

# 6. Platform kontrolü (informative)
echo ""
echo "🖥️  Adım 6: Platform kontrolü"
bash scripts/check_platform.sh

# 7. Flutter build (opsiyonel olarak release build yapılabilir)
echo ""
echo "📦 Adım 7: Build işlemi başlatılıyor (flutter build apk)"
flutter build apk --release
echo "✅ Release APK başarıyla oluşturuldu."

echo ""
echo "🎉 ci_build.sh tamamlandı. Proje başarılı şekilde test edildi ve build alındı."
