import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/config/app_config.dart';
import '../../../core/theme/app_theme.dart';

/// National ID Input Widget
/// Formats Egyptian National ID as: XX XXXXXX XX XXXX X
/// Structure: C-YYMMDD-GG-SSS-V
/// - C: Century (2=1900s, 3=2000s)
/// - YYMMDD: Birth date
/// - GG: Governorate code
/// - SSS: Sequence number
/// - V: Gender indicator (odd=male, even=female)
class NationalIdInput extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final bool enabled;
  
  const NationalIdInput({
    super.key,
    required this.controller,
    this.onChanged,
    this.validator,
    this.enabled = true,
  });

  @override
  State<NationalIdInput> createState() => _NationalIdInputState();
}

class _NationalIdInputState extends State<NationalIdInput> {
  String? _governorate;
  String? _birthDate;
  String? _gender;
  bool _isValid = false;
  
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_parseNationalId);
  }
  
  void _parseNationalId() {
    final text = widget.controller.text.replaceAll(' ', '');
    
    if (text.length < 7) {
      setState(() {
        _birthDate = null;
        _governorate = null;
        _gender = null;
        _isValid = false;
      });
      return;
    }
    
    // Parse birth date
    if (text.length >= 7) {
      final century = text[0] == '2' ? '19' : '20';
      final year = text.substring(1, 3);
      final month = text.substring(3, 5);
      final day = text.substring(5, 7);
      
      final date = DateTime.tryParse('$century$year-$month-$day');
      if (date != null) {
        setState(() {
          _birthDate = '$day/$month/$century$year';
        });
      }
    }
    
    // Parse governorate
    if (text.length >= 9) {
      final govCode = text.substring(7, 9);
      setState(() {
        _governorate = AppConfig.governorateCodes[govCode];
      });
    }
    
    // Parse gender
    if (text.length >= 14) {
      final lastDigit = int.tryParse(text[13]);
      if (lastDigit != null) {
        setState(() {
          _gender = lastDigit.isOdd ? 'ذكر' : 'أنثى';
          _isValid = AppConfig.nationalIdPattern.hasMatch(text);
        });
      }
    }
  }
  
  @override
  void dispose() {
    widget.controller.removeListener(_parseNationalId);
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        const Row(
          children: [
            Icon(
              Icons.badge_outlined,
              size: 18,
              color: AppTheme.textSecondary,
            ),
            SizedBox(width: 8),
            Text(
              'الرقم القومي',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              ),
            ),
            Spacer(),
            Text(
              'National ID',
              style: TextStyle(
                fontSize: 12,
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 12),
        
        // Input Field
        TextFormField(
          controller: widget.controller,
          enabled: widget.enabled,
          keyboardType: TextInputType.number,
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            letterSpacing: 2,
            fontFamily: 'monospace',
          ),
          decoration: InputDecoration(
            hintText: '_ _  _ _ _ _ _ _  _ _  _ _ _ _',
            hintStyle: TextStyle(
              fontSize: 20,
              color: Colors.grey.shade300,
              letterSpacing: 2,
            ),
            filled: true,
            fillColor: Colors.grey.shade50,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: _isValid ? AppTheme.successColor : Colors.grey.shade200,
                width: _isValid ? 2 : 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: AppTheme.primaryColor,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: AppTheme.errorColor,
                width: 1,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            suffixIcon: _isValid
                ? const Padding(
                    padding: EdgeInsets.only(right: 12),
                    child: Icon(
                      Icons.check_circle,
                      color: AppTheme.successColor,
                    ),
                  )
                : null,
          ),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(14),
            _NationalIdFormatter(),
          ],
          validator: widget.validator ?? _defaultValidator,
          onChanged: widget.onChanged,
        ),
        
        // Info Display
        if (_birthDate != null || _governorate != null || _gender != null) ...[
          const SizedBox(height: 16),
          
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.primaryColor.withOpacity(0.2),
              ),
            ),
            child: Column(
              children: [
                if (_birthDate != null)
                  _buildInfoRow(
                    'تاريخ الميلاد',
                    _birthDate!,
                    Icons.cake_outlined,
                  ),
                if (_governorate != null) ...[
                  const SizedBox(height: 8),
                  _buildInfoRow(
                    'المحافظة',
                    _governorate!,
                    Icons.location_on_outlined,
                  ),
                ],
                if (_gender != null) ...[
                  const SizedBox(height: 8),
                  _buildInfoRow(
                    'النوع',
                    _gender!,
                    Icons.person_outline,
                  ),
                ],
              ],
            ),
          ),
        ],
        
        // Format Guide
        const SizedBox(height: 12),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.info_outline,
              size: 14,
              color: Colors.grey.shade400,
            ),
            const SizedBox(width: 4),
            Text(
              'الرقم القومي المكون من 14 رقم من البطاقة',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade500,
              ),
              textDirection: TextDirection.rtl,
            ),
          ],
        ),
      ],
    );
  }
  
  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: AppTheme.primaryColor,
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppTheme.textSecondary,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppTheme.textPrimary,
          ),
          textDirection: TextDirection.rtl,
        ),
      ],
    );
  }
  
  String? _defaultValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'الرقم القومي مطلوب';
    }
    
    final nationalId = value.replaceAll(' ', '');
    
    if (nationalId.length != 14) {
      return 'يجب أن يكون الرقم القومي 14 رقم';
    }
    
    if (!AppConfig.nationalIdPattern.hasMatch(nationalId)) {
      return 'الرقم القومي غير صالح';
    }
    
    return null;
  }
}

/// Formats National ID as: XX XXXXXX XX XXXX
class _NationalIdFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(' ', '');
    final buffer = StringBuffer();
    
    for (int i = 0; i < text.length; i++) {
      // Add spaces at positions: 2, 8, 10
      if (i == 2 || i == 8 || i == 10) {
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
