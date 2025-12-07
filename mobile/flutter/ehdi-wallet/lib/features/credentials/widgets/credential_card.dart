import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_theme.dart';
import '../models/credential.dart';

class CredentialCard extends StatelessWidget {
  final Credential credential;
  final VoidCallback? onTap;
  final bool compact;
  
  const CredentialCard({
    super.key,
    required this.credential,
    this.onTap,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy');
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: EdgeInsets.all(compact ? 12 : 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: credential.color.withOpacity(0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: credential.color.withOpacity(0.1),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                // Icon
                Container(
                  width: compact ? 44 : 56,
                  height: compact ? 44 : 56,
                  decoration: BoxDecoration(
                    color: credential.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Center(
                    child: Icon(
                      credential.icon,
                      color: credential.color,
                      size: compact ? 22 : 28,
                    ),
                  ),
                ),
                
                const SizedBox(width: 16),
                
                // Title
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        credential.titleAr,
                        style: TextStyle(
                          fontSize: compact ? 15 : 17,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        credential.title,
                        style: TextStyle(
                          fontSize: compact ? 11 : 12,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Status Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: credential.statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: credential.statusColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        credential.statusTextAr,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: credential.statusColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            if (!compact) ...[
              const SizedBox(height: 20),
              
              // Divider
              Container(
                height: 1,
                color: Colors.grey.shade100,
              ),
              
              const SizedBox(height: 16),
              
              // Details
              Row(
                children: [
                  // Issuer
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'جهة الإصدار',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade500,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          credential.issuerAr,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.textPrimary,
                          ),
                          textDirection: TextDirection.rtl,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(width: 16),
                  
                  // Expiry Date
                  if (credential.expiryDate != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'تاريخ الانتهاء',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade500,
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (credential.daysUntilExpiry != null && 
                                credential.daysUntilExpiry! <= 30)
                              Padding(
                                padding: const EdgeInsets.only(left: 4),
                                child: Icon(
                                  Iconsax.warning_2,
                                  size: 14,
                                  color: credential.daysUntilExpiry! <= 7 
                                      ? AppTheme.errorColor 
                                      : AppTheme.warningColor,
                                ),
                              ),
                            Text(
                              dateFormat.format(credential.expiryDate!),
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: credential.daysUntilExpiry != null && 
                                       credential.daysUntilExpiry! <= 7
                                    ? AppTheme.errorColor
                                    : AppTheme.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                ],
              ),
              
              // Expiry Warning
              if (credential.daysUntilExpiry != null && 
                  credential.daysUntilExpiry! <= 30 &&
                  credential.daysUntilExpiry! > 0) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: credential.daysUntilExpiry! <= 7
                        ? AppTheme.errorColor.withOpacity(0.1)
                        : AppTheme.warningColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Iconsax.timer_1,
                        size: 16,
                        color: credential.daysUntilExpiry! <= 7
                            ? AppTheme.errorColor
                            : AppTheme.warningColor,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'ينتهي خلال ${credential.daysUntilExpiry} يوم',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: credential.daysUntilExpiry! <= 7
                              ? AppTheme.errorColor
                              : AppTheme.warningColor,
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}
