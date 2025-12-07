import 'package:flutter/foundation.dart';

/// App Configuration for EHDI Wallet
/// محفظة الهوية الرقمية للرعاية الصحية المصرية
class AppConfig {
  AppConfig._();
  
  // ==================== App Info ====================
  static const String appName = 'EHDI Wallet';
  static const String appNameAr = 'محفظة الهوية الصحية';
  static const String version = '1.0.0';
  static const String buildNumber = '1';
  
  // ==================== Environment ====================
  static const bool isProduction = bool.fromEnvironment('dart.vm.product');
  static const String environment = isProduction ? 'production' : 'development';
  
  // ==================== API Configuration ====================
  
  // Base URLs
  static const String baseUrl = isProduction
      ? 'https://api.ehdi.gov.eg/v1'
      : 'https://staging-api.ehdi.gov.eg/v1';
  
  // HCX Gateway
  static const String hcxGatewayUrl = isProduction
      ? 'https://hcx.healthflow.eg/api'
      : 'https://staging-hcx.healthflow.eg/api';
  
  // EDA (Egyptian Drug Authority) Integration
  static const String edaApiUrl = 'https://api.eda.gov.eg/v1';
  static const String edaMedicineDirectoryUrl = 'https://medicines.eda.gov.eg/api';
  
  // FRA (Financial Regulatory Authority) Integration
  static const String fraApiUrl = 'https://api.fra.gov.eg/v1';
  
  // ==================== Security Configuration ====================
  
  // API Timeouts
  static const int connectionTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 60000; // 60 seconds
  
  // Token Configuration
  static const int tokenRefreshThreshold = 300; // 5 minutes before expiry
  static const int sessionTimeout = 1800; // 30 minutes
  
  // Biometric
  static const int maxBiometricAttempts = 3;
  static const int biometricLockoutDuration = 300; // 5 minutes
  
  // PIN
  static const int pinLength = 6;
  static const int maxPinAttempts = 5;
  static const int pinLockoutDuration = 900; // 15 minutes
  
  // ==================== Egyptian National ID ====================
  
  // National ID Structure (14 digits)
  // Format: CYYMMDDGGSSSCV
  // C = Century (2=1900s, 3=2000s)
  // YY = Year of birth
  // MM = Month of birth
  // DD = Day of birth
  // GG = Governorate code
  // SSS = Sequence number
  // C = Check digit
  // V = Gender (odd=male, even=female)
  
  static const int nationalIdLength = 14;
  
  // Governorate Codes
  static const Map<String, String> governorateCodes = {
    '01': 'Cairo - القاهرة',
    '02': 'Alexandria - الإسكندرية',
    '03': 'Port Said - بورسعيد',
    '04': 'Suez - السويس',
    '11': 'Damietta - دمياط',
    '12': 'Dakahlia - الدقهلية',
    '13': 'Sharqia - الشرقية',
    '14': 'Qalyubia - القليوبية',
    '15': 'Kafr El Sheikh - كفر الشيخ',
    '16': 'Gharbia - الغربية',
    '17': 'Monufia - المنوفية',
    '18': 'Beheira - البحيرة',
    '19': 'Ismailia - الإسماعيلية',
    '21': 'Giza - الجيزة',
    '22': 'Beni Suef - بني سويف',
    '23': 'Fayoum - الفيوم',
    '24': 'Minya - المنيا',
    '25': 'Asyut - أسيوط',
    '26': 'Sohag - سوهاج',
    '27': 'Qena - قنا',
    '28': 'Aswan - أسوان',
    '29': 'Luxor - الأقصر',
    '31': 'Red Sea - البحر الأحمر',
    '32': 'New Valley - الوادي الجديد',
    '33': 'Matrouh - مطروح',
    '34': 'North Sinai - شمال سيناء',
    '35': 'South Sinai - جنوب سيناء',
    '88': 'Foreign - أجنبي',
  };
  
  // ==================== Healthcare Constants ====================
  
  // Credential Types
  static const List<String> credentialTypes = [
    'HEALTH_ID',           // الرقم الصحي
    'MEDICAL_LICENSE',     // رخصة مزاولة المهنة
    'PHARMACY_LICENSE',    // رخصة صيدلة
    'INSURANCE_CARD',      // بطاقة التأمين الصحي
    'PRESCRIPTION_AUTH',   // تصريح الوصفات الطبية
    'FACILITY_CREDENTIAL', // اعتماد المنشأة الصحية
    'VACCINATION_RECORD',  // سجل التطعيمات
    'EMERGENCY_ACCESS',    // بطاقة الطوارئ
  ];
  
  // Medical Specialties (Egyptian Medical Syndicate)
  static const List<String> medicalSpecialties = [
    'GENERAL_MEDICINE',
    'INTERNAL_MEDICINE',
    'CARDIOLOGY',
    'PEDIATRICS',
    'OBSTETRICS_GYNECOLOGY',
    'SURGERY',
    'ORTHOPEDICS',
    'NEUROLOGY',
    'PSYCHIATRY',
    'DERMATOLOGY',
    'OPHTHALMOLOGY',
    'ENT',
    'RADIOLOGY',
    'PATHOLOGY',
    'ANESTHESIOLOGY',
    'EMERGENCY_MEDICINE',
    'FAMILY_MEDICINE',
    'ONCOLOGY',
    'NEPHROLOGY',
    'GASTROENTEROLOGY',
  ];
  
  // Prescription Categories
  static const List<String> prescriptionCategories = [
    'GENERAL',           // أدوية عامة
    'CONTROLLED',        // مواد مراقبة
    'NARCOTIC',          // مخدرات
    'PSYCHOTROPIC',      // مؤثرات عقلية
    'ANTIBIOTIC',        // مضادات حيوية
    'CHRONIC',           // أدوية الأمراض المزمنة
  ];
  
  // ==================== UI Configuration ====================
  
  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 350);
  static const Duration longAnimation = Duration(milliseconds: 500);
  
  // Page Sizes
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
  
  // ==================== Storage Keys ====================
  
  static const String tokenKey = 'auth_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userKey = 'user_data';
  static const String credentialsKey = 'credentials';
  static const String settingsKey = 'settings';
  static const String biometricEnabledKey = 'biometric_enabled';
  static const String onboardingCompleteKey = 'onboarding_complete';
  static const String localeKey = 'locale';
  static const String themeModeKey = 'theme_mode';
  
  // ==================== Regex Patterns ====================
  
  // Egyptian National ID: 14 digits starting with 2 or 3
  static final RegExp nationalIdPattern = RegExp(r'^[23]\d{13}$');
  
  // Egyptian Phone: Starts with 01 (0, 1, 2, 5) followed by 8 digits
  static final RegExp phonePattern = RegExp(r'^01[0125]\d{8}$');
  
  // Egyptian Postal Code: 5 digits
  static final RegExp postalCodePattern = RegExp(r'^\d{5}$');
  
  // Medical License: EG-MED-XXXXXX
  static final RegExp medicalLicensePattern = RegExp(r'^EG-MED-\d{6}$');
  
  // Pharmacy License: EG-PHR-XXXXXX
  static final RegExp pharmacyLicensePattern = RegExp(r'^EG-PHR-\d{6}$');
}

/// Debug logging helper
void debugLog(String message, {String? tag}) {
  if (kDebugMode) {
    final prefix = tag != null ? '[$tag]' : '[EHDI]';
    print('$prefix $message');
  }
}
