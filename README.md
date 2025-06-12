# Mete Template Flutter Uygulaması

**Bundle Identifier:** `com.nectrom.metetemplate`

---

## İçindekiler

1. [Önkoşullar](#önko%C5%9Fluklar)
2. [Flutter Kurulumu](#flutter-kurulumu)
3. [Emülatör / Simulator Hazırlığı](#em%C3%BClat%C3%B6r--simulator-haz%C4%B1rl%C4%B1%C4%9F%C4%B1)
4. [VS Code ile Projeyi Çalıştırma](#vs-code-ile-projeyi-%C3%A7al%C4%B1%C5%9Ft%C4%B1rma)
5. [Çevresel Değişkenler (](#%C3%A7evresel-de%C4%9Fi%C5%9Kenler-env)[`.env`](#%C3%A7evresel-de%C4%9Fi%C5%9Kenler-env)[)](#%C3%A7evresel-de%C4%9Fi%C5%9Kenler-env)
6. [Geliştirici Sürüm Notları](#geli%C5%9Ftirici-s%C3%BCr%C3%BCm-notlar%C4%B1)
7. [İletişim](#ileti%C5%9Fim)

---

## Önkoşullar

- Git ve temel komut satırı araçları
- VS Code veya tercih ettiğiniz bir IDE
- Android Studio (Windows için) veya Xcode (macOS için)
- İnternet bağlantısı

---

## Flutter Kurulumu

1. [Flutter’ın resmi kurulum kılavuzuna](https://docs.flutter.dev/get-started/install) gidin.
2. İşletim sisteminize uygun adımları takip ederek SDK’yı indirin ve PATH ortam değişkenine ekleyin.
3. Kurulumu doğrulamak için terminalde çalıştırın:
   ```bash
   flutter doctor
   ```
4. Eksik bileşen veya lisans onayı varsa `flutter doctor --android-licenses` gibi komutlarla tamamlayın.

---

## Emülatör / Simulator Hazırlığı

### Windows (Android)

1. [Android Studio’yu indirin ve kurun](https://developer.android.com/studio?hl=tr).
2. Android Studio’da **AVD Manager**’ı açın.
3. Yeni bir sanal cihaz oluşturun ve indirme işlemi tamamlandıktan sonra başlatın.

### macOS (iOS)

1. [Xcode’u yükleyin](https://developer.apple.com/xcode/).
2. Xcode’u açın, **Window > Devices and Simulators** panelinden bir iOS Simulator ekleyin.
3. Oluşturduğunuz simülatörü seçip çalıştırın.

---

## VS Code ile Projeyi Çalıştırma

1. [VS Code’u indirin ve yükleyin](https://code.visualstudio.com/download).
2. VS Code’un **Extensions** bölümüne (Ctrl+Shift+X) gidip "Flutter" ve "Dart" eklentilerini yükleyin.
3. Komut paletini açın (F1 veya Ctrl+Shift+P) ve şu komutu çalıştırın:
   ```
   Flutter: Launch Emulator
   ```
   Oluşturduğunuz emülatörü seçip başlatın.
4. Projenin kök dizininde terminal açın ve aşağıdaki komutla uygulamayı başlatın:
   ```bash
   flutter run
   ```
   veya Debug modda başlatmak için F5 tuşuna basın.

---

## Çevresel Değişkenler (`.env`)

Uygulamayı çalıştırmadan önce proje kökünde yer alan `.env` dosyasını düzenleyin:

```dotenv
# Versiyon bilgisi (Major.Minor.Patch)
VERSION="0.0.1"

# Yayın tarihi (ISO 8601 formatı)
VERSION_DATE="2024-05-08T15:00:00"

# Platform seçimi: 0 = Android, 1 = iOS
OPERATION_SYSTEM="0"

# Sunucu adresi (örnek: 192.168.1.10/sgm/proxy)
SERVER_IP="EXAMPLE_IP/sgm/proxy"

# Çalışma modu: MARKET_MODE, DEV_MODE vb.
APP_RUNNING_MODE="MARKET_MODE"
```

---

## Geliştirici Sürüm Notları

| Versiyon  | Build No | Yayın Tarihi        | Geliştirici     | Platform |
| --------- | -------- | ------------------- | --------------- | -------- |
| **1.0.0** | **001**  | 2024-05-08T15:00:00 | Ufuk Küçüktopçu | Android  |

### Yenilikler

- Projeyi hızlı başlatmak için temel yapı taşları eklendi.
- Temiz mimariye uygun klasör düzeni sağlayan şablon oluşturuldu.

### Düzeltilen Hatalar

- Uygulama açılışındaki `null` hatası giderildi.
- Derleme sırasında ortaya çıkan hata mesajları düzenlendi.

### Bilinen Sorunlar

- Bazı JSON model sınıflarında eksik alan uyarısı alınabilir.

### Kaldırılan Özellikler

- Önceki sürüm notlarında yer alan örnek `Lorem Ipsum` bileşenleri çıkarıldı.

---

## İletişim

- 🌐 [NECTROM Resmi Web Sitesi](https://nectrom.com)
- ✉️ [ufuk@nectrom.com](mailto\:ufuk@nectrom.com)

> Projeyi kullanırken bir sorunla karşılaşırsanız lütfen geri bildirimde bulunun! 🚀

