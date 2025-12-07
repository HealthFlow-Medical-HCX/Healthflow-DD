import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax/iconsax.dart';

import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../widgets/health_id_card.dart';
import '../widgets/quick_action_button.dart';
import '../widgets/recent_activity_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Mock user data
  final String _userName = 'أحمد محمد';
  final String _healthId = 'EG-HID-2024-00001234';
  final String _nationalId = '29901011234567';
  
  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'صباح الخير';
    if (hour < 17) return 'مساء الخير';
    return 'مساء الخير';
  }
  
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            expandedHeight: 120,
            floating: false,
            pinned: true,
            backgroundColor: AppTheme.primaryColor,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppTheme.primaryColor,
                      AppTheme.primaryDark,
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        // User Avatar
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                              width: 2,
                            ),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                        ),
                        
                        const SizedBox(width: 16),
                        
                        // Greeting
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _getGreeting(),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white.withOpacity(0.8),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _userName,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                textDirection: TextDirection.rtl,
                              ),
                            ],
                          ),
                        ),
                        
                        // Notifications
                        Stack(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Iconsax.notification,
                                color: Colors.white,
                              ),
                            ),
                            Positioned(
                              right: 8,
                              top: 8,
                              child: Container(
                                width: 10,
                                height: 10,
                                decoration: const BoxDecoration(
                                  color: AppTheme.errorColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ],
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
                  // Health ID Card
                  HealthIdCard(
                    userName: _userName,
                    healthId: _healthId,
                    nationalId: _nationalId,
                  )
                  .animate()
                  .fadeIn(duration: 400.ms)
                  .slideY(begin: 0.2, end: 0),
                  
                  const SizedBox(height: 24),
                  
                  // Quick Actions
                  Text(
                    l10n.translate('quick_actions'),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                    textDirection: TextDirection.rtl,
                  )
                  .animate()
                  .fadeIn(delay: 100.ms, duration: 400.ms),
                  
                  const SizedBox(height: 16),
                  
                  Row(
                    children: [
                      Expanded(
                        child: QuickActionButton(
                          icon: Iconsax.scan_barcode,
                          label: 'مسح QR',
                          color: AppTheme.primaryColor,
                          onTap: () {},
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: QuickActionButton(
                          icon: Iconsax.document_text,
                          label: 'وصفة جديدة',
                          color: AppTheme.accentColor,
                          onTap: () {},
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: QuickActionButton(
                          icon: Iconsax.card,
                          label: 'التأمين',
                          color: AppTheme.secondaryColor,
                          onTap: () {},
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: QuickActionButton(
                          icon: Iconsax.hospital,
                          label: 'المنشآت',
                          color: const Color(0xFF6C5CE7),
                          onTap: () {},
                        ),
                      ),
                    ],
                  )
                  .animate()
                  .fadeIn(delay: 200.ms, duration: 400.ms)
                  .slideY(begin: 0.2, end: 0),
                  
                  const SizedBox(height: 24),
                  
                  // Statistics Cards
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          icon: Iconsax.card,
                          value: '4',
                          label: 'اعتمادات نشطة',
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard(
                          icon: Iconsax.document_text,
                          value: '2',
                          label: 'وصفات نشطة',
                          color: AppTheme.accentColor,
                        ),
                      ),
                    ],
                  )
                  .animate()
                  .fadeIn(delay: 300.ms, duration: 400.ms)
                  .slideY(begin: 0.2, end: 0),
                  
                  const SizedBox(height: 24),
                  
                  // Recent Activity
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.translate('recent_activity'),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          l10n.translate('view_all'),
                          style: const TextStyle(
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  )
                  .animate()
                  .fadeIn(delay: 400.ms, duration: 400.ms),
                  
                  const SizedBox(height: 12),
                  
                  // Activity Items
                  ..._buildActivityItems()
                      .asMap()
                      .entries
                      .map((entry) => entry.value
                          .animate()
                          .fadeIn(
                            delay: Duration(milliseconds: 500 + (entry.key * 100)),
                            duration: 400.ms,
                          )
                          .slideX(begin: 0.2, end: 0)),
                  
                  const SizedBox(height: 100), // Bottom padding for FAB
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildStatCard({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Icon(
                    icon,
                    color: color,
                    size: 22,
                  ),
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
            ),
            textDirection: TextDirection.rtl,
          ),
        ],
      ),
    );
  }
  
  List<Widget> _buildActivityItems() {
    final activities = [
      {
        'icon': Iconsax.document_text,
        'title': 'وصفة طبية جديدة',
        'subtitle': 'من د. محمد أحمد - القاهرة',
        'time': 'منذ ساعتين',
        'color': AppTheme.accentColor,
      },
      {
        'icon': Iconsax.scan,
        'title': 'تم مسح الهوية الصحية',
        'subtitle': 'صيدلية الشفاء - المهندسين',
        'time': 'أمس',
        'color': AppTheme.primaryColor,
      },
      {
        'icon': Iconsax.shield_tick,
        'title': 'تم تجديد التأمين',
        'subtitle': 'التأمين الصحي الشامل',
        'time': 'منذ 3 أيام',
        'color': AppTheme.secondaryColor,
      },
    ];
    
    return activities.map((activity) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: RecentActivityItem(
          icon: activity['icon'] as IconData,
          title: activity['title'] as String,
          subtitle: activity['subtitle'] as String,
          time: activity['time'] as String,
          color: activity['color'] as Color,
        ),
      );
    }).toList();
  }
}
