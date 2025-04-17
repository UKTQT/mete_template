#!/bin/bash

set -e

echo "🔍 check_nullsafety.sh başlatılıyor..."

# 1. flutter pub outdated ile null safety kontrolü
echo "📦 Null Safety uyumluluğu kontrol ediliyor (flutter pub outdated --mode=null-safety)..."
flutter pub outdated --mode=null-safety

echo "✅ Null Safety kontrolü tamamlandı."

echo "🎉 check_nullsafety.sh başarıyla çalıştı!"
