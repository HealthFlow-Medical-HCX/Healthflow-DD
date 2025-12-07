import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../core/theme/app_theme.dart';

enum CredentialType {
  healthId,
  medicalLicense,
  pharmacyLicense,
  insuranceCard,
  vaccinationRecord,
  facilityCredential,
  prescriptionAuth,
  emergencyAccess,
}

enum CredentialStatus {
  active,
  pending,
  expired,
  revoked,
}

class Credential {
  final String id;
  final CredentialType type;
  final String title;
  final String titleAr;
  final String issuer;
  final String issuerAr;
  final DateTime issuedDate;
  final DateTime? expiryDate;
  final CredentialStatus status;
  final Map<String, dynamic> attributes;
  final String? qrData;
  
  Credential({
    required this.id,
    required this.type,
    required this.title,
    required this.titleAr,
    required this.issuer,
    required this.issuerAr,
    required this.issuedDate,
    this.expiryDate,
    required this.status,
    this.attributes = const {},
    this.qrData,
  });
  
  // Get icon based on credential type
  IconData get icon {
    switch (type) {
      case CredentialType.healthId:
        return Iconsax.health;
      case CredentialType.medicalLicense:
        return Iconsax.stickynote;
      case CredentialType.pharmacyLicense:
        return Iconsax.hospital;
      case CredentialType.insuranceCard:
        return Iconsax.shield_tick;
      case CredentialType.vaccinationRecord:
        return Iconsax.activity;
      case CredentialType.facilityCredential:
        return Iconsax.building;
      case CredentialType.prescriptionAuth:
        return Iconsax.document_text;
      case CredentialType.emergencyAccess:
        return Iconsax.warning_2;
    }
  }
  
  // Get color based on credential type
  Color get color {
    switch (type) {
      case CredentialType.healthId:
        return AppTheme.primaryColor;
      case CredentialType.medicalLicense:
        return const Color(0xFF3498DB);
      case CredentialType.pharmacyLicense:
        return const Color(0xFF9B59B6);
      case CredentialType.insuranceCard:
        return AppTheme.secondaryColor;
      case CredentialType.vaccinationRecord:
        return AppTheme.accentColor;
      case CredentialType.facilityCredential:
        return const Color(0xFF1ABC9C);
      case CredentialType.prescriptionAuth:
        return const Color(0xFFE67E22);
      case CredentialType.emergencyAccess:
        return AppTheme.errorColor;
    }
  }
  
  // Get status color
  Color get statusColor {
    switch (status) {
      case CredentialStatus.active:
        return AppTheme.successColor;
      case CredentialStatus.pending:
        return AppTheme.warningColor;
      case CredentialStatus.expired:
        return Colors.grey;
      case CredentialStatus.revoked:
        return AppTheme.errorColor;
    }
  }
  
  // Get status text in Arabic
  String get statusTextAr {
    switch (status) {
      case CredentialStatus.active:
        return 'نشط';
      case CredentialStatus.pending:
        return 'قيد الانتظار';
      case CredentialStatus.expired:
        return 'منتهي';
      case CredentialStatus.revoked:
        return 'ملغي';
    }
  }
  
  // Check if credential is valid
  bool get isValid {
    if (status != CredentialStatus.active) return false;
    if (expiryDate != null && expiryDate!.isBefore(DateTime.now())) {
      return false;
    }
    return true;
  }
  
  // Days until expiry
  int? get daysUntilExpiry {
    if (expiryDate == null) return null;
    return expiryDate!.difference(DateTime.now()).inDays;
  }
  
  // Factory constructor for mock data
  factory Credential.mock({
    required CredentialType type,
    CredentialStatus status = CredentialStatus.active,
  }) {
    final now = DateTime.now();
    
    switch (type) {
      case CredentialType.healthId:
        return Credential(
          id: 'HID-001',
          type: type,
          title: 'Health ID',
          titleAr: 'الرقم الصحي',
          issuer: 'Ministry of Health',
          issuerAr: 'وزارة الصحة والسكان',
          issuedDate: now.subtract(const Duration(days: 365)),
          expiryDate: now.add(const Duration(days: 365 * 4)),
          status: status,
          attributes: {
            'healthId': 'EG-HID-2024-00001234',
            'nationalId': '29901011234567',
          },
          qrData: 'EG-HID-2024-00001234',
        );
        
      case CredentialType.medicalLicense:
        return Credential(
          id: 'MED-001',
          type: type,
          title: 'Medical License',
          titleAr: 'رخصة مزاولة المهنة',
          issuer: 'Egyptian Medical Syndicate',
          issuerAr: 'نقابة الأطباء المصرية',
          issuedDate: now.subtract(const Duration(days: 730)),
          expiryDate: now.add(const Duration(days: 365)),
          status: status,
          attributes: {
            'licenseNumber': 'EG-MED-123456',
            'specialty': 'طب باطني',
            'grade': 'استشاري',
          },
          qrData: 'EG-MED-123456',
        );
        
      case CredentialType.insuranceCard:
        return Credential(
          id: 'INS-001',
          type: type,
          title: 'Universal Health Insurance',
          titleAr: 'التأمين الصحي الشامل',
          issuer: 'Universal Health Insurance Authority',
          issuerAr: 'الهيئة العامة للتأمين الصحي الشامل',
          issuedDate: now.subtract(const Duration(days: 180)),
          expiryDate: now.add(const Duration(days: 185)),
          status: status,
          attributes: {
            'insuranceNumber': 'UHI-2024-987654',
            'plan': 'الخطة الشاملة',
            'coverage': '100%',
          },
          qrData: 'UHI-2024-987654',
        );
        
      case CredentialType.vaccinationRecord:
        return Credential(
          id: 'VAC-001',
          type: type,
          title: 'Vaccination Record',
          titleAr: 'سجل التطعيمات',
          issuer: 'Ministry of Health',
          issuerAr: 'وزارة الصحة والسكان',
          issuedDate: now.subtract(const Duration(days: 90)),
          status: status,
          attributes: {
            'vaccines': [
              {'name': 'COVID-19', 'doses': 3, 'lastDate': '2024-01-15'},
              {'name': 'Hepatitis B', 'doses': 3, 'lastDate': '2023-06-20'},
            ],
          },
          qrData: 'VAC-2024-001234',
        );
        
      default:
        return Credential(
          id: 'GEN-001',
          type: type,
          title: 'Generic Credential',
          titleAr: 'اعتماد عام',
          issuer: 'Issuer',
          issuerAr: 'جهة الإصدار',
          issuedDate: now,
          status: status,
        );
    }
  }
  
  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.name,
      'title': title,
      'titleAr': titleAr,
      'issuer': issuer,
      'issuerAr': issuerAr,
      'issuedDate': issuedDate.toIso8601String(),
      'expiryDate': expiryDate?.toIso8601String(),
      'status': status.name,
      'attributes': attributes,
      'qrData': qrData,
    };
  }
  
  // Create from JSON
  factory Credential.fromJson(Map<String, dynamic> json) {
    return Credential(
      id: json['id'],
      type: CredentialType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => CredentialType.healthId,
      ),
      title: json['title'],
      titleAr: json['titleAr'],
      issuer: json['issuer'],
      issuerAr: json['issuerAr'],
      issuedDate: DateTime.parse(json['issuedDate']),
      expiryDate: json['expiryDate'] != null 
          ? DateTime.parse(json['expiryDate']) 
          : null,
      status: CredentialStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => CredentialStatus.pending,
      ),
      attributes: json['attributes'] ?? {},
      qrData: json['qrData'],
    );
  }
}
