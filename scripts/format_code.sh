#!/bin/bash

set -e

echo "🎨 format_code.sh başlatılıyor..."

# 1. Formatlanacak klasörlerin listesi
TARGET_DIRS=("lib" "test" "scripts" "tools" "example")

# 2. Her bir klasör için dart format çalıştır
for dir in "${TARGET_DIRS[@]}"; do
  if [ -d "$dir" ]; then
    echo ""
    echo "🧼 $dir klasörü formatlanıyor..."
    dart format "$dir"
    echo "✅ $dir klasörü başarıyla formatlandı."
  else
    echo ""
    echo "⚠️  $dir klasörü bulunamadı, atlanıyor."
  fi
done

# 3. Bitirme mesajı
echo ""
echo "🎯 Tüm uygun dosyalar formatlandı. Kodun mis gibi oldu!"

