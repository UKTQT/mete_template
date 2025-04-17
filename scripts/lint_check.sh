#!/bin/bash

set -e

echo "🔍 lint_check.sh başlatılıyor..."

# 1. flutter analyze komutunu çalıştır
echo ""
echo "📋 Kod analizi başlatılıyor..."
flutter analyze --no-fatal-infos

# 2. Eğer herhangi bir analiz hatası varsa, uyarı ver
if [ $? -ne 0 ]; then
  echo "❗ Kod analizinde hata veya uyarı bulundu. Detaylar yukarıda."
  exit 1
else
  echo "✅ Kod analizi başarılı, hiçbir hata veya uyarı bulunamadı."
fi

echo ""
echo "🎯 lint_check.sh tamamlandı."

