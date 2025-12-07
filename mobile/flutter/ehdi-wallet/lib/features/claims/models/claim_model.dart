import 'package:flutter/material.dart';

/// Claim Status Enum
enum ClaimStatus {
  draft,
  submitted,
  pending,
  inReview,
  approved,
  rejected,
  paid,
  appealed,
}

extension ClaimStatusX on ClaimStatus {
  String get labelAr {
    switch (this) {
      case ClaimStatus.draft: return 'مسودة';
      case ClaimStatus.submitted: return 'تم الإرسال';
      case ClaimStatus.pending: return 'قيد الانتظار';
      case ClaimStatus.inReview: return 'قيد المراجعة';
      case ClaimStatus.approved: return 'موافق عليه';
      case ClaimStatus.rejected: return 'مرفوض';
      case ClaimStatus.paid: return 'تم الدفع';
      case ClaimStatus.appealed: return 'تم الاستئناف';
    }
  }

  String get labelEn {
    switch (this) {
      case ClaimStatus.draft: return 'Draft';
      case ClaimStatus.submitted: return 'Submitted';
      case ClaimStatus.pending: return 'Pending';
      case ClaimStatus.inReview: return 'In Review';
      case ClaimStatus.approved: return 'Approved';
      case ClaimStatus.rejected: return 'Rejected';
      case ClaimStatus.paid: return 'Paid';
      case ClaimStatus.appealed: return 'Appealed';
    }
  }

  Color get color {
    switch (this) {
      case ClaimStatus.draft: return Colors.grey;
      case ClaimStatus.submitted: return Colors.blue;
      case ClaimStatus.pending: return Colors.orange;
      case ClaimStatus.inReview: return Colors.purple;
      case ClaimStatus.approved: return Colors.green;
      case ClaimStatus.rejected: return Colors.red;
      case ClaimStatus.paid: return Colors.teal;
      case ClaimStatus.appealed: return Colors.amber;
    }
  }

  IconData get icon {
    switch (this) {
      case ClaimStatus.draft: return Icons.edit_note;
      case ClaimStatus.submitted: return Icons.send;
      case ClaimStatus.pending: return Icons.hourglass_empty;
      case ClaimStatus.inReview: return Icons.rate_review;
      case ClaimStatus.approved: return Icons.check_circle;
      case ClaimStatus.rejected: return Icons.cancel;
      case ClaimStatus.paid: return Icons.payments;
      case ClaimStatus.appealed: return Icons.gavel;
    }
  }
}

/// Claim Type Enum
enum ClaimType {
  outpatient,
  inpatient,
  pharmacy,
  laboratory,
  radiology,
  dental,
  optical,
  maternity,
  emergency,
  chronic,
}

extension ClaimTypeX on ClaimType {
  String get labelAr {
    switch (this) {
      case ClaimType.outpatient: return 'عيادات خارجية';
      case ClaimType.inpatient: return 'إقامة بالمستشفى';
      case ClaimType.pharmacy: return 'صيدلية';
      case ClaimType.laboratory: return 'تحاليل معملية';
      case ClaimType.radiology: return 'أشعة';
      case ClaimType.dental: return 'أسنان';
      case ClaimType.optical: return 'بصريات';
      case ClaimType.maternity: return 'ولادة';
      case ClaimType.emergency: return 'طوارئ';
      case ClaimType.chronic: return 'أمراض مزمنة';
    }
  }

  String get labelEn {
    switch (this) {
      case ClaimType.outpatient: return 'Outpatient';
      case ClaimType.inpatient: return 'Inpatient';
      case ClaimType.pharmacy: return 'Pharmacy';
      case ClaimType.laboratory: return 'Laboratory';
      case ClaimType.radiology: return 'Radiology';
      case ClaimType.dental: return 'Dental';
      case ClaimType.optical: return 'Optical';
      case ClaimType.maternity: return 'Maternity';
      case ClaimType.emergency: return 'Emergency';
      case ClaimType.chronic: return 'Chronic';
    }
  }

  IconData get icon {
    switch (this) {
      case ClaimType.outpatient: return Icons.local_hospital;
      case ClaimType.inpatient: return Icons.bed;
      case ClaimType.pharmacy: return Icons.medication;
      case ClaimType.laboratory: return Icons.science;
      case ClaimType.radiology: return Icons.radar;
      case ClaimType.dental: return Icons.mood;
      case ClaimType.optical: return Icons.visibility;
      case ClaimType.maternity: return Icons.child_friendly;
      case ClaimType.emergency: return Icons.emergency;
      case ClaimType.chronic: return Icons.favorite;
    }
  }
}

/// Health Claim Model
class HealthClaim {
  final String id;
  final String claimNumber;
  final ClaimType type;
  final ClaimStatus status;
  final String patientNationalId;
  final String patientName;
  final String providerName;
  final String providerLicense;
  final DateTime serviceDate;
  final DateTime submissionDate;
  final DateTime? processedDate;
  final double claimedAmount;
  final double? approvedAmount;
  final double? patientShare;
  final String? diagnosis;
  final String? diagnosisCode; // ICD-10
  final List<ClaimItem> items;
  final List<String> attachments;
  final String? rejectionReason;
  final String? notes;
  final String? insurerName;
  final String? policyNumber;
  final String? preAuthNumber;

  HealthClaim({
    required this.id,
    required this.claimNumber,
    required this.type,
    required this.status,
    required this.patientNationalId,
    required this.patientName,
    required this.providerName,
    required this.providerLicense,
    required this.serviceDate,
    required this.submissionDate,
    this.processedDate,
    required this.claimedAmount,
    this.approvedAmount,
    this.patientShare,
    this.diagnosis,
    this.diagnosisCode,
    this.items = const [],
    this.attachments = const [],
    this.rejectionReason,
    this.notes,
    this.insurerName,
    this.policyNumber,
    this.preAuthNumber,
  });

  factory HealthClaim.fromJson(Map<String, dynamic> json) {
    return HealthClaim(
      id: json['id'],
      claimNumber: json['claim_number'] ?? json['claimNumber'],
      type: ClaimType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => ClaimType.outpatient,
      ),
      status: ClaimStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => ClaimStatus.pending,
      ),
      patientNationalId: json['patient_national_id'] ?? json['patientNationalId'],
      patientName: json['patient_name'] ?? json['patientName'],
      providerName: json['provider_name'] ?? json['providerName'],
      providerLicense: json['provider_license'] ?? json['providerLicense'],
      serviceDate: DateTime.parse(json['service_date'] ?? json['serviceDate']),
      submissionDate: DateTime.parse(json['submission_date'] ?? json['submissionDate']),
      processedDate: json['processed_date'] != null
          ? DateTime.parse(json['processed_date'])
          : null,
      claimedAmount: (json['claimed_amount'] ?? json['claimedAmount']).toDouble(),
      approvedAmount: json['approved_amount']?.toDouble(),
      patientShare: json['patient_share']?.toDouble(),
      diagnosis: json['diagnosis'],
      diagnosisCode: json['diagnosis_code'] ?? json['diagnosisCode'],
      items: (json['items'] as List?)
              ?.map((e) => ClaimItem.fromJson(e))
              .toList() ??
          [],
      attachments: List<String>.from(json['attachments'] ?? []),
      rejectionReason: json['rejection_reason'] ?? json['rejectionReason'],
      notes: json['notes'],
      insurerName: json['insurer_name'] ?? json['insurerName'],
      policyNumber: json['policy_number'] ?? json['policyNumber'],
      preAuthNumber: json['pre_auth_number'] ?? json['preAuthNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'claim_number': claimNumber,
      'type': type.name,
      'status': status.name,
      'patient_national_id': patientNationalId,
      'patient_name': patientName,
      'provider_name': providerName,
      'provider_license': providerLicense,
      'service_date': serviceDate.toIso8601String(),
      'submission_date': submissionDate.toIso8601String(),
      'processed_date': processedDate?.toIso8601String(),
      'claimed_amount': claimedAmount,
      'approved_amount': approvedAmount,
      'patient_share': patientShare,
      'diagnosis': diagnosis,
      'diagnosis_code': diagnosisCode,
      'items': items.map((e) => e.toJson()).toList(),
      'attachments': attachments,
      'rejection_reason': rejectionReason,
      'notes': notes,
      'insurer_name': insurerName,
      'policy_number': policyNumber,
      'pre_auth_number': preAuthNumber,
    };
  }

  HealthClaim copyWith({
    String? id,
    String? claimNumber,
    ClaimType? type,
    ClaimStatus? status,
    String? patientNationalId,
    String? patientName,
    String? providerName,
    String? providerLicense,
    DateTime? serviceDate,
    DateTime? submissionDate,
    DateTime? processedDate,
    double? claimedAmount,
    double? approvedAmount,
    double? patientShare,
    String? diagnosis,
    String? diagnosisCode,
    List<ClaimItem>? items,
    List<String>? attachments,
    String? rejectionReason,
    String? notes,
    String? insurerName,
    String? policyNumber,
    String? preAuthNumber,
  }) {
    return HealthClaim(
      id: id ?? this.id,
      claimNumber: claimNumber ?? this.claimNumber,
      type: type ?? this.type,
      status: status ?? this.status,
      patientNationalId: patientNationalId ?? this.patientNationalId,
      patientName: patientName ?? this.patientName,
      providerName: providerName ?? this.providerName,
      providerLicense: providerLicense ?? this.providerLicense,
      serviceDate: serviceDate ?? this.serviceDate,
      submissionDate: submissionDate ?? this.submissionDate,
      processedDate: processedDate ?? this.processedDate,
      claimedAmount: claimedAmount ?? this.claimedAmount,
      approvedAmount: approvedAmount ?? this.approvedAmount,
      patientShare: patientShare ?? this.patientShare,
      diagnosis: diagnosis ?? this.diagnosis,
      diagnosisCode: diagnosisCode ?? this.diagnosisCode,
      items: items ?? this.items,
      attachments: attachments ?? this.attachments,
      rejectionReason: rejectionReason ?? this.rejectionReason,
      notes: notes ?? this.notes,
      insurerName: insurerName ?? this.insurerName,
      policyNumber: policyNumber ?? this.policyNumber,
      preAuthNumber: preAuthNumber ?? this.preAuthNumber,
    );
  }
}

/// Claim Item Model
class ClaimItem {
  final String id;
  final String code; // CPT/HCPCS code
  final String description;
  final String descriptionAr;
  final int quantity;
  final double unitPrice;
  final double totalPrice;
  final double? approvedPrice;
  final String? serviceType;

  ClaimItem({
    required this.id,
    required this.code,
    required this.description,
    required this.descriptionAr,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    this.approvedPrice,
    this.serviceType,
  });

  factory ClaimItem.fromJson(Map<String, dynamic> json) {
    return ClaimItem(
      id: json['id'],
      code: json['code'],
      description: json['description'],
      descriptionAr: json['description_ar'] ?? json['descriptionAr'] ?? json['description'],
      quantity: json['quantity'],
      unitPrice: (json['unit_price'] ?? json['unitPrice']).toDouble(),
      totalPrice: (json['total_price'] ?? json['totalPrice']).toDouble(),
      approvedPrice: json['approved_price']?.toDouble(),
      serviceType: json['service_type'] ?? json['serviceType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'description': description,
      'description_ar': descriptionAr,
      'quantity': quantity,
      'unit_price': unitPrice,
      'total_price': totalPrice,
      'approved_price': approvedPrice,
      'service_type': serviceType,
    };
  }
}

/// Claim Summary Statistics
class ClaimsSummary {
  final int totalClaims;
  final int pendingClaims;
  final int approvedClaims;
  final int rejectedClaims;
  final double totalClaimedAmount;
  final double totalApprovedAmount;
  final double totalPaidAmount;

  ClaimsSummary({
    required this.totalClaims,
    required this.pendingClaims,
    required this.approvedClaims,
    required this.rejectedClaims,
    required this.totalClaimedAmount,
    required this.totalApprovedAmount,
    required this.totalPaidAmount,
  });

  double get approvalRate => totalClaims > 0
      ? (approvedClaims / totalClaims) * 100
      : 0;
}
