import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../core/theme/app_theme.dart';

class HealthIdCard extends StatefulWidget {
  final String userName;
  final String healthId;
  final String nationalId;
  final VoidCallback? onTap;
  
  const HealthIdCard({
    super.key,
    required this.userName,
    required this.healthId,
    required this.nationalId,
    this.onTap,
  });

  @override
  State<HealthIdCard> createState() => _HealthIdCardState();
}

class _HealthIdCardState extends State<HealthIdCard> {
  bool _showQr = false;
  
  void _toggleQr() {
    setState(() {
      _showQr = !_showQr;
    });
  }
  
  void _copyHealthId() {
    Clipboard.setData(ClipboardData(text: widget.healthId));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'تم نسخ الرقم الصحي',
          textDirection: TextDirection.rtl,
        ),
        backgroundColor: AppTheme.successColor,
        duration: Duration(seconds: 2),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap ?? _toggleQr,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: double.infinity,
        height: _showQr ? 280 : 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppTheme.primaryColor,
              AppTheme.primaryDark,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primaryColor.withOpacity(0.4),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Background Pattern
            Positioned(
              right: -50,
              top: -50,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.05),
                ),
              ),
            ),
            Positioned(
              left: -30,
              bottom: -30,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.05),
                ),
              ),
            ),
            
            // Content
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Logo and Title
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.health_and_safety,
                                color: AppTheme.primaryColor,
                                size: 24,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'الهوية الصحية',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                textDirection: TextDirection.rtl,
                              ),
                              Text(
                                'Health ID',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.white.withOpacity(0.7),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      
                      // Status Badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.successColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Colors.white,
                              size: 14,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'نشط',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  const Spacer(),
                  
                  // QR Code or User Info
                  if (_showQr)
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: QrImageView(
                          data: widget.healthId,
                          version: QrVersions.auto,
                          size: 100,
                          backgroundColor: Colors.white,
                          foregroundColor: AppTheme.primaryDark,
                        ),
                      ),
                    )
                  else
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // User Name
                        Text(
                          widget.userName,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                        
                        const SizedBox(height: 8),
                        
                        // Health ID
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.healthId,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'monospace',
                                  color: Colors.white.withOpacity(0.9),
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: _copyHealthId,
                              icon: Icon(
                                Iconsax.copy,
                                color: Colors.white.withOpacity(0.7),
                                size: 20,
                              ),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  
                  const Spacer(),
                  
                  // Footer
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Regulatory Logos
                      Row(
                        children: [
                          _buildMiniLogo('EDA'),
                          const SizedBox(width: 8),
                          _buildMiniLogo('FRA'),
                          const SizedBox(width: 8),
                          _buildMiniLogo('MOH'),
                        ],
                      ),
                      
                      // QR Toggle Hint
                      Row(
                        children: [
                          Icon(
                            _showQr ? Iconsax.card : Iconsax.scan_barcode,
                            color: Colors.white.withOpacity(0.7),
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _showQr ? 'اضغط للبطاقة' : 'اضغط للـ QR',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.white.withOpacity(0.7),
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildMiniLogo(String code) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: Text(
          code,
          style: TextStyle(
            fontSize: 8,
            fontWeight: FontWeight.bold,
            color: Colors.white.withOpacity(0.9),
          ),
        ),
      ),
    );
  }
}
