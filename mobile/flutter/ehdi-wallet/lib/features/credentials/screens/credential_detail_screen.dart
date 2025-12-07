import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../core/theme/app_theme.dart';
import '../models/credential.dart';

class CredentialDetailScreen extends StatefulWidget {
  final String credentialId;
  
  const CredentialDetailScreen({
    super.key,
    required this.credentialId,
  });

  @override
  State<CredentialDetailScreen> createState() => _CredentialDetailScreenState();
}

class _CredentialDetailScreenState extends State<CredentialDetailScreen> {
  // Mock credential - in real app, fetch from provider/repository
  late Credential _credential;
  
  @override
  void initState() {
    super.initState();
    // Mock data based on ID
    _credential = Credential.mock(type: CredentialType.healthId);
  }
  
  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd MMMM yyyy', 'ar');
    
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: CustomScrollView(
        slivers: [
          // App Bar with gradient
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: _credential.color,
            leading: IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            ),
            actions: [
              IconButton(
                onPressed: () => _showOptions(context),
                icon: const Icon(Iconsax.more, color: Colors.white),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      _credential.color,
                      _credential.color.withOpacity(0.8),
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 40),
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Icon(
                              _credential.icon,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _credential.titleAr,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _credential.title,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Status Card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'الحالة',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey.shade500,
                                ),
                                textDirection: TextDirection.rtl,
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      color: _credential.statusColor,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    _credential.statusTextAr,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: _credential.statusColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 40,
                          color: Colors.grey.shade200,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'صالح حتى',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey.shade500,
                                ),
                                textDirection: TextDirection.rtl,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _credential.expiryDate != null
                                    ? dateFormat.format(_credential.expiryDate!)
                                    : 'غير محدد',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.textPrimary,
                                ),
                                textDirection: TextDirection.rtl,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                  .animate()
                  .fadeIn(duration: 400.ms)
                  .slideY(begin: 0.2, end: 0),
                  
                  const SizedBox(height: 24),
                  
                  // QR Code Section
                  if (_credential.qrData != null)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'رمز QR للمشاركة',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.textPrimary,
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: QrImageView(
                              data: _credential.qrData!,
                              version: QrVersions.auto,
                              size: 180,
                              backgroundColor: Colors.white,
                              foregroundColor: _credential.color,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _credential.qrData!,
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'monospace',
                              color: Colors.grey.shade600,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    )
                    .animate()
                    .fadeIn(delay: 100.ms, duration: 400.ms)
                    .slideY(begin: 0.2, end: 0),
                  
                  const SizedBox(height: 24),
                  
                  // Details Section
                  const Text(
                    'تفاصيل الاعتماد',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                    textDirection: TextDirection.rtl,
                  )
                  .animate()
                  .fadeIn(delay: 200.ms, duration: 400.ms),
                  
                  const SizedBox(height: 16),
                  
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _buildDetailRow(
                          'جهة الإصدار',
                          _credential.issuerAr,
                          Iconsax.building,
                          isFirst: true,
                        ),
                        _buildDetailRow(
                          'تاريخ الإصدار',
                          dateFormat.format(_credential.issuedDate),
                          Iconsax.calendar,
                        ),
                        ..._credential.attributes.entries.map((entry) {
                          return _buildDetailRow(
                            _getAttributeLabel(entry.key),
                            entry.value.toString(),
                            Iconsax.document,
                          );
                        }),
                      ],
                    ),
                  )
                  .animate()
                  .fadeIn(delay: 300.ms, duration: 400.ms)
                  .slideY(begin: 0.2, end: 0),
                  
                  const SizedBox(height: 24),
                  
                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Iconsax.share),
                          label: const Text('مشاركة'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            side: BorderSide(color: _credential.color),
                            foregroundColor: _credential.color,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Iconsax.scan_barcode),
                          label: const Text('عرض QR'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: _credential.color,
                          ),
                        ),
                      ),
                    ],
                  )
                  .animate()
                  .fadeIn(delay: 400.ms, duration: 400.ms),
                  
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildDetailRow(
    String label, 
    String value, 
    IconData icon, 
    {bool isFirst = false, bool isLast = false}
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: isLast 
              ? BorderSide.none 
              : BorderSide(color: Colors.grey.shade100),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _credential.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Icon(
                icon,
                color: _credential.color,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textPrimary,
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
  
  String _getAttributeLabel(String key) {
    final labels = {
      'healthId': 'الرقم الصحي',
      'nationalId': 'الرقم القومي',
      'licenseNumber': 'رقم الرخصة',
      'specialty': 'التخصص',
      'grade': 'الدرجة',
      'insuranceNumber': 'رقم التأمين',
      'plan': 'الخطة',
      'coverage': 'نسبة التغطية',
    };
    return labels[key] ?? key;
  }
  
  void _showOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            _buildOptionItem(
              icon: Iconsax.refresh,
              title: 'تجديد الاعتماد',
              onTap: () {},
            ),
            _buildOptionItem(
              icon: Iconsax.document_download,
              title: 'تحميل كـ PDF',
              onTap: () {},
            ),
            _buildOptionItem(
              icon: Iconsax.trash,
              title: 'حذف الاعتماد',
              color: AppTheme.errorColor,
              onTap: () {},
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
  
  Widget _buildOptionItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? color,
  }) {
    return ListTile(
      leading: Icon(icon, color: color ?? AppTheme.textPrimary),
      title: Text(
        title,
        style: TextStyle(
          color: color ?? AppTheme.textPrimary,
          fontWeight: FontWeight.w500,
        ),
        textDirection: TextDirection.rtl,
      ),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
    );
  }
}
