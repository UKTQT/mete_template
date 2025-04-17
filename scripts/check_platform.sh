#!/bin/bash

set -e

echo "🖥️ check_platform.sh başlatılıyor..."

# Platform bilgisini al
PLATFORM="$(uname)"

case "$PLATFORM" in
  "Darwin")
    echo "🍏 Platform: macOS"
    echo "📱 iOS build işlemleri yapılabilir."
    ;;
  "Linux")
    echo "🐧 Platform: Linux"
    echo "⚠️ iOS build desteklenmez. Sadece Android ve Web desteklenir."
    ;;
  "MINGW"* | "CYGWIN"* | "MSYS"*)
    echo "🪟 Platform: Windows"
    echo "⚠️ iOS build desteklenmez. Sadece Android ve Web desteklenir."
    ;;
  *)
    echo "❓ Platform tanımlanamadı: $PLATFORM"
    exit 1
    ;;
esac

echo "✅ Platform kontrolü tamamlandı."
