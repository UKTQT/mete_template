#!/bin/bash

set -e

echo "🔄 update_dependencies.sh başlatılıyor..."

# 1. Flutter bağımlılıklarını güncelle
echo "📦 Flutter bağımlılıkları güncelleniyor..."
flutter pub get

# 2. Bağımlılıkları kontrol et ve güncel olmayanları güncelle
echo "📈 Bağımlılık güncellemeleri kontrol ediliyor..."
flutter pub upgrade

# 3. Pubspec dosyasını kontrol et ve hataları düzelt
echo "🔧 pubspec.yaml dosyası kontrol ediliyor..."
flutter pub outdated

# 4. Gereksiz bağımlılıkları temizle
echo "🧹 Gereksiz bağımlılıklar temizleniyor..."
flutter pub remove

# 5. Bağımlılıkların doğru şekilde yüklendiğini doğrula
echo "✅ Bağımlılıklar kontrol ediliyor..."
flutter pub get

# 6. Pubspec.lock dosyasını temizle (isteğe bağlı)
# Bu adım, pubspec.lock dosyasındaki eski bağımlılıkları temizlemek için kullanılabilir.
# flutter pub cache repair

# 7. Flutter bağımlılıkları ve paketlerin uyumluluğunu kontrol et
echo "🛠️ Flutter bağımlılıkları ve paket uyumluluğu kontrol ediliyor..."
flutter doctor

echo ""
echo "🎯 update_dependencies.sh tamamlandı. Bağımlılıklar başarıyla güncellendi."

