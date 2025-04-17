#!/bin/bash

set -e

echo "🔨 pre_commit.sh başlatılıyor..."

# 1. Git'in çalıştığı dizin üzerinden tüm değişiklikleri kontrol et
CHANGED_FILES=$(git diff --cached --name-only --diff-filter=ACM)

# 2. Eğer değişiklik varsa, formatlama ve lint işlemleri yap
if [[ -n "$CHANGED_FILES" ]]; then
  echo "📝 Değişiklik yapılan dosyalar:"

  # Dosyaları listeler
  echo "$CHANGED_FILES"
  
  echo ""
  echo "🎨 Formatlama işlemi başlatılıyor..."
  dart format --set-exit-if-changed .

  echo "⚙️ Linter kontrolü başlatılıyor..."
  flutter analyze --no-fatal-infos
  
  # Eğer bir hata bulunursa, commit işlemini engelle
  if [ $? -ne 0 ]; then
    echo "❌ Kodda hata veya uyarı bulundu. Commit işlemi iptal ediliyor!"
    exit 1
  else
    echo "✅ Formatlama ve lint kontrolleri başarılı, commit işlemi devam ediyor."
  fi
else
  echo "💡 Commit edilecek dosya bulunamadı, işlem atlanıyor."
fi

echo ""
echo "🎯 pre_commit.sh tamamlandı."
