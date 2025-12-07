import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/claim_model.dart';

/// Claim Detail Screen
class ClaimDetailScreen extends StatelessWidget {
  final HealthClaim claim;
  
  const ClaimDetailScreen({super.key, required this.claim});

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'ar_EG', symbol: 'ج.م ');
    final dateFormat = DateFormat('dd MMMM yyyy', 'ar');
    
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: CustomScrollView(
        slivers: [
          // App Bar with Status
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: claim.status.color,
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [claim.status.color, claim.status.color.withOpacity(0.8)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: SafeArea(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 40),
                        Icon(claim.status.icon, size: 48, color: Colors.white),
                        const SizedBox(height: 8),
                        Text(
                          claim.status.labelAr,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo',
                          ),
                        ),
                        Text(
                          '#${claim.claimNumber}',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 14,
                            fontFamily: 'Cairo',
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
                  // Amount Card
                  _buildAmountCard(currencyFormat),
                  const SizedBox(height: 16),
                  
                  // Claim Info Card
                  _buildInfoCard(
                    'معلومات المطالبة',
                    Icons.receipt_long,
                    [
                      _InfoRow('نوع المطالبة', claim.type.labelAr),
                      _InfoRow('تاريخ الخدمة', dateFormat.format(claim.serviceDate)),
                      _InfoRow('تاريخ الإرسال', dateFormat.format(claim.submissionDate)),
                      if (claim.processedDate != null)
                        _InfoRow('تاريخ المعالجة', dateFormat.format(claim.processedDate!)),
                      if (claim.preAuthNumber != null)
                        _InfoRow('رقم الموافقة المسبقة', claim.preAuthNumber!),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Provider Info Card
                  _buildInfoCard(
                    'مقدم الخدمة',
                    Icons.local_hospital,
                    [
                      _InfoRow('الاسم', claim.providerName),
                      _InfoRow('رقم الترخيص', claim.providerLicense),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Insurance Info Card
                  if (claim.insurerName != null)
                    _buildInfoCard(
                      'التأمين',
                      Icons.security,
                      [
                        _InfoRow('شركة التأمين', claim.insurerName!),
                        if (claim.policyNumber != null)
                          _InfoRow('رقم الوثيقة', claim.policyNumber!),
                      ],
                    ),
                  const SizedBox(height: 16),
                  
                  // Diagnosis Info Card
                  if (claim.diagnosis != null)
                    _buildInfoCard(
                      'التشخيص',
                      Icons.medical_information,
                      [
                        _InfoRow('التشخيص', claim.diagnosis!),
                        if (claim.diagnosisCode != null)
                          _InfoRow('رمز التشخيص (ICD-10)', claim.diagnosisCode!),
                      ],
                    ),
                  const SizedBox(height: 16),
                  
                  // Items Card
                  if (claim.items.isNotEmpty) ...[
                    _buildItemsCard(currencyFormat),
                    const SizedBox(height: 16),
                  ],
                  
                  // Rejection Reason Card
                  if (claim.status == ClaimStatus.rejected && claim.rejectionReason != null)
                    _buildRejectionCard(),
                  const SizedBox(height: 16),
                  
                  // Timeline Card
                  _buildTimelineCard(dateFormat),
                  const SizedBox(height: 16),
                  
                  // Actions
                  if (claim.status == ClaimStatus.rejected)
                    _buildAppealButton(context),
                  
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountCard(NumberFormat format) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'المبلغ المطلوب',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontFamily: 'Cairo',
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      format.format(claim.claimedAmount),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 50,
                color: Colors.grey[200],
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'المبلغ الموافق عليه',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontFamily: 'Cairo',
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      claim.approvedAmount != null
                          ? format.format(claim.approvedAmount)
                          : '--',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                        color: claim.approvedAmount != null
                            ? const Color(0xFF4CAF50)
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (claim.patientShare != null) ...[
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'حصة المريض',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 14,
                  ),
                ),
                Text(
                  format.format(claim.patientShare),
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFF9800),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, IconData icon, List<_InfoRow> rows) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF008B8B), size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                ),
              ),
            ],
          ),
          const Divider(height: 24),
          ...rows.map((row) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 120,
                  child: Text(
                    row.label,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontFamily: 'Cairo',
                      fontSize: 13,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    row.value,
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildItemsCard(NumberFormat format) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.list_alt, color: Color(0xFF008B8B), size: 20),
              SizedBox(width: 8),
              Text(
                'تفاصيل الخدمات',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                ),
              ),
            ],
          ),
          const Divider(height: 24),
          ...claim.items.map((item) => Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F7FA),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF008B8B).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        item.code,
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF008B8B),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        item.descriptionAr,
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'الكمية: ${item.quantity} × ${format.format(item.unitPrice)}',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          format.format(item.totalPrice),
                          style: const TextStyle(
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (item.approvedPrice != null)
                          Text(
                            'موافق: ${format.format(item.approvedPrice)}',
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 11,
                              color: Color(0xFF4CAF50),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildRejectionCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.red[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.error, color: Colors.red[700], size: 20),
              const SizedBox(width: 8),
              Text(
                'سبب الرفض',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                  color: Colors.red[700],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            claim.rejectionReason!,
            style: TextStyle(
              fontFamily: 'Cairo',
              color: Colors.red[900],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineCard(DateFormat format) {
    final events = <_TimelineEvent>[
      _TimelineEvent(
        'إنشاء المطالبة',
        claim.submissionDate,
        Icons.add_circle,
        Colors.blue,
        true,
      ),
    ];

    if (claim.status != ClaimStatus.draft && claim.status != ClaimStatus.submitted) {
      events.add(_TimelineEvent(
        'قيد المراجعة',
        claim.submissionDate.add(const Duration(hours: 2)),
        Icons.hourglass_empty,
        Colors.orange,
        claim.status != ClaimStatus.pending,
      ));
    }

    if (claim.processedDate != null) {
      events.add(_TimelineEvent(
        claim.status == ClaimStatus.approved || claim.status == ClaimStatus.paid
            ? 'تمت الموافقة'
            : 'تم الرفض',
        claim.processedDate!,
        claim.status == ClaimStatus.approved || claim.status == ClaimStatus.paid
            ? Icons.check_circle
            : Icons.cancel,
        claim.status == ClaimStatus.approved || claim.status == ClaimStatus.paid
            ? Colors.green
            : Colors.red,
        true,
      ));
    }

    if (claim.status == ClaimStatus.paid) {
      events.add(_TimelineEvent(
        'تم الدفع',
        claim.processedDate!.add(const Duration(days: 1)),
        Icons.payments,
        Colors.teal,
        true,
      ));
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.timeline, color: Color(0xFF008B8B), size: 20),
              SizedBox(width: 8),
              Text(
                'سجل المطالبة',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                ),
              ),
            ],
          ),
          const Divider(height: 24),
          ...events.asMap().entries.map((entry) {
            final index = entry.key;
            final event = entry.value;
            final isLast = index == events.length - 1;

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: event.completed
                            ? event.color
                            : event.color.withOpacity(0.2),
                      ),
                      child: Icon(
                        event.icon,
                        size: 16,
                        color: event.completed ? Colors.white : event.color,
                      ),
                    ),
                    if (!isLast)
                      Container(
                        width: 2,
                        height: 40,
                        color: event.completed ? event.color : Colors.grey[300],
                      ),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event.title,
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.bold,
                            color: event.completed ? Colors.black : Colors.grey,
                          ),
                        ),
                        Text(
                          format.format(event.date),
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildAppealButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          // Navigate to appeal screen
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('سيتم فتح نموذج الاستئناف', style: TextStyle(fontFamily: 'Cairo')),
            ),
          );
        },
        icon: const Icon(Icons.gavel, color: Colors.white),
        label: const Text(
          'تقديم استئناف',
          style: TextStyle(fontFamily: 'Cairo', color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }
}

class _InfoRow {
  final String label;
  final String value;
  _InfoRow(this.label, this.value);
}

class _TimelineEvent {
  final String title;
  final DateTime date;
  final IconData icon;
  final Color color;
  final bool completed;

  _TimelineEvent(this.title, this.date, this.icon, this.color, this.completed);
}
