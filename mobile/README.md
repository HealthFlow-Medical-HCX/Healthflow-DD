# Mobile Applications

This directory contains mobile applications for the Egyptian Healthcare Digital Identity (EHDI) ecosystem.

## 📱 Applications

### Flutter

#### EHDI Wallet
**Location:** `flutter/ehdi-wallet/`

Egyptian Healthcare Digital Identity Wallet - A comprehensive Flutter mobile application for managing healthcare credentials, digital prescriptions, and health insurance in Egypt.

**Features:**
- 🆔 Digital Identity Management with Health ID Card
- 📋 Credentials Management (Health ID, Medical License, Insurance Card, etc.)
- 💊 Digital Prescriptions with pharmacy dispensing
- ⚙️ Settings with bilingual support (Arabic RTL + English)
- 🔒 Security features (biometric authentication, secure storage)
- 🎨 Egyptian healthcare branding (EDA, FRA, MOH integration)

**Quick Start:**
```bash
cd flutter/ehdi-wallet
flutter pub get
flutter run
```

**Build for Production:**
```bash
# Android
flutter build apk --release
flutter build appbundle --release

# iOS
flutter build ios --release
```

**Technology Stack:**
- Flutter 3.2.0+
- Dart 3.2.0+
- Riverpod (State Management)
- Go Router (Navigation)
- Dio (HTTP Client)
- Flutter Secure Storage (Security)
- Local Auth (Biometric)

**Documentation:**
- See `flutter/ehdi-wallet/README.md` for detailed documentation
- Architecture: Feature-based structure
- Localization: Arabic (RTL) and English
- Design System: Egyptian Teal, Egyptian Gold, Healthcare Green

## 🏗️ Project Structure

```
mobile/
├── flutter/
│   └── ehdi-wallet/          # EHDI Wallet Flutter App
│       ├── lib/              # Source code
│       ├── assets/           # Images, icons, fonts
│       ├── pubspec.yaml      # Dependencies
│       └── README.md         # App documentation
└── README.md                 # This file
```

## 📦 Dependencies

All mobile applications use industry-standard packages for:
- State management
- Navigation and routing
- HTTP communication
- Security and encryption
- Localization
- UI components and animations

See individual app `pubspec.yaml` for complete dependency list.

## 🔒 Security

All mobile applications implement:
- Secure credential storage (flutter_secure_storage)
- Biometric authentication (fingerprint, Face ID)
- Encrypted API communication
- Session timeout
- PIN code protection

## 🌍 Localization

Applications support:
- **Arabic** (Primary, RTL layout)
- **English** (Secondary, LTR layout)

## 📋 Development Guidelines

### Setup
1. Install Flutter SDK >= 3.2.0
2. Install Dart SDK >= 3.2.0
3. Clone the repository
4. Run `flutter pub get` in the app directory

### Testing
```bash
flutter test
```

### Code Analysis
```bash
flutter analyze
```

### Building
See individual app README for build instructions.

## 🤝 Contributing

1. Create a feature branch from `main`
2. Implement your changes
3. Test thoroughly
4. Submit a pull request

## 📄 License

All mobile applications are licensed under the MIT License.

## 🏥 About HealthFlow

HealthFlow Group is a healthcare RegTech company developing digital health infrastructure for Egypt's healthcare ecosystem.

---

**Last Updated:** December 2025
