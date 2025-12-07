import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

import '../../../core/config/app_config.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../../../main.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);
    
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text(
          l10n.translate('settings'),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Section
            _buildProfileCard(context)
                .animate()
                .fadeIn(duration: 400.ms)
                .slideY(begin: 0.2, end: 0),
            
            const SizedBox(height: 24),
            
            // Account Section
            _buildSectionTitle(l10n.translate('profile'))
                .animate()
                .fadeIn(delay: 100.ms, duration: 400.ms),
            const SizedBox(height: 12),
            _buildSettingsGroup([
              _SettingItem(
                icon: Iconsax.user,
                title: l10n.translate('personal_info'),
                onTap: () => context.push('/settings/profile'),
              ),
              _SettingItem(
                icon: Iconsax.shield_tick,
                title: l10n.translate('security'),
                onTap: () => context.push('/settings/security'),
              ),
              _SettingItem(
                icon: Iconsax.notification,
                title: l10n.translate('notifications'),
                onTap: () {},
              ),
            ])
            .animate()
            .fadeIn(delay: 150.ms, duration: 400.ms)
            .slideY(begin: 0.2, end: 0),
            
            const SizedBox(height: 24),
            
            // Preferences Section
            _buildSectionTitle('التفضيلات')
                .animate()
                .fadeIn(delay: 200.ms, duration: 400.ms),
            const SizedBox(height: 12),
            _buildSettingsGroup([
              _SettingItem(
                icon: Iconsax.language_square,
                title: l10n.translate('language'),
                trailing: Text(
                  locale.languageCode == 'ar' ? 'العربية' : 'English',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),
                onTap: () => context.push('/settings/language'),
              ),
              _SettingItem(
                icon: themeMode == ThemeMode.dark 
                    ? Iconsax.moon 
                    : Iconsax.sun_1,
                title: l10n.translate('theme'),
                trailing: _buildThemeSelector(context, ref, themeMode),
                onTap: null,
              ),
            ])
            .animate()
            .fadeIn(delay: 250.ms, duration: 400.ms)
            .slideY(begin: 0.2, end: 0),
            
            const SizedBox(height: 24),
            
            // Support Section
            _buildSectionTitle('الدعم')
                .animate()
                .fadeIn(delay: 300.ms, duration: 400.ms),
            const SizedBox(height: 12),
            _buildSettingsGroup([
              _SettingItem(
                icon: Iconsax.message_question,
                title: l10n.translate('help_support'),
                onTap: () {},
              ),
              _SettingItem(
                icon: Iconsax.document,
                title: l10n.translate('terms_conditions'),
                onTap: () {},
              ),
              _SettingItem(
                icon: Iconsax.lock,
                title: l10n.translate('privacy_policy'),
                onTap: () {},
              ),
              _SettingItem(
                icon: Iconsax.info_circle,
                title: l10n.translate('about'),
                trailing: Text(
                  'v${AppConfig.version}',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),
                onTap: () {},
              ),
            ])
            .animate()
            .fadeIn(delay: 350.ms, duration: 400.ms)
            .slideY(begin: 0.2, end: 0),
            
            const SizedBox(height: 24),
            
            // Logout Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => _showLogoutDialog(context),
                icon: const Icon(Iconsax.logout, color: AppTheme.errorColor),
                label: Text(
                  l10n.translate('logout'),
                  style: const TextStyle(color: AppTheme.errorColor),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppTheme.errorColor),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            )
            .animate()
            .fadeIn(delay: 400.ms, duration: 400.ms),
            
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
  
  Widget _buildProfileCard(BuildContext context) {
    return Container(
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
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Icons.person,
                size: 32,
                color: AppTheme.primaryColor,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'أحمد محمد',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                const SizedBox(height: 4),
                Text(
                  '+20 01X XXX XX89',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => context.push('/settings/profile'),
            icon: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppTheme.textPrimary,
      ),
      textDirection: TextDirection.rtl,
    );
  }
  
  Widget _buildSettingsGroup(List<_SettingItem> items) {
    return Container(
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
        children: items.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          final isLast = index == items.length - 1;
          
          return Column(
            children: [
              ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Icon(
                      item.icon,
                      color: AppTheme.primaryColor,
                      size: 20,
                    ),
                  ),
                ),
                title: Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 15,
                    color: AppTheme.textPrimary,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                trailing: item.trailing ?? (item.onTap != null
                    ? const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: AppTheme.textSecondary,
                      )
                    : null),
                onTap: item.onTap,
              ),
              if (!isLast)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(
                    height: 1,
                    color: Colors.grey.shade100,
                  ),
                ),
            ],
          );
        }).toList(),
      ),
    );
  }
  
  Widget _buildThemeSelector(BuildContext context, WidgetRef ref, ThemeMode currentMode) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildThemeOption(
            context, ref,
            ThemeMode.light,
            Iconsax.sun_1,
            currentMode == ThemeMode.light,
          ),
          _buildThemeOption(
            context, ref,
            ThemeMode.dark,
            Iconsax.moon,
            currentMode == ThemeMode.dark,
          ),
          _buildThemeOption(
            context, ref,
            ThemeMode.system,
            Iconsax.mobile,
            currentMode == ThemeMode.system,
          ),
        ],
      ),
    );
  }
  
  Widget _buildThemeOption(
    BuildContext context,
    WidgetRef ref,
    ThemeMode mode,
    IconData icon,
    bool isSelected,
  ) {
    return GestureDetector(
      onTap: () {
        ref.read(themeModeProvider.notifier).state = mode;
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Icon(
          icon,
          size: 18,
          color: isSelected ? AppTheme.primaryColor : Colors.grey.shade500,
        ),
      ),
    );
  }
  
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'تسجيل الخروج',
          textDirection: TextDirection.rtl,
        ),
        content: const Text(
          'هل أنت متأكد من رغبتك في تسجيل الخروج؟',
          textDirection: TextDirection.rtl,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.go('/login');
            },
            child: const Text(
              'تسجيل الخروج',
              style: TextStyle(color: AppTheme.errorColor),
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingItem {
  final IconData icon;
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;
  
  _SettingItem({
    required this.icon,
    required this.title,
    this.trailing,
    this.onTap,
  });
}
