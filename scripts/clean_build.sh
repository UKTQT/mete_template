#!/bin/bash

set -e

echo "🧼 clean_build.sh başlatılıyor..."

# 1. Flutter clean
echo ""
echo "🧹 Adım 1: flutter clean çalıştırılıyor..."
flutter clean
echo "✅ flutter clean tamamlandı."

# 2. .dart_tool ve build klasörlerini manuel sil
echo ""
echo "🗑️  Adım 2: .dart_tool ve build klasörleri temizleniyor..."
rm -rf .dart_tool build
echo "✅ Klasörler başarıyla silindi."

# 3. Pub get
echo ""
echo "📦 Adım 3: Bağımlılıklar yükleniyor (flutter pub get)..."
flutter pub get
echo "✅ Bağımlılıklar başarıyla yüklendi."

# 4. Flutter pub cache temizliği (opsiyonel)
echo ""
echo "🧽 Adım 4: flutter pub cache temizleniyor (opsiyonel)"
flutter pub cache repair || echo "ℹ️  flutter pub cache repair opsiyonel veya başarısız oldu, devam ediliyor."

# 5. build_runner dosyalarını sil (varsa)
echo ""
echo "🧨 Adım 5: build_runner generated dosyalar temizleniyor..."
find . -name "*.g.dart" -type f -delete
find . -name "*.freezed.dart" -type f -delete
find . -name "*.gr.dart" -type f -delete
echo "✅ build_runner dosyaları silindi."

echo ""
echo "🎯 clean_build.sh başarıyla tamamlandı. Proje temiz ve hazır."
