#!/bin/bash

echo "======== Xcode DerivedData temizleniyor..."
rm -rf ~/Library/Developer/Xcode/DerivedData/*

echo "======== Flutter clean çalıştırılıyor..."
flutter clean

echo "======== pubspec.lock dosyası siliniyor..."
rm -f pubspec.lock

echo "======== iOS klasörüne geçiliyor..."
cd ios || { echo "❌ ios klasörü bulunamadı!"; exit 1; }

echo "======== Pods klasörü siliniyor..."
rm -rf Pods

echo "======== Podfile.lock siliniyor..."
rm -f Podfile.lock

echo "======== Pod deintegrate çalıştırılıyor..."
pod deintegrate

echo "======== Flutter bağımlılıkları yükleniyor..."
cd ..
flutter pub get

echo "======== Pod setup başlatılıyor..."
cd ios
pod setup

echo "======== Pod install çalıştırılıyor..."
pod install

echo "======== Tüm iOS temizlik ve kurulum işlemleri tamamlandı."
cd ..
