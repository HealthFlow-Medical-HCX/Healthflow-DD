import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/config/app_config.dart';
import '../../../core/config/router_config.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  
  final List<OnboardingPage> _pages = [
    OnboardingPage(
      icon: Icons.health_and_safety,
      titleEn: 'Your Digital Health Identity',
      titleAr: 'هويتك الصحية الرقمية',
      descriptionEn: 'Securely store and manage all your healthcare credentials in one place - health ID, medical licenses, and insurance cards.',
      descriptionAr: 'احفظ وأدر جميع اعتماداتك الصحية بشكل آمن في مكان واحد - الرقم الصحي، رخص مزاولة المهنة، وبطاقات التأمين.',
      gradient: [AppTheme.primaryColor, AppTheme.primaryDark],
    ),
    OnboardingPage(
      icon: Icons.medical_services,
      titleEn: 'Digital Prescriptions',
      titleAr: 'الوصفات الطبية الرقمية',
      descriptionEn: 'Receive digital prescriptions from doctors and share them instantly with any pharmacy across Egypt.',
      descriptionAr: 'استلم الوصفات الطبية الرقمية من الأطباء وشاركها فوراً مع أي صيدلية في مصر.',
      gradient: [AppTheme.accentColor, AppTheme.accentDark],
    ),
    OnboardingPage(
      icon: Icons.shield,
      titleEn: 'Insurance Made Easy',
      titleAr: 'التأمين الصحي بسهولة',
      descriptionEn: 'Submit and track health insurance claims seamlessly with Universal Health Insurance integration.',
      descriptionAr: 'قدم وتتبع مطالبات التأمين الصحي بسلاسة مع تكامل التأمين الصحي الشامل.',
      gradient: [AppTheme.secondaryColor, AppTheme.secondaryDark],
    ),
    OnboardingPage(
      icon: Icons.verified_user,
      titleEn: 'Verified & Secure',
      titleAr: 'موثق وآمن',
      descriptionEn: 'All credentials are verified by Egyptian regulatory authorities - EDA, FRA, and Ministry of Health.',
      descriptionAr: 'جميع الاعتمادات موثقة من الجهات التنظيمية المصرية - هيئة الدواء، الرقابة المالية، ووزارة الصحة.',
      gradient: [const Color(0xFF6C5CE7), const Color(0xFF4834D4)],
    ),
  ];
  
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  
  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }
  
  void _skipOnboarding() {
    _completeOnboarding();
  }
  
  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConfig.onboardingCompleteKey, true);
    
    if (!mounted) return;
    context.go(Routes.login);
  }
  
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    
    return Scaffold(
      body: Stack(
        children: [
          // Page View
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: _pages.length,
            itemBuilder: (context, index) {
              return _buildPage(_pages[index], index);
            },
          ),
          
          // Skip Button
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            right: isRtl ? null : 16,
            left: isRtl ? 16 : null,
            child: TextButton(
              onPressed: _skipOnboarding,
              child: Text(
                l10n.translate('skip'),
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
            ),
          ).animate().fadeIn(duration: 400.ms),
          
          // Bottom Navigation
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(
                left: 24,
                right: 24,
                bottom: MediaQuery.of(context).padding.bottom + 24,
                top: 24,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.3),
                  ],
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Page Indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _pages.length,
                      (index) => _buildIndicator(index),
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Next/Get Started Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _nextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: _pages[_currentPage].gradient[0],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        _currentPage == _pages.length - 1
                            ? l10n.translate('get_started')
                            : l10n.translate('next'),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildPage(OnboardingPage page, int index) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: page.gradient,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              
              // Icon Container
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Center(
                  child: Icon(
                    page.icon,
                    size: 80,
                    color: Colors.white,
                  ),
                ),
              )
              .animate(key: ValueKey(index))
              .fadeIn(duration: 400.ms)
              .scale(
                begin: const Offset(0.8, 0.8),
                end: const Offset(1.0, 1.0),
                duration: 400.ms,
                curve: Curves.easeOut,
              ),
              
              const SizedBox(height: 60),
              
              // Arabic Title
              Text(
                page.titleAr,
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.2,
                ),
              )
              .animate(key: ValueKey('title_ar_$index'))
              .fadeIn(delay: 200.ms, duration: 400.ms)
              .slideY(begin: 0.2, end: 0, duration: 400.ms),
              
              const SizedBox(height: 8),
              
              // English Title
              Text(
                page.titleEn,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withOpacity(0.8),
                  letterSpacing: 0.5,
                ),
              )
              .animate(key: ValueKey('title_en_$index'))
              .fadeIn(delay: 300.ms, duration: 400.ms),
              
              const SizedBox(height: 32),
              
              // Arabic Description
              Text(
                page.descriptionAr,
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.9),
                  height: 1.6,
                ),
              )
              .animate(key: ValueKey('desc_ar_$index'))
              .fadeIn(delay: 400.ms, duration: 400.ms),
              
              const SizedBox(height: 16),
              
              // English Description
              Text(
                page.descriptionEn,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.7),
                  height: 1.5,
                ),
              )
              .animate(key: ValueKey('desc_en_$index'))
              .fadeIn(delay: 500.ms, duration: 400.ms),
              
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildIndicator(int index) {
    final isActive = index == _currentPage;
    
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 32 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

class OnboardingPage {
  final IconData icon;
  final String titleEn;
  final String titleAr;
  final String descriptionEn;
  final String descriptionAr;
  final List<Color> gradient;
  
  OnboardingPage({
    required this.icon,
    required this.titleEn,
    required this.titleAr,
    required this.descriptionEn,
    required this.descriptionAr,
    required this.gradient,
  });
}
