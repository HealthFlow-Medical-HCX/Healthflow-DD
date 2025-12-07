import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/app_config.dart';
import '../../../core/config/router_config.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../widgets/national_id_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nationalIdController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _isLoading = false;
  bool _showPhoneInput = false;
  
  @override
  void dispose() {
    _nationalIdController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
  
  void _validateNationalId() {
    final nationalId = _nationalIdController.text.replaceAll(' ', '');
    
    if (nationalId.length != 14) {
      _showError('يجب أن يكون الرقم القومي 14 رقم');
      return;
    }
    
    if (!AppConfig.nationalIdPattern.hasMatch(nationalId)) {
      _showError('الرقم القومي غير صالح');
      return;
    }
    
    // Extract info from National ID
    final century = nationalId[0];
    final year = nationalId.substring(1, 3);
    final month = nationalId.substring(3, 5);
    final day = nationalId.substring(5, 7);
    final governorateCode = nationalId.substring(7, 9);
    
    // Validate date
    final birthYear = century == '2' ? '19$year' : '20$year';
    final birthDate = DateTime.tryParse('$birthYear-$month-$day');
    
    if (birthDate == null) {
      _showError('تاريخ الميلاد غير صالح في الرقم القومي');
      return;
    }
    
    // Check governorate code
    if (!AppConfig.governorateCodes.containsKey(governorateCode)) {
      _showError('كود المحافظة غير صالح');
      return;
    }
    
    setState(() {
      _showPhoneInput = true;
    });
  }
  
  void _login() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() => _isLoading = true);
    
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      if (!mounted) return;
      
      // Navigate to OTP verification or home
      context.go(Routes.nationalId);
      
    } catch (e) {
      _showError('حدث خطأ. يرجى المحاولة مرة أخرى.');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
  
  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textDirection: TextDirection.rtl,
        ),
        backgroundColor: AppTheme.errorColor,
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final screenHeight = MediaQuery.of(context).size.height;
    
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
            stops: [0.0, 0.4],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: screenHeight * 0.06),
                    
                    // Logo and Title
                    _buildHeader()
                        .animate()
                        .fadeIn(duration: 500.ms)
                        .slideY(begin: -0.2, end: 0, duration: 500.ms),
                    
                    SizedBox(height: screenHeight * 0.05),
                    
                    // Login Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Welcome Text
                          Text(
                            l10n.translate('welcome_back'),
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.textPrimary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          
                          const SizedBox(height: 8),
                          
                          Text(
                            'أدخل الرقم القومي للمتابعة',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ),
                          
                          const SizedBox(height: 32),
                          
                          // National ID Input
                          NationalIdInput(
                            controller: _nationalIdController,
                            onChanged: (value) {
                              if (value.replaceAll(' ', '').length == 14) {
                                _validateNationalId();
                              }
                            },
                          ),
                          
                          // Phone Input (shown after valid National ID)
                          if (_showPhoneInput) ...[
                            const SizedBox(height: 20),
                            
                            _buildPhoneInput()
                                .animate()
                                .fadeIn(duration: 300.ms)
                                .slideY(begin: 0.2, end: 0, duration: 300.ms),
                          ],
                          
                          const SizedBox(height: 32),
                          
                          // Login Button
                          SizedBox(
                            height: 56,
                            child: ElevatedButton(
                              onPressed: _isLoading 
                                  ? null 
                                  : (_showPhoneInput ? _login : _validateNationalId),
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
                                  : Text(
                                      _showPhoneInput ? l10n.translate('continue_text') : l10n.translate('verify'),
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),
                          
                          const SizedBox(height: 16),
                          
                          // Register Link
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                l10n.translate('dont_have_account'),
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Navigate to register
                                },
                                child: Text(
                                  l10n.translate('create_account'),
                                  style: const TextStyle(
                                    color: AppTheme.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                    .animate()
                    .fadeIn(delay: 200.ms, duration: 500.ms)
                    .slideY(begin: 0.2, end: 0, delay: 200.ms, duration: 500.ms),
                    
                    const SizedBox(height: 32),
                    
                    // Regulatory Badges
                    _buildRegulatoryBadges()
                        .animate()
                        .fadeIn(delay: 500.ms, duration: 400.ms),
                    
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildHeader() {
    return Column(
      children: [
        // Logo
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
              ),
            ],
          ),
          child: const Center(
            child: Icon(
              Icons.health_and_safety,
              size: 40,
              color: AppTheme.primaryColor,
            ),
          ),
        ),
        
        const SizedBox(height: 16),
        
        // App Name
        const Text(
          'محفظة الهوية الصحية',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textDirection: TextDirection.rtl,
        ),
        
        const SizedBox(height: 4),
        
        Text(
          'EHDI Wallet',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white.withOpacity(0.8),
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }
  
  Widget _buildPhoneInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'رقم الهاتف',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppTheme.textPrimary,
          ),
          textDirection: TextDirection.rtl,
        ),
        
        const SizedBox(height: 8),
        
        TextFormField(
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          textDirection: TextDirection.ltr,
          style: const TextStyle(
            fontSize: 18,
            letterSpacing: 1,
          ),
          decoration: InputDecoration(
            hintText: '01X XXXX XXXX',
            prefixIcon: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    '🇪🇬',
                    style: TextStyle(fontSize: 24),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '+20',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 1,
                    height: 24,
                    color: Colors.grey.shade300,
                  ),
                ],
              ),
            ),
            prefixIconConstraints: const BoxConstraints(),
          ),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(11),
            _PhoneInputFormatter(),
          ],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'رقم الهاتف مطلوب';
            }
            final phone = value.replaceAll(' ', '');
            if (!AppConfig.phonePattern.hasMatch(phone)) {
              return 'رقم الهاتف غير صالح';
            }
            return null;
          },
        ),
      ],
    );
  }
  
  Widget _buildRegulatoryBadges() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildBadge('هيئة الدواء', 'EDA'),
        const SizedBox(width: 16),
        _buildBadge('الرقابة المالية', 'FRA'),
        const SizedBox(width: 16),
        _buildBadge('وزارة الصحة', 'MOH'),
      ],
    );
  }
  
  Widget _buildBadge(String nameAr, String code) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            code,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            nameAr,
            style: TextStyle(
              fontSize: 8,
              color: Colors.white.withOpacity(0.8),
            ),
            textDirection: TextDirection.rtl,
          ),
        ],
      ),
    );
  }
}

// Phone number formatter
class _PhoneInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(' ', '');
    final buffer = StringBuffer();
    
    for (int i = 0; i < text.length; i++) {
      if (i == 3 || i == 7) {
        buffer.write(' ');
      }
      buffer.write(text[i]);
    }
    
    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}
