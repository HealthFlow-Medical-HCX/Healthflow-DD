import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_theme.dart';
import '../../../l10n/app_localizations.dart';

class PrescriptionsScreen extends StatefulWidget {
  const PrescriptionsScreen({super.key});

  @override
  State<PrescriptionsScreen> createState() => _PrescriptionsScreenState();
}

class _PrescriptionsScreenState extends State<PrescriptionsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  // Mock prescriptions
  final List<_Prescription> _prescriptions = [
    _Prescription(
      id: 'RX-2024-001234',
      doctorName: 'د. محمد أحمد',
      doctorSpecialty: 'طب باطني',
      facilityName: 'مستشفى القاهرة التخصصي',
      date: DateTime.now().subtract(const Duration(days: 2)),
      status: _PrescriptionStatus.active,
      medications: [
        _Medication(
          name: 'أموكسيسيللين 500 مجم',
          dosage: 'كبسولة واحدة',
          frequency: '3 مرات يومياً',
          duration: '7 أيام',
        ),
        _Medication(
          name: 'باراسيتامول 500 مجم',
          dosage: 'قرص واحد',
          frequency: 'عند الحاجة',
          duration: '5 أيام',
        ),
      ],
      refillsRemaining: 2,
    ),
    _Prescription(
      id: 'RX-2024-001233',
      doctorName: 'د. سارة محمود',
      doctorSpecialty: 'طب أطفال',
      facilityName: 'عيادة الشفاء',
      date: DateTime.now().subtract(const Duration(days: 7)),
      status: _PrescriptionStatus.active,
      medications: [
        _Medication(
          name: 'فيتامين د 1000 وحدة',
          dosage: 'نقط 10',
          frequency: 'مرة يومياً',
          duration: '30 يوم',
        ),
      ],
      refillsRemaining: 5,
    ),
    _Prescription(
      id: 'RX-2024-001200',
      doctorName: 'د. أحمد علي',
      doctorSpecialty: 'أمراض قلب',
      facilityName: 'مركز القلب',
      date: DateTime.now().subtract(const Duration(days: 45)),
      status: _PrescriptionStatus.dispensed,
      medications: [
        _Medication(
          name: 'أسبرين 100 مجم',
          dosage: 'قرص واحد',
          frequency: 'مرة يومياً',
          duration: 'مستمر',
        ),
      ],
      refillsRemaining: 0,
    ),
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
  
  List<_Prescription> get _activePrescriptions =>
      _prescriptions.where((p) => p.status == _PrescriptionStatus.active).toList();
  
  List<_Prescription> get _historyPrescriptions =>
      _prescriptions.where((p) => p.status != _PrescriptionStatus.active).toList();
  
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text(
          l10n.translate('my_prescriptions'),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Iconsax.search_normal),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppTheme.primaryColor,
          unselectedLabelColor: AppTheme.textSecondary,
          indicatorColor: AppTheme.primaryColor,
          indicatorWeight: 3,
          tabs: [
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Iconsax.document_text, size: 18),
                  const SizedBox(width: 8),
                  Text('نشطة (${_activePrescriptions.length})'),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Iconsax.archive, size: 18),
                  const SizedBox(width: 8),
                  Text('السجل (${_historyPrescriptions.length})'),
                ],
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildPrescriptionsList(_activePrescriptions),
          _buildPrescriptionsList(_historyPrescriptions, isHistory: true),
        ],
      ),
    );
  }
  
  Widget _buildPrescriptionsList(List<_Prescription> prescriptions, {bool isHistory = false}) {
    if (prescriptions.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Iconsax.document_text,
              size: 64,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 16),
            Text(
              isHistory ? 'لا يوجد سجل وصفات' : 'لا توجد وصفات نشطة',
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
      itemCount: prescriptions.length,
      itemBuilder: (context, index) {
        final prescription = prescriptions[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _buildPrescriptionCard(prescription)
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
  
  Widget _buildPrescriptionCard(_Prescription prescription) {
    final dateFormat = DateFormat('dd MMM yyyy', 'ar');
    
    return InkWell(
      onTap: () {
        context.push('/prescriptions/${prescription.id}');
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppTheme.accentColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Icon(
                      Iconsax.document_text,
                      color: AppTheme.accentColor,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        prescription.doctorName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                      Text(
                        prescription.doctorSpecialty,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ),
                ),
                _buildStatusBadge(prescription.status),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Facility
            Row(
              children: [
                Icon(
                  Iconsax.hospital,
                  size: 16,
                  color: Colors.grey.shade500,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    prescription.facilityName,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            // Divider
            Container(
              height: 1,
              color: Colors.grey.shade100,
            ),
            
            const SizedBox(height: 12),
            
            // Medications
            ...prescription.medications.take(2).map((med) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: AppTheme.accentColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      med.name,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppTheme.textPrimary,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                  Text(
                    med.frequency,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade500,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ),
            )),
            
            if (prescription.medications.length > 2)
              Text(
                '+${prescription.medications.length - 2} أدوية أخرى',
                style: TextStyle(
                  fontSize: 12,
                  color: AppTheme.primaryColor,
                ),
                textDirection: TextDirection.rtl,
              ),
            
            const SizedBox(height: 12),
            
            // Footer
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Iconsax.calendar,
                      size: 14,
                      color: Colors.grey.shade500,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      dateFormat.format(prescription.date),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
                if (prescription.refillsRemaining > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.infoColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${prescription.refillsRemaining} تجديدات متبقية',
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppTheme.infoColor,
                        fontWeight: FontWeight.w500,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
              ],
            ),
            
            // Action Button for active prescriptions
            if (prescription.status == _PrescriptionStatus.active) ...[
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Iconsax.shop, size: 18),
                  label: const Text('صرف من الصيدلية'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.accentColor,
                    side: const BorderSide(color: AppTheme.accentColor),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
  
  Widget _buildStatusBadge(_PrescriptionStatus status) {
    Color color;
    String text;
    
    switch (status) {
      case _PrescriptionStatus.active:
        color = AppTheme.successColor;
        text = 'نشطة';
        break;
      case _PrescriptionStatus.dispensed:
        color = AppTheme.infoColor;
        text = 'تم الصرف';
        break;
      case _PrescriptionStatus.expired:
        color = Colors.grey;
        text = 'منتهية';
        break;
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}

// Mock data classes
enum _PrescriptionStatus { active, dispensed, expired }

class _Prescription {
  final String id;
  final String doctorName;
  final String doctorSpecialty;
  final String facilityName;
  final DateTime date;
  final _PrescriptionStatus status;
  final List<_Medication> medications;
  final int refillsRemaining;
  
  _Prescription({
    required this.id,
    required this.doctorName,
    required this.doctorSpecialty,
    required this.facilityName,
    required this.date,
    required this.status,
    required this.medications,
    required this.refillsRemaining,
  });
}

class _Medication {
  final String name;
  final String dosage;
  final String frequency;
  final String duration;
  
  _Medication({
    required this.name,
    required this.dosage,
    required this.frequency,
    required this.duration,
  });
}
