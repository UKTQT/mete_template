#!/bin/bash

set -e

echo "🚀 build_runner.sh başlatılıyor..."

# 1. Pub get
echo "📦 Bağımlılıklar yükleniyor (flutter pub get)..."
flutter pub get
echo "✅ Bağımlılıklar yüklendi."

# 2. Önceki build_runner çıktıları temizleniyor
echo "🧹 Önceki build_runner çıktıları temizleniyor (flutter pub run build_runner clean)..."
flutter pub run build_runner clean
echo "✅ Temizleme tamamlandı."

# 3. Kod üretimi başlatılıyor
echo "🛠️ Kod üretimi başlatılıyor (build_runner watch --delete-conflicting-outputs)..."
flutter pub run build_runner build --delete-conflicting-outputs
echo "✅ Kod üretimi tamamlandı."

echo "🎉 build_runner.sh tamamlandı!"
