import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/config/app_config.dart';
import '../../../core/config/router_config.dart';
import '../../../core/theme/app_theme.dart';

class BiometricSetupScreen extends StatefulWidget {
  const BiometricSetupScreen({super.key});

  @override
  State<BiometricSetupScreen> createState() => _BiometricSetupScreenState();
}

class _BiometricSetupScreenState extends State<BiometricSetupScreen> {
  final LocalAuthentication _localAuth = LocalAuthentication();
  bool _canCheckBiometrics = false;
  List<BiometricType> _availableBiometrics = [];
  bool _isLoading = false;
  
  @override
  void initState() {
    super.initState();
    _checkBiometrics();
  }
  
  Future<void> _checkBiometrics() async {
    try {
      _canCheckBiometrics = await _localAuth.canCheckBiometrics;
      _availableBiometrics = await _localAuth.getAvailableBiometrics();
      setState(() {});
    } catch (e) {
      debugPrint('Error checking biometrics: $e');
    }
  }
  
  String get _biometricType {
    if (_availableBiometrics.contains(BiometricType.face)) {
      return 'face';
    } else if (_availableBiometrics.contains(BiometricType.fingerprint)) {
      return 'fingerprint';
    }
    return 'biometric';
  }
  
  IconData get _biometricIcon {
    if (_availableBiometrics.contains(BiometricType.face)) {
      return Icons.face;
    }
    return Icons.fingerprint;
  }
  
  String get _biometricNameAr {
    if (_availableBiometrics.contains(BiometricType.face)) {
      return 'بصمة الوجه';
    }
    return 'بصمة الإصبع';
  }
  
  Future<void> _enableBiometric() async {
    setState(() => _isLoading = true);
    
    try {
      final authenticated = await _localAuth.authenticate(
        localizedReason: 'قم بتفعيل المصادقة البيومترية للوصول السريع',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      
      if (authenticated) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool(AppConfig.biometricEnabledKey, true);
        
        if (!mounted) return;
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'تم تفعيل المصادقة البيومترية بنجاح',
              textDirection: TextDirection.rtl,
            ),
            backgroundColor: AppTheme.successColor,
          ),
        );
        
        context.go(Routes.home);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'فشل التفعيل: ${e.toString()}',
            textDirection: TextDirection.rtl,
          ),
          backgroundColor: AppTheme.errorColor,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
  
  void _skipBiometric() {
    context.go(Routes.home);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(),
              
              // Biometric Icon Animation
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        _biometricIcon,
                        size: 64,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ),
                ),
              )
              .animate(
                onPlay: (controller) => controller.repeat(reverse: true),
              )
              .scale(
                begin: const Offset(1, 1),
                end: const Offset(1.05, 1.05),
                duration: 1500.ms,
                curve: Curves.easeInOut,
              ),
              
              const SizedBox(height: 48),
              
              // Title
              Text(
                'تفعيل $_biometricNameAr',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
                textDirection: TextDirection.rtl,
              )
              .animate()
              .fadeIn(delay: 200.ms, duration: 400.ms),
              
              const SizedBox(height: 16),
              
              // Description
              Text(
                'فعّل المصادقة البيومترية للوصول السريع والآمن إلى محفظتك الصحية',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
              )
              .animate()
              .fadeIn(delay: 300.ms, duration: 400.ms),
              
              const SizedBox(height: 32),
              
              // Benefits
              _buildBenefit(
                Icons.speed,
                'دخول سريع',
                'افتح التطبيق في ثانية واحدة',
              )
              .animate()
              .fadeIn(delay: 400.ms, duration: 400.ms)
              .slideX(begin: -0.2, end: 0),
              
              const SizedBox(height: 16),
              
              _buildBenefit(
                Icons.shield,
                'أمان محسّن',
                'حماية إضافية لمعلوماتك الصحية',
              )
              .animate()
              .fadeIn(delay: 500.ms, duration: 400.ms)
              .slideX(begin: -0.2, end: 0),
              
              const SizedBox(height: 16),
              
              _buildBenefit(
                Icons.lock_outline,
                'خصوصية كاملة',
                'بياناتك البيومترية تبقى على جهازك فقط',
              )
              .animate()
              .fadeIn(delay: 600.ms, duration: 400.ms)
              .slideX(begin: -0.2, end: 0),
              
              const Spacer(),
              
              // Enable Button
              if (_canCheckBiometrics && _availableBiometrics.isNotEmpty)
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _enableBiometric,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(_biometricIcon),
                              const SizedBox(width: 8),
                              Text(
                                'تفعيل $_biometricNameAr',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                  ),
                )
                .animate()
                .fadeIn(delay: 700.ms, duration: 400.ms),
              
              if (!_canCheckBiometrics || _availableBiometrics.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.warningColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppTheme.warningColor.withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.info_outline,
                        color: AppTheme.warningColor,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'المصادقة البيومترية غير متاحة على هذا الجهاز',
                          style: TextStyle(
                            color: AppTheme.warningColor.withOpacity(0.9),
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                    ],
                  ),
                ),
              
              const SizedBox(height: 16),
              
              // Skip Button
              TextButton(
                onPressed: _skipBiometric,
                child: const Text(
                  'تخطي الآن',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppTheme.textSecondary,
                  ),
                ),
              )
              .animate()
              .fadeIn(delay: 800.ms, duration: 400.ms),
              
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildBenefit(IconData icon, String title, String description) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Icon(
                icon,
                color: AppTheme.primaryColor,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
