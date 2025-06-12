#!/bin/bash

echo "======== Flutter temizleniyor..."
flutter clean

echo "======== Pub bağımlılıkları alınıyor..."
flutter pub get

echo "======== iOS klasörüne geçiliyor..."
cd ios || { echo "❌ ios klasörü bulunamadı!"; exit 1; }

echo "======== Podlar kaldırılıyor..."
pod deintegrate

echo "======== Podlar tekrar yükleniyor..."
pod install

echo "======== Ana dizine dönülüyor..."
cd ..

echo "======== Pub bağımlılıkları yeniden alınıyor..."
flutter pub get

echo "======== Tüm işlemler başarıyla tamamlandı."