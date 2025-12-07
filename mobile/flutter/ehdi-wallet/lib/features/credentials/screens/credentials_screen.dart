import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

import '../../../core/config/router_config.dart';
import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';
import '../models/credential.dart';
import '../widgets/credential_card.dart';

class CredentialsScreen extends StatefulWidget {
  const CredentialsScreen({super.key});

  @override
  State<CredentialsScreen> createState() => _CredentialsScreenState();
}

class _CredentialsScreenState extends State<CredentialsScreen> 
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  // Mock credentials
  final List<Credential> _credentials = [
    Credential.mock(type: CredentialType.healthId),
    Credential.mock(type: CredentialType.medicalLicense),
    Credential.mock(type: CredentialType.insuranceCard),
    Credential.mock(type: CredentialType.vaccinationRecord),
  ];
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  List<Credential> get _activeCredentials => 
      _credentials.where((c) => c.status == CredentialStatus.active).toList();
  
  List<Credential> get _expiredCredentials => 
      _credentials.where((c) => c.status != CredentialStatus.active).toList();
  
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text(
          l10n.translate('my_credentials'),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.push('/credentials/add');
            },
            icon: const Icon(Iconsax.add_circle),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppTheme.primaryColor,
          unselectedLabelColor: AppTheme.textSecondary,
          indicatorColor: AppTheme.primaryColor,
          indicatorWeight: 3,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
          tabs: [
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Iconsax.tick_circle, size: 18),
                  const SizedBox(width: 8),
                  Text('نشطة (${_activeCredentials.length})'),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Iconsax.timer, size: 18),
                  const SizedBox(width: 8),
                  Text('منتهية (${_expiredCredentials.length})'),
                ],
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Active Credentials
          _buildCredentialsList(_activeCredentials),
          
          // Expired Credentials
          _buildCredentialsList(_expiredCredentials, isEmpty: _expiredCredentials.isEmpty),
        ],
      ),
    );
  }
  
  Widget _buildCredentialsList(List<Credential> credentials, {bool isEmpty = false}) {
    if (isEmpty || credentials.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Iconsax.card,
              size: 64,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 16),
            Text(
              'لا توجد اعتمادات',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey.shade500,
              ),
              textDirection: TextDirection.rtl,
            ),
          ],
        ),
      );
    }
    
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: credentials.length,
      itemBuilder: (context, index) {
        final credential = credentials[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: CredentialCard(
            credential: credential,
            onTap: () {
              context.push('/credentials/${credential.id}');
            },
          )
          .animate()
          .fadeIn(
            delay: Duration(milliseconds: index * 100),
            duration: 400.ms,
          )
          .slideY(begin: 0.2, end: 0),
        );
      },
    );
  }
}
