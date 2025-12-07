import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/router_config.dart';
import '../../../core/theme/app_theme.dart';

class NationalIdScreen extends StatefulWidget {
  const NationalIdScreen({super.key});

  @override
  State<NationalIdScreen> createState() => _NationalIdScreenState();
}

class _NationalIdScreenState extends State<NationalIdScreen> {
  final List<TextEditingController> _otpControllers = 
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = 
      List.generate(6, (_) => FocusNode());
  
  bool _isLoading = false;
  int _resendCounter = 60;
  bool _canResend = false;
  
  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }
  
  void _startResendTimer() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return false;
      
      setState(() {
        if (_resendCounter > 0) {
          _resendCounter--;
        } else {
          _canResend = true;
        }
      });
      
      return _resendCounter > 0;
    });
  }
  
  void _resendOtp() {
    if (!_canResend) return;
    
    setState(() {
      _canResend = false;
      _resendCounter = 60;
    });
    
    _startResendTimer();
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'تم إرسال رمز التحقق مرة أخرى',
          textDirection: TextDirection.rtl,
        ),
        backgroundColor: AppTheme.successColor,
      ),
    );
  }
  
  void _verifyOtp() async {
    final otp = _otpControllers.map((c) => c.text).join();
    
    if (otp.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'يرجى إدخال رمز التحقق كاملاً',
            textDirection: TextDirection.rtl,
          ),
          backgroundColor: AppTheme.errorColor,
        ),
      );
      return;
    }
    
    setState(() => _isLoading = true);
    
    try {
      // Simulate API verification
      await Future.delayed(const Duration(seconds: 2));
      
      if (!mounted) return;
      
      context.go(Routes.biometricSetup);
      
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'رمز التحقق غير صحيح',
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
  
  @override
  void dispose() {
    for (final controller in _otpControllers) {
      controller.dispose();
    }
    for (final node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icon
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.sms_outlined,
                    size: 48,
                    color: AppTheme.primaryColor,
                  ),
                ),
              )
              .animate()
              .fadeIn(duration: 400.ms)
              .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1)),
              
              const SizedBox(height: 32),
              
              // Title
              const Text(
                'التحقق من الهوية',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
                textDirection: TextDirection.rtl,
              )
              .animate()
              .fadeIn(delay: 100.ms, duration: 400.ms),
              
              const SizedBox(height: 12),
              
              // Subtitle
              Text(
                'تم إرسال رمز التحقق إلى رقم هاتفك المسجل',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
              )
              .animate()
              .fadeIn(delay: 200.ms, duration: 400.ms),
              
              const SizedBox(height: 8),
              
              // Phone Number Display
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  '+20 01X XXX XX89',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primaryColor,
                    letterSpacing: 1,
                  ),
                ),
              )
              .animate()
              .fadeIn(delay: 300.ms, duration: 400.ms),
              
              const SizedBox(height: 40),
              
              // OTP Input
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(6, (index) => _buildOtpField(index)),
              )
              .animate()
              .fadeIn(delay: 400.ms, duration: 400.ms)
              .slideY(begin: 0.2, end: 0),
              
              const SizedBox(height: 40),
              
              // Verify Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _verifyOtp,
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
                      : const Text(
                          'تحقق',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              )
              .animate()
              .fadeIn(delay: 500.ms, duration: 400.ms),
              
              const SizedBox(height: 24),
              
              // Resend OTP
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'لم تستلم الرمز؟',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(width: 8),
                  _canResend
                      ? TextButton(
                          onPressed: _resendOtp,
                          child: const Text(
                            'إعادة الإرسال',
                            style: TextStyle(
                              color: AppTheme.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : Text(
                          'إعادة الإرسال ($_resendCounter)',
                          style: TextStyle(
                            color: Colors.grey.shade400,
                          ),
                        ),
                ],
              )
              .animate()
              .fadeIn(delay: 600.ms, duration: 400.ms),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildOtpField(int index) {
    return SizedBox(
      width: 48,
      height: 56,
      child: TextFormField(
        controller: _otpControllers[index],
        focusNode: _focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppTheme.textPrimary,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: AppTheme.primaryColor,
              width: 2,
            ),
          ),
          contentPadding: EdgeInsets.zero,
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(1),
        ],
        onChanged: (value) {
          if (value.isNotEmpty && index < 5) {
            _focusNodes[index + 1].requestFocus();
          } else if (value.isEmpty && index > 0) {
            _focusNodes[index - 1].requestFocus();
          }
          
          // Auto verify when all fields are filled
          if (index == 5 && value.isNotEmpty) {
            final otp = _otpControllers.map((c) => c.text).join();
            if (otp.length == 6) {
              _verifyOtp();
            }
          }
        },
      ),
    );
  }
}
