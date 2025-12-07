# Valify eKYC Integration Guide

## 📋 Overview

This document describes the Valify SDK integration with the EHDI Wallet application for electronic Know Your Customer (eKYC) verification and claims management.

## 🔑 Configuration

### Valify Credentials (Sandbox)

```dart
Base URL: https://www.valifystage.com
Bundle Key: b2978014d0b94653be8da42d5d99058b
Client ID: lwsx7HOCt5o3bm6QmxBb3F3TExi72drzayCIZOnh
Username: healthflow__79742_integration_bundle
```

**Location:** `lib/core/config/valify_config.dart`

## 🏗️ Architecture

### Service Layer
**File:** `lib/core/services/valify_service.dart`

The `ValifyService` is a singleton that handles:
- OAuth 2.0 authentication with token management
- Secure token storage using Flutter Secure Storage
- All eKYC API calls with error handling
- Automatic token refresh

### Key Methods

```dart
// Initialize service
await ValifyService().initialize();

// Get OAuth token
String token = await ValifyService().getAccessToken();

// National ID OCR
var result = await ValifyService().performNationalIdOcr(imageBytes);

// Liveness Detection
var result = await ValifyService().performLiveness(videoBytes);

// Face Matching
var result = await ValifyService().performFaceMatch(
  nidPhotoBytes,
  selfieBytes,
);

// NID Validation
var result = await ValifyService().validateNID(nationalId);
```

## 🎯 Features

### 1. eKYC Verification Flow

**Screens:** `lib/features/kyc/screens/`

The eKYC verification is a 4-step wizard:

1. **Front ID Capture** - Scan/upload front of national ID
2. **Back ID Capture** - Scan/upload back of national ID
3. **Selfie Capture** - Take selfie for liveness detection
4. **Verification** - Display results and confidence scores

**Usage:**
```dart
Navigator.push(context, MaterialPageRoute(
  builder: (_) => const EkycVerificationScreen(),
));
```

### 2. Claims Management

**Screens:** `lib/features/claims/screens/`

#### Claims List Screen
- Tabbed view: All / Pending / Approved / Rejected
- Summary card with statistics
- Filter and search functionality
- Claim status timeline

#### Claim Detail Screen
- Full claim information
- Status timeline with dates
- Amount breakdown
- Service items list
- Appeal option for rejected claims

#### Submit Claim Screen
- 6-step wizard for claim submission
- Service item selection
- Attachment upload
- Amount calculation
- Confirmation and submission

**Usage:**
```dart
Navigator.push(context, MaterialPageRoute(
  builder: (_) => const ClaimsScreen(),
));
```

## 📦 Dependencies

Key packages added for Valify integration:

```yaml
# Camera & Document Scanning
camera: ^0.10.5+7
image_picker: ^1.0.7
image: ^4.1.4

# Forms & Validation
flutter_form_builder: ^9.1.1
form_builder_validators: ^9.1.0

# File Handling
file_picker: ^6.1.1
path_provider: ^2.1.2

# Encryption
encrypt: ^5.0.3
```

## 🔒 Security Features

1. **Token Management**
   - Secure storage of OAuth tokens
   - Automatic token refresh before expiry
   - Secure token deletion on logout

2. **Data Encryption**
   - Encrypted API communication
   - Secure storage of sensitive data
   - HMAC signature verification

3. **Permissions**
   - Camera access for ID and selfie capture
   - File system access for document upload
   - Microphone access for video recording

## 🚀 Usage Examples

### Initialize Valify Service

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Valify
  await ValifyService().initialize();
  
  runApp(const EHDIWalletApp());
}
```

### Perform eKYC Verification

```dart
import 'package:ehdi_wallet/ehdi_valify_claims.dart';

// In your widget
final valifyService = ValifyService();

// Get access token
String token = await valifyService.getAccessToken();

// Perform National ID OCR
var ocrResult = await valifyService.performNationalIdOcr(imageBytes);

// Perform Liveness Detection
var livenessResult = await valifyService.performLiveness(videoBytes);

// Perform Face Match
var faceMatchResult = await valifyService.performFaceMatch(
  nidPhotoBytes,
  selfieBytes,
);
```

### Access Claims

```dart
// Navigate to Claims Screen
Navigator.push(context, MaterialPageRoute(
  builder: (_) => const ClaimsScreen(),
));

// Submit a new claim
Navigator.push(context, MaterialPageRoute(
  builder: (_) => const SubmitClaimScreen(),
));
```

## 📱 Screens Overview

### eKYC Verification Screens
- `EkycVerificationScreen` - Main wizard container
- `IdFrontCaptureScreen` - Front ID capture
- `IdBackCaptureScreen` - Back ID capture
- `SelfieVerificationScreen` - Selfie and liveness
- `VerificationResultsScreen` - Results display

### Claims Screens
- `ClaimsScreen` - Main claims list with tabs
- `ClaimDetailScreen` - Detailed claim view
- `SubmitClaimScreen` - New claim submission wizard

## 🧪 Testing

### Unit Tests
```bash
flutter test
```

### Integration Tests
```bash
flutter test integration_test/
```

### Manual Testing Checklist
- [ ] OAuth token generation and refresh
- [ ] National ID OCR accuracy
- [ ] Liveness detection functionality
- [ ] Face matching accuracy
- [ ] Claims submission and retrieval
- [ ] Error handling and user feedback
- [ ] Arabic/English localization
- [ ] Offline mode handling

## 🐛 Error Handling

The service includes comprehensive error handling:

```dart
try {
  var result = await ValifyService().performNationalIdOcr(imageBytes);
} on DioException catch (e) {
  // Handle network errors
  print('Network error: ${e.message}');
} on Exception catch (e) {
  // Handle other errors
  print('Error: $e');
}
```

## 📊 API Response Models

### eKYC Response
```dart
{
  "success": true,
  "data": {
    "confidence": 0.95,
    "details": {...}
  }
}
```

### Claims Response
```dart
{
  "claims": [
    {
      "id": "CLM001",
      "status": "approved",
      "amount": 1500.00,
      "date": "2025-01-15"
    }
  ]
}
```

## 🔗 Integration Points

### With Main App
- Valify service is initialized in `main.dart`
- Claims feature integrated in navigation router
- eKYC flow accessible from settings/profile

### With Backend
- All API calls go through Dio HTTP client
- OAuth tokens managed securely
- Error responses handled consistently

## 📚 Resources

- [Valify Documentation](https://www.valify.com/docs)
- [Flutter Camera Plugin](https://pub.dev/packages/camera)
- [Flutter Secure Storage](https://pub.dev/packages/flutter_secure_storage)

## 🆘 Troubleshooting

### Token Expiry Issues
- Ensure system time is correct
- Check token refresh mechanism
- Clear cached tokens if needed

### Camera Permission Issues
- Verify permissions in AndroidManifest.xml
- Check iOS Info.plist configuration
- Request permissions at runtime

### API Errors
- Verify Valify credentials in config
- Check network connectivity
- Review API response in logs

## 📝 Notes

- All credentials are stored securely using Flutter Secure Storage
- API calls include automatic retry logic
- Comprehensive logging for debugging
- Full Arabic/English localization support

---

**Last Updated:** December 2025
**Version:** 1.0.0
