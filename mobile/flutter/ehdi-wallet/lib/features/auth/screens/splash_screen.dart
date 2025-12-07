import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/config/app_config.dart';
import '../../../core/config/router_config.dart';
import '../../../core/theme/app_theme.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initialize();
  }
  
  Future<void> _initialize() async {
    // Simulate loading time for splash animation
    await Future.delayed(const Duration(milliseconds: 2500));
    
    if (!mounted) return;
    
    // Check if onboarding is complete
    final prefs = await SharedPreferences.getInstance();
    final onboardingComplete = prefs.getBool(AppConfig.onboardingCompleteKey) ?? false;
    
    if (!mounted) return;
    
    if (onboardingComplete) {
      // Check if user is logged in
      final token = prefs.getString(AppConfig.tokenKey);
      if (token != null && token.isNotEmpty) {
        context.go(Routes.home);
      } else {
        context.go(Routes.login);
      }
    } else {
      context.go(Routes.onboarding);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppTheme.primaryColor,
              AppTheme.primaryDark,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              
              // Logo Container with animation
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 30,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Health Icon
                      Icon(
                        Icons.health_and_safety,
                        size: 60,
                        color: AppTheme.primaryColor,
                      ),
                      const SizedBox(height: 8),
                      // EHDI Text
                      const Text(
                        'EHDI',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryColor,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .animate()
              .fadeIn(duration: 600.ms)
              .scale(
                begin: const Offset(0.8, 0.8),
                end: const Offset(1.0, 1.0),
                duration: 600.ms,
                curve: Curves.easeOutBack,
              ),
              
              const SizedBox(height: 40),
              
              // App Name
              const Text(
                'محفظة الهوية الصحية',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textDirection: TextDirection.rtl,
              )
              .animate()
              .fadeIn(delay: 400.ms, duration: 500.ms)
              .slideY(begin: 0.3, end: 0, duration: 500.ms),
              
              const SizedBox(height: 8),
              
              // Subtitle
              const Text(
                'Egyptian Healthcare Digital Identity',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                  letterSpacing: 1,
                ),
              )
              .animate()
              .fadeIn(delay: 600.ms, duration: 500.ms),
              
              const Spacer(flex: 2),
              
              // Loading Indicator
              SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.white.withOpacity(0.8),
                  ),
                ),
              )
              .animate()
              .fadeIn(delay: 800.ms, duration: 400.ms),
              
              const SizedBox(height: 16),
              
              // Loading Text
              const Text(
                'جاري التحميل...',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white60,
                ),
              )
              .animate()
              .fadeIn(delay: 900.ms, duration: 400.ms),
              
              const Spacer(),
              
              // Footer
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildRegulatorLogo('EDA', 'هيئة الدواء'),
                      const SizedBox(width: 24),
                      _buildRegulatorLogo('FRA', 'الرقابة المالية'),
                      const SizedBox(width: 24),
                      _buildRegulatorLogo('MOH', 'الصحة'),
                    ],
                  )
                  .animate()
                  .fadeIn(delay: 1000.ms, duration: 500.ms),
                  
                  const SizedBox(height: 24),
                  
                  Text(
                    'Version ${AppConfig.version}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.5),
                    ),
                  )
                  .animate()
                  .fadeIn(delay: 1200.ms, duration: 400.ms),
                ],
              ),
              
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildRegulatorLogo(String code, String nameAr) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              code,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          nameAr,
          style: TextStyle(
            fontSize: 8,
            color: Colors.white.withOpacity(0.7),
          ),
          textDirection: TextDirection.rtl,
        ),
      ],
    );
  }
}
