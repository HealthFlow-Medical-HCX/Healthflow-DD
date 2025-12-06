# EHDI High-Level Technical Requirements (HLTR)

# المتطلبات الفنية عالية المستوى

**Version 1.0.0 | December 2024**

---

## Overview

This document defines the High-Level Technical Requirements (HLTR) for the Egyptian Healthcare Digital Identity (EHDI) ecosystem. These requirements are normative and must be implemented by all ecosystem participants.

تحدد هذه الوثيقة المتطلبات الفنية عالية المستوى (HLTR) لمنظومة الهوية الرقمية للرعاية الصحية المصرية (EHDI). هذه المتطلبات معيارية ويجب تنفيذها من قبل جميع المشاركين في المنظومة.

---

## Requirement Levels

| Keyword | Arabic | Definition |
|---------|--------|------------|
| MUST | يجب | Absolute requirement |
| MUST NOT | يجب ألا | Absolute prohibition |
| SHOULD | ينبغي | Recommended but not mandatory |
| SHOULD NOT | ينبغي ألا | Not recommended |
| MAY | يجوز | Optional |

---

## Part 1: Actor-Specific Requirements

---

### 1. Wallet Unit Requirements (WU)

#### 1.1 General Requirements

**[WU-001]** Wallet Installation

The Wallet Unit MUST be installable on devices running:
- Android 8.0 (Oreo) or higher
- iOS 14.0 or higher

| Attribute | Value |
|-----------|-------|
| Category | Platform Support |
| Priority | High |
| Status | Approved |

---

**[WU-002]** Arabic Language Support

The Wallet Unit MUST provide full Arabic language support including:
- Right-to-left (RTL) text display
- Arabic numerals option
- Arabic credential labels
- Bilingual (Arabic/English) interface

| Attribute | Value |
|-----------|-------|
| Category | Localization |
| Priority | High |
| Status | Approved |

---

**[WU-003]** National ID Display

The Wallet Unit MUST display the Egyptian National ID (الرقم القومي) in the format:
- 14 digits grouped as: X-YYMMDD-GG-SSSS-V
- With Arabic labels

| Attribute | Value |
|-----------|-------|
| Category | Display |
| Priority | High |
| Status | Approved |

---

**[WU-004]** Secure Element Requirement

The Wallet Unit MUST utilize hardware-backed secure storage:
- Android: StrongBox or TEE
- iOS: Secure Enclave

| Attribute | Value |
|-----------|-------|
| Category | Security |
| Priority | High |
| Status | Approved |

---

**[WU-005]** Biometric Authentication

The Wallet Unit MUST support biometric authentication:
- Fingerprint recognition
- Face recognition (where hardware supports)
- PIN fallback required

| Attribute | Value |
|-----------|-------|
| Category | Authentication |
| Priority | High |
| Status | Approved |

---

**[WU-006]** Offline Capability

The Wallet Unit MUST support offline credential presentation for:
- Emergency health information
- Basic identity verification
- Cached credential status (with timestamp)

| Attribute | Value |
|-----------|-------|
| Category | Availability |
| Priority | Medium |
| Status | Approved |

---

**[WU-007]** Credential Backup

The Wallet Unit SHOULD support secure credential backup:
- Encrypted backup to user-controlled storage
- Recovery mechanism with identity re-verification
- No plaintext credential export

| Attribute | Value |
|-----------|-------|
| Category | Recovery |
| Priority | Medium |
| Status | Draft |

---

**[WU-008]** Audit Log Access

The Wallet Unit MUST provide users access to:
- Credential presentation history
- Issuer interaction history
- Data access log
- Minimum 12 months retention

| Attribute | Value |
|-----------|-------|
| Category | Transparency |
| Priority | High |
| Status | Approved |

---

#### 1.2 Credential Management Requirements

**[WU-010]** Credential Storage

The Wallet Unit MUST store credentials:
- Encrypted at rest (AES-256)
- Bound to device secure element
- Protected by user authentication

| Attribute | Value |
|-----------|-------|
| Category | Storage |
| Priority | High |
| Status | Approved |

---

**[WU-011]** Selective Disclosure

The Wallet Unit MUST support selective disclosure:
- Present individual attributes
- Support derived claims (e.g., age verification)
- User approval for each disclosure

| Attribute | Value |
|-----------|-------|
| Category | Privacy |
| Priority | High |
| Status | Approved |

---

**[WU-012]** Credential Status Check

The Wallet Unit MUST verify credential status before presentation:
- Check revocation status
- Verify validity period
- Display status to user

| Attribute | Value |
|-----------|-------|
| Category | Validity |
| Priority | High |
| Status | Approved |

---

### 2. Provider Requirements (PRV)

#### 2.1 Wallet Provider Requirements

**[PRV-001]** Certification Requirement

EHDI Wallet Providers MUST obtain certification from:
- Ministry of Health (healthcare compliance)
- ITIDA (security certification)
- FRA (financial services, if applicable)

| Attribute | Value |
|-----------|-------|
| Category | Certification |
| Priority | High |
| Status | Approved |

---

**[PRV-002]** Trust Registry Registration

EHDI Wallet Providers MUST register with the EHDI Trust Registry:
- Provider identification
- Wallet version information
- Security certification details
- Contact information

| Attribute | Value |
|-----------|-------|
| Category | Registration |
| Priority | High |
| Status | Approved |

---

**[PRV-003]** Update Mechanism

EHDI Wallet Providers MUST implement:
- Secure update delivery
- Version compatibility checking
- Mandatory security updates
- User notification of updates

| Attribute | Value |
|-----------|-------|
| Category | Maintenance |
| Priority | High |
| Status | Approved |

---

### 3. Issuer Requirements (ISS)

#### 3.1 General Issuer Requirements

**[ISS-001]** Issuer Authorization

Credential Issuers MUST be authorized by relevant regulatory body:
- Ministry of Health for EHI
- Medical Syndicates for HPC
- Insurance Providers for Insurance Credentials
- Healthcare Facilities for Prescriptions

| Attribute | Value |
|-----------|-------|
| Category | Authorization |
| Priority | High |
| Status | Approved |

---

**[ISS-002]** Identity Proofing

Issuers MUST perform identity proofing:
- National ID verification against Civil Registry
- Biometric verification (for high assurance)
- Document verification (as required)

| Attribute | Value |
|-----------|-------|
| Category | Identity |
| Priority | High |
| Status | Approved |

---

**[ISS-003]** Credential Format

Issuers MUST issue credentials in approved formats:
- SD-JWT for selective disclosure credentials
- mdoc (ISO 18013-5) for mobile documents
- JSON-LD for linked data requirements

| Attribute | Value |
|-----------|-------|
| Category | Format |
| Priority | High |
| Status | Approved |

---

**[ISS-004]** Issuance Protocol

Issuers MUST support OpenID4VCI protocol:
- Authorization Code flow
- Pre-authorized Code flow (for authorized issuers)
- Credential offer via deep link or QR

| Attribute | Value |
|-----------|-------|
| Category | Protocol |
| Priority | High |
| Status | Approved |

---

**[ISS-005]** Revocation Support

Issuers MUST implement credential revocation:
- Status list (preferred)
- Real-time status check endpoint
- Revocation reason codes

| Attribute | Value |
|-----------|-------|
| Category | Revocation |
| Priority | High |
| Status | Approved |

---

#### 3.2 Healthcare-Specific Issuer Requirements

**[ISS-010]** EDA Integration (Prescriptions)

Prescription Issuers MUST integrate with EDA:
- Medicine code validation
- Controlled substance authorization check
- Drug interaction warning integration

| Attribute | Value |
|-----------|-------|
| Category | EDA Compliance |
| Priority | High |
| Status | Approved |

---

**[ISS-011]** Syndicate Verification (HPC)

HPC Issuers MUST verify with relevant syndicate:
- Registration status
- Practice authorization
- Specialty certification
- Disciplinary status

| Attribute | Value |
|-----------|-------|
| Category | Professional Verification |
| Priority | High |
| Status | Approved |

---

### 4. Relying Party Requirements (RP)

#### 4.1 General Relying Party Requirements

**[RP-001]** Registration Requirement

Healthcare Relying Parties MUST register with EHDI Trust Registry:
- Facility identification
- Authorized credential types
- Data processing purposes
- Contact information

| Attribute | Value |
|-----------|-------|
| Category | Registration |
| Priority | High |
| Status | Approved |

---

**[RP-002]** Presentation Protocol

Relying Parties MUST support OpenID4VP:
- Same-device flow
- Cross-device flow (QR code)
- Presentation definition specification

| Attribute | Value |
|-----------|-------|
| Category | Protocol |
| Priority | High |
| Status | Approved |

---

**[RP-003]** Verification Requirements

Relying Parties MUST verify:
- Credential signature validity
- Issuer trust status
- Credential status (revocation)
- Validity period

| Attribute | Value |
|-----------|-------|
| Category | Verification |
| Priority | High |
| Status | Approved |

---

**[RP-004]** Data Minimization

Relying Parties MUST request only:
- Attributes necessary for the transaction
- Justified by stated purpose
- Approved in presentation policy

| Attribute | Value |
|-----------|-------|
| Category | Privacy |
| Priority | High |
| Status | Approved |

---

**[RP-005]** Consent Display

Relying Parties MUST display to users:
- Requested attributes (Arabic/English)
- Data processing purpose
- Data retention period
- Relying Party identification

| Attribute | Value |
|-----------|-------|
| Category | Transparency |
| Priority | High |
| Status | Approved |

---

## Part 2: Ecosystem-Wide Requirements

---

### 5. Protocol & Interoperability (PIO)

**[PIO-001]** OpenID4VCI Compliance

All credential issuance MUST comply with OpenID4VCI:
- Latest stable specification
- Egyptian profile extensions
- Arabic metadata support

| Attribute | Value |
|-----------|-------|
| Category | Issuance Protocol |
| Priority | High |
| Status | Approved |

---

**[PIO-002]** OpenID4VP Compliance

All credential presentation MUST comply with OpenID4VP:
- Latest stable specification
- Egyptian profile extensions
- Presentation exchange support

| Attribute | Value |
|-----------|-------|
| Category | Presentation Protocol |
| Priority | High |
| Status | Approved |

---

**[PIO-003]** FHIR R4 Compliance

Health data exchange MUST use FHIR R4:
- Egyptian FHIR profiles
- Arabic value sets
- Standard resource types

| Attribute | Value |
|-----------|-------|
| Category | Health Data |
| Priority | High |
| Status | Approved |

---

### 6. Data Models (DM)

**[DM-001]** Credential Schema Compliance

All credentials MUST conform to published schemas:
- JSON Schema validation
- Required attribute presence
- Data type conformance

| Attribute | Value |
|-----------|-------|
| Category | Schema |
| Priority | High |
| Status | Approved |

---

**[DM-002]** National ID Format

National ID attributes MUST:
- Be exactly 14 digits
- Pass check digit validation
- Include governorate code validation

| Attribute | Value |
|-----------|-------|
| Category | Identity |
| Priority | High |
| Status | Approved |

---

**[DM-003]** Arabic Name Handling

Arabic names MUST be stored:
- In Unicode (UTF-8)
- Without normalization that changes meaning
- With optional transliteration

| Attribute | Value |
|-----------|-------|
| Category | Localization |
| Priority | High |
| Status | Approved |

---

### 7. Security Requirements (SEC)

**[SEC-001]** Cryptographic Algorithms

EHDI implementations MUST use:
- ECDSA P-256 or P-384 for signatures
- ECDH P-256 or P-384 for key exchange
- AES-256-GCM for symmetric encryption
- SHA-256 or SHA-384 for hashing

| Attribute | Value |
|-----------|-------|
| Category | Cryptography |
| Priority | High |
| Status | Approved |

---

**[SEC-002]** TLS Requirements

All network communications MUST use:
- TLS 1.3 (preferred) or TLS 1.2
- Strong cipher suites only
- Certificate validation

| Attribute | Value |
|-----------|-------|
| Category | Transport |
| Priority | High |
| Status | Approved |

---

**[SEC-003]** Key Management

Cryptographic keys MUST be:
- Generated in secure environment
- Stored in HSM or secure element
- Never exported in plaintext
- Rotated according to policy

| Attribute | Value |
|-----------|-------|
| Category | Key Management |
| Priority | High |
| Status | Approved |

---

**[SEC-004]** Audit Logging

All ecosystem participants MUST log:
- Credential operations
- Authentication events
- Access control decisions
- Security events

| Attribute | Value |
|-----------|-------|
| Category | Audit |
| Priority | High |
| Status | Approved |

---

### 8. Privacy Requirements (PRV)

**[PRV-001]** Consent Management

All data sharing MUST be based on:
- Explicit user consent
- Clear purpose statement
- Revocable consent
- Auditable consent records

| Attribute | Value |
|-----------|-------|
| Category | Consent |
| Priority | High |
| Status | Approved |

---

**[PRV-002]** Data Minimization

Data collection and sharing MUST:
- Be limited to stated purpose
- Use selective disclosure
- Avoid unnecessary correlation

| Attribute | Value |
|-----------|-------|
| Category | Minimization |
| Priority | High |
| Status | Approved |

---

**[PRV-003]** Data Retention

Personal data MUST be:
- Retained only as necessary
- Deleted when purpose fulfilled
- Subject to legal retention requirements

| Attribute | Value |
|-----------|-------|
| Category | Retention |
| Priority | High |
| Status | Approved |

---

**[PRV-004]** User Rights

Systems MUST support user rights:
- Access to personal data
- Correction of inaccurate data
- Deletion (where permitted)
- Data portability

| Attribute | Value |
|-----------|-------|
| Category | Rights |
| Priority | High |
| Status | Approved |

---

## Requirements Summary

| Category | Total | MUST | SHOULD | MAY |
|----------|-------|------|--------|-----|
| Wallet Unit (WU) | 12 | 10 | 2 | 0 |
| Provider (PRV) | 3 | 3 | 0 | 0 |
| Issuer (ISS) | 7 | 7 | 0 | 0 |
| Relying Party (RP) | 5 | 5 | 0 | 0 |
| Protocol (PIO) | 3 | 3 | 0 | 0 |
| Data Model (DM) | 3 | 3 | 0 | 0 |
| Security (SEC) | 4 | 4 | 0 | 0 |
| Privacy (PRV) | 4 | 4 | 0 | 0 |
| **Total** | **41** | **39** | **2** | **0** |

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 | December 2024 | Initial release |

---

**Egyptian Healthcare Digital Identity**  
**Ministry of Health and Population**  
**Arab Republic of Egypt**
