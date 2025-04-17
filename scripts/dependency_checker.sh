#!/bin/bash

set -e

echo "🔍 dependency_checker.sh çalıştırılıyor..."

# 1. pubspec.lock kontrolü
echo ""
echo "📄 Adım 1: pubspec.lock dosyası kontrol ediliyor..."
if [ ! -f "pubspec.lock" ]; then
  echo "❗ pubspec.lock bulunamadı. flutter pub get çalıştırılıyor..."
  flutter pub get
fi
echo "✅ pubspec.lock mevcut."

# 2. outdated komutu ile güncel olmayan paketlerin listelenmesi
echo ""
echo "📦 Adım 2: Güncel olmayan bağımlılıklar listeleniyor..."
flutter pub outdated

# 3. Renkli çıktı (opsiyonel)
echo ""
echo "🎯 Mevcut bağımlılık sürümleri yukarıda listelendi."
echo "🔧 Güncellenmesi gereken bağımlılıklar varsa 'flutter pub upgrade' komutu ile güncelleyebilirsin."

# 4. Opsiyonel: sadece outdated olan paketleri göstermek için filtreleme yapılabilir.
# Bunun için json çıktı alınabilir:
# flutter pub outdated --json | jq .

echo ""
echo "✅ dependency_checker.sh tamamlandı."
