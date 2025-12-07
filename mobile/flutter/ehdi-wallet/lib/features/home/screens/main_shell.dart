import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

import '../../../core/config/router_config.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';

class MainShell extends StatefulWidget {
  final Widget child;
  
  const MainShell({
    super.key,
    required this.child,
  });

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;
  
  static const List<String> _routes = [
    Routes.home,
    Routes.credentials,
    Routes.prescriptions,
    Routes.settings,
  ];
  
  void _onItemTapped(int index) {
    if (index == _currentIndex) return;
    
    setState(() {
      _currentIndex = index;
    });
    
    context.go(_routes[index]);
  }
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateIndex();
  }
  
  void _updateIndex() {
    final location = GoRouterState.of(context).matchedLocation;
    
    for (int i = 0; i < _routes.length; i++) {
      if (location.startsWith(_routes[i])) {
        if (_currentIndex != i) {
          setState(() {
            _currentIndex = i;
          });
        }
        break;
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  index: 0,
                  icon: Iconsax.home_2,
                  activeIcon: Iconsax.home_25,
                  label: l10n.translate('home'),
                ),
                _buildNavItem(
                  index: 1,
                  icon: Iconsax.card,
                  activeIcon: Iconsax.card5,
                  label: l10n.translate('credentials'),
                ),
                _buildNavItem(
                  index: 2,
                  icon: Iconsax.document_text,
                  activeIcon: Iconsax.document_text_15,
                  label: l10n.translate('prescriptions'),
                ),
                _buildNavItem(
                  index: 3,
                  icon: Iconsax.setting_2,
                  activeIcon: Iconsax.setting_25,
                  label: l10n.translate('settings'),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _buildScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
  
  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required IconData activeIcon,
    required String label,
  }) {
    final isSelected = _currentIndex == index;
    
    return InkWell(
      onTap: () => _onItemTapped(index),
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected 
              ? AppTheme.primaryColor.withOpacity(0.1) 
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? activeIcon : icon,
              color: isSelected ? AppTheme.primaryColor : AppTheme.textSecondary,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected ? AppTheme.primaryColor : AppTheme.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildScanButton() {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withOpacity(0.3),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      child: FloatingActionButton(
        onPressed: () {
          _showScanOptions(context);
        },
        backgroundColor: AppTheme.primaryColor,
        elevation: 0,
        child: const Icon(
          Iconsax.scan,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }
  
  void _showScanOptions(BuildContext context) {
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
            // Handle
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            
            const SizedBox(height: 24),
            
            const Text(
              'اختر نوع المسح',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
              textDirection: TextDirection.rtl,
            ),
            
            const SizedBox(height: 24),
            
            // Scan QR Option
            _buildScanOption(
              icon: Iconsax.scan_barcode,
              title: 'مسح رمز QR',
              subtitle: 'امسح رمز QR لمشاركة أو استلام اعتماد',
              onTap: () {
                Navigator.pop(context);
                // Navigate to QR scanner
              },
            ),
            
            const SizedBox(height: 16),
            
            // Show QR Option
            _buildScanOption(
              icon: Iconsax.maximize_2,
              title: 'عرض رمز QR',
              subtitle: 'اعرض رمز QR الخاص بك للمشاركة',
              onTap: () {
                Navigator.pop(context);
                // Navigate to QR display
              },
            ),
            
            const SizedBox(height: 16),
            
            // NFC Option
            _buildScanOption(
              icon: Iconsax.wifi,
              title: 'مشاركة عبر NFC',
              subtitle: 'شارك اعتماداتك عبر NFC',
              onTap: () {
                Navigator.pop(context);
                // Navigate to NFC sharing
              },
            ),
            
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
  
  Widget _buildScanOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Icon(
                  icon,
                  color: AppTheme.primaryColor,
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
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppTheme.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
