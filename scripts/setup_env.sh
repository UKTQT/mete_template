#!/bin/bash

set -e

echo "🛠️ setup_env.sh başlatılıyor..."

# 1. Ortam değişkenlerini .env dosyasından yükle
if [ -f .env ]; then
  echo "📄 .env dosyası bulundu, ortam değişkenleri yükleniyor..."
  export $(grep -v '^#' .env | xargs)
else
  echo "⚠️ .env dosyası bulunamadı, gerekli ortam değişkenleri manuel olarak ayarlanacak."
fi

# 2. Flutter SDK yolunun ayarlanması (gerekirse)
if [ -z "$FLUTTER_HOME" ]; then
  echo "🔧 Flutter SDK yolu belirlenmedi. Flutter SDK kurulumu yapılacak..."
  export FLUTTER_HOME="/path/to/flutter" # Flutter SDK yolu buraya eklenmeli
  export PATH="$FLUTTER_HOME/bin:$PATH"
else
  echo "✅ FLUTTER_HOME ortam değişkeni zaten ayarlı."
fi

# 3. Android SDK yolunun ayarlanması (gerekirse)
if [ -z "$ANDROID_SDK_ROOT" ]; then
  echo "🔧 Android SDK yolu belirlenmedi. Android SDK kurulumu yapılacak..."
  export ANDROID_SDK_ROOT="/path/to/android/sdk" # Android SDK yolu buraya eklenmeli
  export PATH="$ANDROID_SDK_ROOT/tools:$ANDROID_SDK_ROOT/platform-tools:$PATH"
else
  echo "✅ ANDROID_SDK_ROOT ortam değişkeni zaten ayarlı."
fi

# 4. Dart ve Flutter sürümünü kontrol et
echo "⚙️ Flutter ve Dart sürümleri kontrol ediliyor..."
flutter doctor

# 5. Bağımlılıkları kontrol et ve güncelle
echo "🔄 Flutter bağımlılıkları güncelleniyor..."
flutter pub get

# 6. Android için yerel emülatörü başlat
# (Opsiyonel) Bu adım, bir Android emülatörü başlatmak için kullanılabilir.
# echo "📱 Android emülatörü başlatılıyor..."
# flutter emulators --launch <emulator_id>

# 7. Xcode için yapılandırma (macOS için)
# (Opsiyonel) Eğer Xcode kurulumu yapılacaksa, bu adımı kullanabilirsiniz.
# echo "📱 Xcode güncelleniyor..."
# sudo gem install cocoapods
# flutter doctor --ios

# 8. Firebase veya diğer API anahtarları gibi özel ortam ayarları yapılabilir
# (Opsiyonel) Bu bölümü ihtiyaca göre özelleştirebilirsiniz.

echo ""
echo "🎯 setup_env.sh tamamlandı. Ortam değişkenleri başarıyla yüklendi."

