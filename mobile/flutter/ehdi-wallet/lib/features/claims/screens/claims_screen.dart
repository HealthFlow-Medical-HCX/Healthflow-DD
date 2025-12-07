import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/claim_model.dart';
import 'claim_detail_screen.dart';
import 'submit_claim_screen.dart';

/// Claims List Screen
class ClaimsScreen extends StatefulWidget {
  const ClaimsScreen({super.key});

  @override
  State<ClaimsScreen> createState() => _ClaimsScreenState();
}

class _ClaimsScreenState extends State<ClaimsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _currencyFormat = NumberFormat.currency(locale: 'ar_EG', symbol: 'ج.م ');
  
  // Filter state
  ClaimType? _selectedType;
  DateTimeRange? _dateRange;
  
  // Mock data - replace with API calls
  final List<HealthClaim> _claims = _generateMockClaims();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<HealthClaim> get _filteredClaims {
    var claims = _claims;
    
    // Filter by tab
    switch (_tabController.index) {
      case 1: // Pending
        claims = claims.where((c) => 
          c.status == ClaimStatus.pending || 
          c.status == ClaimStatus.submitted ||
          c.status == ClaimStatus.inReview
        ).toList();
        break;
      case 2: // Approved
        claims = claims.where((c) => 
          c.status == ClaimStatus.approved || 
          c.status == ClaimStatus.paid
        ).toList();
        break;
      case 3: // Rejected
        claims = claims.where((c) => c.status == ClaimStatus.rejected).toList();
        break;
    }
    
    // Filter by type
    if (_selectedType != null) {
      claims = claims.where((c) => c.type == _selectedType).toList();
    }
    
    // Filter by date range
    if (_dateRange != null) {
      claims = claims.where((c) => 
        c.serviceDate.isAfter(_dateRange!.start) && 
        c.serviceDate.isBefore(_dateRange!.end.add(const Duration(days: 1)))
      ).toList();
    }
    
    return claims;
  }

  ClaimsSummary get _summary {
    return ClaimsSummary(
      totalClaims: _claims.length,
      pendingClaims: _claims.where((c) => 
        c.status == ClaimStatus.pending || 
        c.status == ClaimStatus.submitted ||
        c.status == ClaimStatus.inReview
      ).length,
      approvedClaims: _claims.where((c) => 
        c.status == ClaimStatus.approved || 
        c.status == ClaimStatus.paid
      ).length,
      rejectedClaims: _claims.where((c) => c.status == ClaimStatus.rejected).length,
      totalClaimedAmount: _claims.fold(0, (sum, c) => sum + c.claimedAmount),
      totalApprovedAmount: _claims.fold(0, (sum, c) => sum + (c.approvedAmount ?? 0)),
      totalPaidAmount: _claims.where((c) => c.status == ClaimStatus.paid)
          .fold(0, (sum, c) => sum + (c.approvedAmount ?? 0)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text('المطالبات', style: TextStyle(fontFamily: 'Cairo')),
        backgroundColor: const Color(0xFF008B8B),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterSheet,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFFD4AF37),
          labelStyle: const TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.bold),
          unselectedLabelStyle: const TextStyle(fontFamily: 'Cairo'),
          tabs: [
            Tab(text: 'الكل (${_claims.length})'),
            Tab(text: 'قيد الانتظار (${_summary.pendingClaims})'),
            Tab(text: 'موافق (${_summary.approvedClaims})'),
            Tab(text: 'مرفوض (${_summary.rejectedClaims})'),
          ],
          onTap: (_) => setState(() {}),
        ),
      ),
      body: Column(
        children: [
          // Summary Card
          _buildSummaryCard(),
          
          // Claims List
          Expanded(
            child: _filteredClaims.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredClaims.length,
                    itemBuilder: (context, index) {
                      return _buildClaimCard(_filteredClaims[index]);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SubmitClaimScreen()),
          );
        },
        backgroundColor: const Color(0xFF008B8B),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'مطالبة جديدة',
          style: TextStyle(fontFamily: 'Cairo', color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF008B8B), Color(0xFF006666)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF008B8B).withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'ملخص المطالبات',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'نسبة القبول: ${_summary.approvalRate.toStringAsFixed(1)}%',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Cairo',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildSummaryItem(
                  'إجمالي المطالبات',
                  _currencyFormat.format(_summary.totalClaimedAmount),
                  Icons.receipt_long,
                ),
              ),
              Container(width: 1, height: 50, color: Colors.white24),
              Expanded(
                child: _buildSummaryItem(
                  'المبالغ الموافق عليها',
                  _currencyFormat.format(_summary.totalApprovedAmount),
                  Icons.check_circle,
                ),
              ),
              Container(width: 1, height: 50, color: Colors.white24),
              Expanded(
                child: _buildSummaryItem(
                  'المبالغ المدفوعة',
                  _currencyFormat.format(_summary.totalPaidAmount),
                  Icons.payments,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white70, size: 20),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            fontFamily: 'Cairo',
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 10,
            fontFamily: 'Cairo',
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildClaimCard(HealthClaim claim) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ClaimDetailScreen(claim: claim)),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: claim.status.color.withOpacity(0.1),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: claim.type.icon == Icons.medication
                          ? Colors.green.withOpacity(0.2)
                          : const Color(0xFF008B8B).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      claim.type.icon,
                      color: claim.type.icon == Icons.medication
                          ? Colors.green
                          : const Color(0xFF008B8B),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          claim.type.labelAr,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo',
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '#${claim.claimNumber}',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: claim.status.color,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(claim.status.icon, color: Colors.white, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          claim.status.labelAr,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildClaimRow(
                    Icons.local_hospital,
                    'مقدم الخدمة',
                    claim.providerName,
                  ),
                  const SizedBox(height: 8),
                  _buildClaimRow(
                    Icons.calendar_today,
                    'تاريخ الخدمة',
                    DateFormat('dd/MM/yyyy', 'ar').format(claim.serviceDate),
                  ),
                  if (claim.diagnosis != null) ...[
                    const SizedBox(height: 8),
                    _buildClaimRow(
                      Icons.medical_information,
                      'التشخيص',
                      claim.diagnosis!,
                    ),
                  ],
                  const Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'المبلغ المطلوب',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                              fontFamily: 'Cairo',
                            ),
                          ),
                          Text(
                            _currencyFormat.format(claim.claimedAmount),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              fontFamily: 'Cairo',
                            ),
                          ),
                        ],
                      ),
                      if (claim.approvedAmount != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'المبلغ الموافق عليه',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                                fontFamily: 'Cairo',
                              ),
                            ),
                            Text(
                              _currencyFormat.format(claim.approvedAmount),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                fontFamily: 'Cairo',
                                color: Color(0xFF4CAF50),
                              ),
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

  Widget _buildClaimRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 13,
            fontFamily: 'Cairo',
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontFamily: 'Cairo',
              fontSize: 13,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.receipt_long, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            'لا توجد مطالبات',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontFamily: 'Cairo',
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'أضف مطالبة جديدة للبدء',
            style: TextStyle(
              color: Colors.grey[500],
              fontFamily: 'Cairo',
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setSheetState) => Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'فلترة المطالبات',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setSheetState(() {
                        _selectedType = null;
                        _dateRange = null;
                      });
                      setState(() {});
                    },
                    child: const Text('إعادة تعيين', style: TextStyle(fontFamily: 'Cairo')),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'نوع المطالبة',
                style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Cairo'),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: ClaimType.values.map((type) {
                  final isSelected = _selectedType == type;
                  return FilterChip(
                    label: Text(type.labelAr, style: const TextStyle(fontFamily: 'Cairo')),
                    selected: isSelected,
                    onSelected: (selected) {
                      setSheetState(() {
                        _selectedType = selected ? type : null;
                      });
                      setState(() {});
                    },
                    selectedColor: const Color(0xFF008B8B).withOpacity(0.2),
                    checkmarkColor: const Color(0xFF008B8B),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              const Text(
                'نطاق التاريخ',
                style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Cairo'),
              ),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: () async {
                  final range = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime(2020),
                    lastDate: DateTime.now(),
                    locale: const Locale('ar'),
                  );
                  if (range != null) {
                    setSheetState(() => _dateRange = range);
                    setState(() {});
                  }
                },
                icon: const Icon(Icons.date_range),
                label: Text(
                  _dateRange != null
                      ? '${DateFormat('dd/MM/yyyy').format(_dateRange!.start)} - ${DateFormat('dd/MM/yyyy').format(_dateRange!.end)}'
                      : 'اختر نطاق التاريخ',
                  style: const TextStyle(fontFamily: 'Cairo'),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF008B8B),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'تطبيق الفلتر',
                    style: TextStyle(fontFamily: 'Cairo', color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Mock data generator
List<HealthClaim> _generateMockClaims() {
  return [
    HealthClaim(
      id: '1',
      claimNumber: 'CLM-2024-001234',
      type: ClaimType.outpatient,
      status: ClaimStatus.approved,
      patientNationalId: '29901011234567',
      patientName: 'محمد أحمد علي',
      providerName: 'مستشفى السلام الدولي',
      providerLicense: 'MOH-12345',
      serviceDate: DateTime.now().subtract(const Duration(days: 5)),
      submissionDate: DateTime.now().subtract(const Duration(days: 3)),
      processedDate: DateTime.now().subtract(const Duration(days: 1)),
      claimedAmount: 1500.00,
      approvedAmount: 1350.00,
      patientShare: 150.00,
      diagnosis: 'فحص طبي شامل',
      diagnosisCode: 'Z00.0',
      insurerName: 'شركة مصر للتأمين',
      policyNumber: 'POL-2024-5678',
      items: [
        ClaimItem(
          id: '1',
          code: '99213',
          description: 'Office visit - established patient',
          descriptionAr: 'زيارة عيادة - مريض متابعة',
          quantity: 1,
          unitPrice: 500,
          totalPrice: 500,
          approvedPrice: 450,
        ),
        ClaimItem(
          id: '2',
          code: '85025',
          description: 'Complete blood count',
          descriptionAr: 'صورة دم كاملة',
          quantity: 1,
          unitPrice: 200,
          totalPrice: 200,
          approvedPrice: 200,
        ),
      ],
    ),
    HealthClaim(
      id: '2',
      claimNumber: 'CLM-2024-001235',
      type: ClaimType.pharmacy,
      status: ClaimStatus.paid,
      patientNationalId: '29901011234567',
      patientName: 'محمد أحمد علي',
      providerName: 'صيدلية الشفاء',
      providerLicense: 'EDA-54321',
      serviceDate: DateTime.now().subtract(const Duration(days: 2)),
      submissionDate: DateTime.now().subtract(const Duration(days: 1)),
      processedDate: DateTime.now(),
      claimedAmount: 450.00,
      approvedAmount: 450.00,
      diagnosis: 'ارتفاع ضغط الدم',
      diagnosisCode: 'I10',
      insurerName: 'شركة مصر للتأمين',
      policyNumber: 'POL-2024-5678',
    ),
    HealthClaim(
      id: '3',
      claimNumber: 'CLM-2024-001236',
      type: ClaimType.laboratory,
      status: ClaimStatus.pending,
      patientNationalId: '29901011234567',
      patientName: 'محمد أحمد علي',
      providerName: 'معامل البرج',
      providerLicense: 'MOH-67890',
      serviceDate: DateTime.now().subtract(const Duration(days: 1)),
      submissionDate: DateTime.now(),
      claimedAmount: 850.00,
      diagnosis: 'فحوصات دورية',
      diagnosisCode: 'Z00.0',
      insurerName: 'شركة مصر للتأمين',
      policyNumber: 'POL-2024-5678',
    ),
    HealthClaim(
      id: '4',
      claimNumber: 'CLM-2024-001237',
      type: ClaimType.dental,
      status: ClaimStatus.rejected,
      patientNationalId: '29901011234567',
      patientName: 'محمد أحمد علي',
      providerName: 'عيادة ابتسامة',
      providerLicense: 'MOH-11111',
      serviceDate: DateTime.now().subtract(const Duration(days: 10)),
      submissionDate: DateTime.now().subtract(const Duration(days: 8)),
      processedDate: DateTime.now().subtract(const Duration(days: 5)),
      claimedAmount: 2500.00,
      diagnosis: 'تجميل الأسنان',
      diagnosisCode: 'K03.7',
      rejectionReason: 'خدمة تجميلية غير مغطاة بالوثيقة',
      insurerName: 'شركة مصر للتأمين',
      policyNumber: 'POL-2024-5678',
    ),
    HealthClaim(
      id: '5',
      claimNumber: 'CLM-2024-001238',
      type: ClaimType.radiology,
      status: ClaimStatus.inReview,
      patientNationalId: '29901011234567',
      patientName: 'محمد أحمد علي',
      providerName: 'مركز النيل للأشعة',
      providerLicense: 'MOH-22222',
      serviceDate: DateTime.now().subtract(const Duration(days: 3)),
      submissionDate: DateTime.now().subtract(const Duration(days: 2)),
      claimedAmount: 1200.00,
      diagnosis: 'آلام أسفل الظهر',
      diagnosisCode: 'M54.5',
      insurerName: 'شركة مصر للتأمين',
      policyNumber: 'POL-2024-5678',
    ),
  ];
}
