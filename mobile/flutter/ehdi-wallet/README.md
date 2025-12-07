# EHDI Wallet - محفظة الهوية الصحية المصرية

Egyptian Healthcare Digital Identity Wallet - A Flutter mobile application for managing healthcare credentials, digital prescriptions, and health insurance in Egypt.

## 📱 Features

### 🆔 Digital Identity
- **Health ID Card**: Display and share your Egyptian Health ID via QR code
- **National ID Integration**: 14-digit Egyptian National ID validation and parsing
- **Biometric Authentication**: Fingerprint and Face ID support

### 📋 Credentials Management
- **Multiple Credential Types**: Health ID, Medical License, Pharmacy License, Insurance Card, Vaccination Record
- **Status Tracking**: Active, Pending, Expired, Revoked states
- **QR Code Sharing**: Share credentials via QR code with healthcare providers

### 💊 Digital Prescriptions
- **Active Prescriptions**: View and manage current prescriptions
- **Medication Details**: Dosage, frequency, duration, and instructions
- **Pharmacy Dispensing**: Share prescriptions with pharmacies
- **Refill Tracking**: Monitor remaining refills

### ⚙️ Settings & Preferences
- **Bilingual Support**: Arabic (RTL) and English
- **Theme Modes**: Light, Dark, and System default
- **Security Settings**: PIN, Biometric, Two-Factor Authentication

## 🏛️ Egyptian Healthcare Integration

Designed for Egypt's healthcare ecosystem with integration points for:

- **EDA** (Egyptian Drug Authority - هيئة الدواء المصرية)
- **FRA** (Financial Regulatory Authority - الهيئة العامة للرقابة المالية)
- **MOH** (Ministry of Health - وزارة الصحة والسكان)
- **UHIA** (Universal Health Insurance Authority - الهيئة العامة للتأمين الصحي الشامل)

## 🚀 Getting Started

### Prerequisites

- Flutter SDK >= 3.2.0
- Dart SDK >= 3.2.0
- Android Studio / Xcode
- iOS 12.0+ / Android 5.0+

### Installation

1. Clone the repository:
```bash
git clone https://github.com/HealthFlow-Medical-HCX/ehdi-wallet.git
cd ehdi_wallet
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

### Build for Production

**Android:**
```bash
flutter build apk --release
# or for App Bundle
flutter build appbundle --release
```

**iOS:**
```bash
flutter build ios --release
```

## 📁 Project Structure

```
lib/
├── main.dart                    # App entry point
├── core/
│   ├── api/                     # API clients and services
│   ├── config/
│   │   ├── app_config.dart      # App configuration
│   │   └── router_config.dart   # Navigation routes
│   ├── theme/
│   │   └── app_theme.dart       # Theme and styling
│   └── utils/                   # Utilities
├── features/
│   ├── auth/
│   │   ├── screens/
│   │   │   ├── splash_screen.dart
│   │   │   ├── onboarding_screen.dart
│   │   │   ├── login_screen.dart
│   │   │   ├── national_id_screen.dart
│   │   │   └── biometric_setup_screen.dart
│   │   └── widgets/
│   │       └── national_id_input.dart
│   ├── home/
│   │   ├── screens/
│   │   │   ├── main_shell.dart
│   │   │   └── home_screen.dart
│   │   └── widgets/
│   │       ├── health_id_card.dart
│   │       ├── quick_action_button.dart
│   │       └── recent_activity_item.dart
│   ├── credentials/
│   │   ├── models/
│   │   │   └── credential.dart
│   │   ├── screens/
│   │   │   ├── credentials_screen.dart
│   │   │   ├── credential_detail_screen.dart
│   │   │   └── add_credential_screen.dart
│   │   └── widgets/
│   │       └── credential_card.dart
│   ├── prescriptions/
│   │   └── screens/
│   │       ├── prescriptions_screen.dart
│   │       └── prescription_detail_screen.dart
│   └── settings/
│       └── screens/
│           ├── settings_screen.dart
│           ├── profile_screen.dart
│           ├── security_screen.dart
│           └── language_screen.dart
└── l10n/
    └── app_localizations.dart   # Translations
```

## 🎨 Design System

### Colors
- **Primary**: Egyptian Teal (#008B8B)
- **Secondary**: Egyptian Gold (#D4AF37)
- **Accent**: Healthcare Green (#2ECC71)

### Typography
- **Arabic**: Cairo font family
- **English**: IBM Plex Sans Arabic

### Components
- Custom Health ID Card with QR code
- Animated credential cards
- RTL-aware layouts

## 🔒 Security Features

- Secure storage for credentials (flutter_secure_storage)
- Biometric authentication (local_auth)
- PIN code protection
- Session timeout
- Encrypted API communication

## 📦 Key Dependencies

| Package | Purpose |
|---------|---------|
| flutter_riverpod | State management |
| go_router | Navigation |
| dio | HTTP client |
| flutter_secure_storage | Secure storage |
| local_auth | Biometric auth |
| qr_flutter | QR code generation |
| mobile_scanner | QR code scanning |
| flutter_animate | Animations |
| iconsax | Icons |
| google_fonts | Typography |
| intl | Internationalization |

## 🌍 Localization

Supports Arabic (primary) and English:

```dart
// Access translations
final l10n = AppLocalizations.of(context);
Text(l10n.translate('home'));
```

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🏥 About HealthFlow

HealthFlow Group is a healthcare RegTech company developing digital health infrastructure for Egypt's healthcare ecosystem, serving 105+ million citizens.

---

**محفظة الهوية الرقمية للرعاية الصحية المصرية** - مبنية بـ Flutter 💙
