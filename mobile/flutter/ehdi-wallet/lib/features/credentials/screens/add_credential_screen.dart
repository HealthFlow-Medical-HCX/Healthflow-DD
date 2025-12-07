import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

import '../../../core/theme/app_theme.dart';
import '../models/credential.dart';

class AddCredentialScreen extends StatelessWidget {
  const AddCredentialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final credentialOptions = [
      _CredentialOption(
        type: CredentialType.healthId,
        titleAr: 'الرقم الصحي',
        titleEn: 'Health ID',
        descriptionAr: 'رقم التعريف الصحي الخاص بك',
        icon: Iconsax.health,
        color: AppTheme.primaryColor,
      ),
      _CredentialOption(
        type: CredentialType.medicalLicense,
        titleAr: 'رخصة مزاولة المهنة',
        titleEn: 'Medical License',
        descriptionAr: 'رخصة مزاولة مهنة الطب',
        icon: Iconsax.stickynote,
        color: const Color(0xFF3498DB),
      ),
      _CredentialOption(
        type: CredentialType.pharmacyLicense,
        titleAr: 'رخصة الصيدلة',
        titleEn: 'Pharmacy License',
        descriptionAr: 'رخصة مزاولة مهنة الصيدلة',
        icon: Iconsax.hospital,
        color: const Color(0xFF9B59B6),
      ),
      _CredentialOption(
        type: CredentialType.insuranceCard,
        titleAr: 'بطاقة التأمين الصحي',
        titleEn: 'Insurance Card',
        descriptionAr: 'بطاقة التأمين الصحي الشامل',
        icon: Iconsax.shield_tick,
        color: AppTheme.secondaryColor,
      ),
      _CredentialOption(
        type: CredentialType.vaccinationRecord,
        titleAr: 'سجل التطعيمات',
        titleEn: 'Vaccination Record',
        descriptionAr: 'سجل التطعيمات الخاص بك',
        icon: Iconsax.activity,
        color: AppTheme.accentColor,
      ),
      _CredentialOption(
        type: CredentialType.emergencyAccess,
        titleAr: 'بطاقة الطوارئ',
        titleEn: 'Emergency Access',
        descriptionAr: 'معلومات الطوارئ الطبية',
        icon: Iconsax.warning_2,
        color: AppTheme.errorColor,
      ),
    ];
    
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'إضافة اعتماد',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Text(
              'اختر نوع الاعتماد',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
              textDirection: TextDirection.rtl,
            )
            .animate()
            .fadeIn(duration: 400.ms),
            
            const SizedBox(height: 8),
            
            Text(
              'حدد نوع الاعتماد الذي ترغب في إضافته إلى محفظتك',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
              textDirection: TextDirection.rtl,
            )
            .animate()
            .fadeIn(delay: 100.ms, duration: 400.ms),
            
            const SizedBox(height: 24),
            
            // Credential Options
            ...credentialOptions.asMap().entries.map((entry) {
              final index = entry.key;
              final option = entry.value;
              
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildCredentialOption(context, option)
                    .animate()
                    .fadeIn(
                      delay: Duration(milliseconds: 150 + (index * 50)),
                      duration: 400.ms,
                    )
                    .slideX(begin: 0.1, end: 0),
              );
            }),
            
            const SizedBox(height: 24),
            
            // Scan Option
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppTheme.primaryColor.withOpacity(0.3),
                  width: 2,
                  strokeAlign: BorderSide.strokeAlignOutside,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        Iconsax.scan_barcode,
                        color: AppTheme.primaryColor,
                        size: 32,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'مسح رمز QR',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'امسح رمز QR من جهة الإصدار لإضافة الاعتماد تلقائياً',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Open QR scanner
                    },
                    icon: const Icon(Iconsax.scan),
                    label: const Text('فتح الماسح'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 12,
                      ),
                    ),
                  ),
                ],
              ),
            )
            .animate()
            .fadeIn(delay: 500.ms, duration: 400.ms),
          ],
        ),
      ),
    );
  }
  
  Widget _buildCredentialOption(BuildContext context, _CredentialOption option) {
    return InkWell(
      onTap: () {
        _showAddCredentialSheet(context, option);
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
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
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: option.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Icon(
                  option.icon,
                  color: option.color,
                  size: 28,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    option.titleAr,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    option.descriptionAr,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }
  
  void _showAddCredentialSheet(BuildContext context, _CredentialOption option) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: option.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Center(
                    child: Icon(
                      option.icon,
                      color: option.color,
                      size: 28,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        option.titleAr,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                      Text(
                        option.titleEn,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'خطوات الإضافة:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(height: 16),
            _buildStep(1, 'التحقق من الهوية', 'سيتم التحقق من هويتك عبر الرقم القومي'),
            _buildStep(2, 'طلب الاعتماد', 'سيتم إرسال طلب للجهة المصدرة'),
            _buildStep(3, 'الموافقة', 'انتظر الموافقة على الطلب'),
            _buildStep(4, 'التفعيل', 'سيتم تفعيل الاعتماد تلقائياً'),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Start credential request flow
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: option.color,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'بدء طلب الاعتماد',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildStep(int number, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$number',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryColor,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                  textDirection: TextDirection.rtl,
                ),
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

class _CredentialOption {
  final CredentialType type;
  final String titleAr;
  final String titleEn;
  final String descriptionAr;
  final IconData icon;
  final Color color;
  
  _CredentialOption({
    required this.type,
    required this.titleAr,
    required this.titleEn,
    required this.descriptionAr,
    required this.icon,
    required this.color,
  });
}
