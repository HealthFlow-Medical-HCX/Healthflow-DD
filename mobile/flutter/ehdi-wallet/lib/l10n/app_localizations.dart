import 'package:flutter/material.dart';

/// App Localizations for EHDI Wallet
/// Arabic (ar) and English (en) support
class AppLocalizations {
  final Locale locale;
  
  AppLocalizations(this.locale);
  
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }
  
  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();
  
  static const List<Locale> supportedLocales = [
    Locale('ar'), // Arabic (default)
    Locale('en'), // English
  ];
  
  bool get isArabic => locale.languageCode == 'ar';
  bool get isEnglish => locale.languageCode == 'en';
  
  // ==================== Translations ====================
  
  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      // App
      'app_name': 'EHDI Wallet',
      'app_subtitle': 'Egyptian Healthcare Digital Identity',
      
      // Onboarding
      'onboarding_title_1': 'Your Digital Health Identity',
      'onboarding_desc_1': 'Securely store and manage your healthcare credentials in one place',
      'onboarding_title_2': 'Digital Prescriptions',
      'onboarding_desc_2': 'Receive and share digital prescriptions with pharmacies instantly',
      'onboarding_title_3': 'Insurance Made Easy',
      'onboarding_desc_3': 'Submit and track health insurance claims seamlessly',
      'get_started': 'Get Started',
      'skip': 'Skip',
      'next': 'Next',
      
      // Auth
      'welcome_back': 'Welcome Back',
      'login': 'Login',
      'logout': 'Logout',
      'register': 'Register',
      'national_id': 'National ID',
      'enter_national_id': 'Enter your 14-digit National ID',
      'phone_number': 'Phone Number',
      'enter_phone': 'Enter your phone number',
      'password': 'Password',
      'enter_password': 'Enter your password',
      'confirm_password': 'Confirm Password',
      'forgot_password': 'Forgot Password?',
      'create_account': 'Create Account',
      'already_have_account': 'Already have an account?',
      'dont_have_account': "Don't have an account?",
      'verify_identity': 'Verify Identity',
      'otp_sent': 'OTP sent to your phone',
      'enter_otp': 'Enter OTP',
      'resend_otp': 'Resend OTP',
      'verify': 'Verify',
      
      // Biometric
      'setup_biometric': 'Setup Biometric',
      'use_fingerprint': 'Use Fingerprint',
      'use_face_id': 'Use Face ID',
      'biometric_desc': 'Enable biometric authentication for quick and secure access',
      'enable_biometric': 'Enable Biometric',
      'skip_for_now': 'Skip for now',
      
      // Home
      'home': 'Home',
      'hello': 'Hello',
      'good_morning': 'Good Morning',
      'good_afternoon': 'Good Afternoon',
      'good_evening': 'Good Evening',
      'your_health_id': 'Your Health ID',
      'quick_actions': 'Quick Actions',
      'recent_activity': 'Recent Activity',
      'view_all': 'View All',
      'scan_qr': 'Scan QR',
      'show_qr': 'Show QR',
      'share_credential': 'Share Credential',
      
      // Credentials
      'credentials': 'Credentials',
      'my_credentials': 'My Credentials',
      'add_credential': 'Add Credential',
      'credential_details': 'Credential Details',
      'health_id': 'Health ID',
      'medical_license': 'Medical License',
      'pharmacy_license': 'Pharmacy License',
      'insurance_card': 'Insurance Card',
      'vaccination_record': 'Vaccination Record',
      'issued_by': 'Issued By',
      'issued_date': 'Issued Date',
      'expiry_date': 'Expiry Date',
      'status': 'Status',
      'active': 'Active',
      'expired': 'Expired',
      'pending': 'Pending',
      'revoked': 'Revoked',
      'valid': 'Valid',
      'invalid': 'Invalid',
      
      // Prescriptions
      'prescriptions': 'Prescriptions',
      'my_prescriptions': 'My Prescriptions',
      'active_prescriptions': 'Active Prescriptions',
      'prescription_history': 'Prescription History',
      'prescription_details': 'Prescription Details',
      'prescribed_by': 'Prescribed By',
      'prescribed_date': 'Prescribed Date',
      'medications': 'Medications',
      'dosage': 'Dosage',
      'frequency': 'Frequency',
      'duration': 'Duration',
      'instructions': 'Instructions',
      'refills_remaining': 'Refills Remaining',
      'dispense_at_pharmacy': 'Dispense at Pharmacy',
      'find_pharmacy': 'Find Pharmacy',
      
      // Settings
      'settings': 'Settings',
      'profile': 'Profile',
      'personal_info': 'Personal Information',
      'security': 'Security',
      'privacy': 'Privacy',
      'notifications': 'Notifications',
      'language': 'Language',
      'arabic': 'Arabic',
      'english': 'English',
      'theme': 'Theme',
      'light_mode': 'Light Mode',
      'dark_mode': 'Dark Mode',
      'system_default': 'System Default',
      'about': 'About',
      'help_support': 'Help & Support',
      'terms_conditions': 'Terms & Conditions',
      'privacy_policy': 'Privacy Policy',
      'version': 'Version',
      'change_pin': 'Change PIN',
      'change_password': 'Change Password',
      'biometric_login': 'Biometric Login',
      'two_factor_auth': 'Two-Factor Authentication',
      'delete_account': 'Delete Account',
      
      // Common
      'save': 'Save',
      'cancel': 'Cancel',
      'confirm': 'Confirm',
      'delete': 'Delete',
      'edit': 'Edit',
      'update': 'Update',
      'submit': 'Submit',
      'done': 'Done',
      'close': 'Close',
      'back': 'Back',
      'continue_text': 'Continue',
      'loading': 'Loading...',
      'error': 'Error',
      'success': 'Success',
      'warning': 'Warning',
      'info': 'Information',
      'retry': 'Retry',
      'search': 'Search',
      'no_results': 'No results found',
      'no_data': 'No data available',
      'required_field': 'This field is required',
      'invalid_input': 'Invalid input',
      'network_error': 'Network error. Please check your connection.',
      'session_expired': 'Session expired. Please login again.',
      
      // Egyptian Healthcare
      'eda': 'Egyptian Drug Authority',
      'fra': 'Financial Regulatory Authority',
      'moh': 'Ministry of Health',
      'uhia': 'Universal Health Insurance Authority',
      'medical_syndicate': 'Egyptian Medical Syndicate',
      'pharmacy_syndicate': 'Pharmacy Syndicate',
      'governorate': 'Governorate',
      'universal_health_insurance': 'Universal Health Insurance',
    },
    
    'ar': {
      // App
      'app_name': 'محفظة الهوية الصحية',
      'app_subtitle': 'الهوية الرقمية للرعاية الصحية المصرية',
      
      // Onboarding
      'onboarding_title_1': 'هويتك الصحية الرقمية',
      'onboarding_desc_1': 'احفظ وأدر جميع اعتماداتك الصحية بشكل آمن في مكان واحد',
      'onboarding_title_2': 'الوصفات الطبية الرقمية',
      'onboarding_desc_2': 'استلم وشارك الوصفات الطبية الرقمية مع الصيدليات فوراً',
      'onboarding_title_3': 'التأمين الصحي بسهولة',
      'onboarding_desc_3': 'قدم وتتبع مطالبات التأمين الصحي بسلاسة',
      'get_started': 'ابدأ الآن',
      'skip': 'تخطي',
      'next': 'التالي',
      
      // Auth
      'welcome_back': 'مرحباً بعودتك',
      'login': 'تسجيل الدخول',
      'logout': 'تسجيل الخروج',
      'register': 'إنشاء حساب',
      'national_id': 'الرقم القومي',
      'enter_national_id': 'أدخل الرقم القومي المكون من 14 رقم',
      'phone_number': 'رقم الهاتف',
      'enter_phone': 'أدخل رقم هاتفك',
      'password': 'كلمة المرور',
      'enter_password': 'أدخل كلمة المرور',
      'confirm_password': 'تأكيد كلمة المرور',
      'forgot_password': 'نسيت كلمة المرور؟',
      'create_account': 'إنشاء حساب جديد',
      'already_have_account': 'لديك حساب بالفعل؟',
      'dont_have_account': 'ليس لديك حساب؟',
      'verify_identity': 'التحقق من الهوية',
      'otp_sent': 'تم إرسال رمز التحقق إلى هاتفك',
      'enter_otp': 'أدخل رمز التحقق',
      'resend_otp': 'إعادة إرسال الرمز',
      'verify': 'تحقق',
      
      // Biometric
      'setup_biometric': 'إعداد البصمة',
      'use_fingerprint': 'استخدام بصمة الإصبع',
      'use_face_id': 'استخدام بصمة الوجه',
      'biometric_desc': 'فعّل المصادقة البيومترية للوصول السريع والآمن',
      'enable_biometric': 'تفعيل البصمة',
      'skip_for_now': 'تخطي الآن',
      
      // Home
      'home': 'الرئيسية',
      'hello': 'مرحباً',
      'good_morning': 'صباح الخير',
      'good_afternoon': 'مساء الخير',
      'good_evening': 'مساء الخير',
      'your_health_id': 'هويتك الصحية',
      'quick_actions': 'إجراءات سريعة',
      'recent_activity': 'النشاط الأخير',
      'view_all': 'عرض الكل',
      'scan_qr': 'مسح QR',
      'show_qr': 'عرض QR',
      'share_credential': 'مشاركة الاعتماد',
      
      // Credentials
      'credentials': 'الاعتمادات',
      'my_credentials': 'اعتماداتي',
      'add_credential': 'إضافة اعتماد',
      'credential_details': 'تفاصيل الاعتماد',
      'health_id': 'الرقم الصحي',
      'medical_license': 'رخصة مزاولة المهنة',
      'pharmacy_license': 'رخصة الصيدلة',
      'insurance_card': 'بطاقة التأمين الصحي',
      'vaccination_record': 'سجل التطعيمات',
      'issued_by': 'صادر من',
      'issued_date': 'تاريخ الإصدار',
      'expiry_date': 'تاريخ الانتهاء',
      'status': 'الحالة',
      'active': 'نشط',
      'expired': 'منتهي',
      'pending': 'قيد الانتظار',
      'revoked': 'ملغي',
      'valid': 'صالح',
      'invalid': 'غير صالح',
      
      // Prescriptions
      'prescriptions': 'الوصفات الطبية',
      'my_prescriptions': 'وصفاتي الطبية',
      'active_prescriptions': 'الوصفات النشطة',
      'prescription_history': 'سجل الوصفات',
      'prescription_details': 'تفاصيل الوصفة',
      'prescribed_by': 'الطبيب المعالج',
      'prescribed_date': 'تاريخ الوصفة',
      'medications': 'الأدوية',
      'dosage': 'الجرعة',
      'frequency': 'التكرار',
      'duration': 'المدة',
      'instructions': 'التعليمات',
      'refills_remaining': 'مرات التجديد المتبقية',
      'dispense_at_pharmacy': 'صرف من الصيدلية',
      'find_pharmacy': 'البحث عن صيدلية',
      
      // Settings
      'settings': 'الإعدادات',
      'profile': 'الملف الشخصي',
      'personal_info': 'المعلومات الشخصية',
      'security': 'الأمان',
      'privacy': 'الخصوصية',
      'notifications': 'الإشعارات',
      'language': 'اللغة',
      'arabic': 'العربية',
      'english': 'الإنجليزية',
      'theme': 'المظهر',
      'light_mode': 'الوضع الفاتح',
      'dark_mode': 'الوضع الداكن',
      'system_default': 'إعداد النظام',
      'about': 'حول التطبيق',
      'help_support': 'المساعدة والدعم',
      'terms_conditions': 'الشروط والأحكام',
      'privacy_policy': 'سياسة الخصوصية',
      'version': 'الإصدار',
      'change_pin': 'تغيير رمز PIN',
      'change_password': 'تغيير كلمة المرور',
      'biometric_login': 'الدخول بالبصمة',
      'two_factor_auth': 'المصادقة الثنائية',
      'delete_account': 'حذف الحساب',
      
      // Common
      'save': 'حفظ',
      'cancel': 'إلغاء',
      'confirm': 'تأكيد',
      'delete': 'حذف',
      'edit': 'تعديل',
      'update': 'تحديث',
      'submit': 'إرسال',
      'done': 'تم',
      'close': 'إغلاق',
      'back': 'رجوع',
      'continue_text': 'متابعة',
      'loading': 'جاري التحميل...',
      'error': 'خطأ',
      'success': 'تم بنجاح',
      'warning': 'تحذير',
      'info': 'معلومات',
      'retry': 'إعادة المحاولة',
      'search': 'بحث',
      'no_results': 'لا توجد نتائج',
      'no_data': 'لا توجد بيانات',
      'required_field': 'هذا الحقل مطلوب',
      'invalid_input': 'مدخل غير صالح',
      'network_error': 'خطأ في الشبكة. يرجى التحقق من الاتصال.',
      'session_expired': 'انتهت الجلسة. يرجى تسجيل الدخول مرة أخرى.',
      
      // Egyptian Healthcare
      'eda': 'هيئة الدواء المصرية',
      'fra': 'الهيئة العامة للرقابة المالية',
      'moh': 'وزارة الصحة والسكان',
      'uhia': 'الهيئة العامة للتأمين الصحي الشامل',
      'medical_syndicate': 'نقابة الأطباء المصرية',
      'pharmacy_syndicate': 'نقابة الصيادلة',
      'governorate': 'المحافظة',
      'universal_health_insurance': 'التأمين الصحي الشامل',
    },
  };
  
  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? 
           _localizedValues['en']?[key] ?? 
           key;
  }
  
  // Convenience getters for common translations
  String get appName => translate('app_name');
  String get home => translate('home');
  String get credentials => translate('credentials');
  String get prescriptions => translate('prescriptions');
  String get settings => translate('settings');
  String get login => translate('login');
  String get logout => translate('logout');
  String get save => translate('save');
  String get cancel => translate('cancel');
  String get confirm => translate('confirm');
  String get loading => translate('loading');
  String get error => translate('error');
  String get success => translate('success');
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();
  
  @override
  bool isSupported(Locale locale) {
    return ['ar', 'en'].contains(locale.languageCode);
  }
  
  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }
  
  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

// Extension for easy access
extension LocalizationExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
  bool get isRtl => Directionality.of(this) == TextDirection.rtl;
}
