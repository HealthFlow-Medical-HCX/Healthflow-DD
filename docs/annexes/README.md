# EHDI Annexes

# ملاحق EHDI

This directory contains the normative annexes for the Egyptian Healthcare Digital Identity Architecture and Reference Framework.

---

## Annex List

| Annex | Title (EN) | Title (AR) | Status |
|-------|------------|------------|--------|
| [Annex 1](annex-01-hltr.md) | High-Level Technical Requirements | المتطلبات الفنية عالية المستوى | Draft |
| [Annex 2](annex-02-credential-schemas.md) | Credential Schemas | مخططات الاعتمادات | Draft |
| [Annex 3](annex-03-api-specifications.md) | API Specifications | مواصفات واجهات برمجة التطبيقات | Draft |
| [Annex 4](annex-04-security-requirements.md) | Security Requirements | متطلبات الأمان | Draft |
| [Annex 5](annex-05-eda-integration.md) | EDA Integration Guide | دليل تكامل هيئة الدواء | Draft |
| [Annex 6](annex-06-fra-compliance.md) | FRA Compliance Guide | دليل امتثال الرقابة المالية | Draft |
| [Annex 7](annex-07-testing-specifications.md) | Testing Specifications | مواصفات الاختبار | Draft |
| [Annex 8](annex-08-national-id-integration.md) | National ID Integration | تكامل الرقم القومي | Draft |

---

## Annex 1: High-Level Technical Requirements (HLTR)

The HLTR defines the mandatory and optional requirements for EHDI ecosystem participants. Requirements are organized by:

**Part 1: Actor-Specific Requirements**
- Wallet Unit Requirements (WU)
- Provider Requirements (PRV)
- Issuer Requirements (ISS)
- Relying Party Requirements (RP)

**Part 2: Ecosystem-Wide Requirements**
- Protocols & Interoperability (PIO)
- Data Models & Attestation Rules (DM)
- Security Requirements (SEC)
- Privacy Requirements (PRV)

---

## Annex 2: Credential Schemas

JSON Schema definitions for all EHDI credentials:

- Egyptian Health ID (EHI) Schema
- Healthcare Professional Credential (HPC) Schema
- Digital Prescription Schema
- Insurance Credential Schema
- Facility License Schema

---

## Annex 3: API Specifications

OpenAPI 3.0 specifications for:

- Credential Issuance API (OpenID4VCI)
- Credential Presentation API (OpenID4VP)
- Status Service API
- Trust Registry API
- HCX Gateway API

---

## Annex 4: Security Requirements

Detailed security specifications:

- Cryptographic requirements
- Key management
- Secure element specifications
- Authentication levels
- Audit logging requirements

---

## Annex 5: EDA Integration Guide

Integration specifications for Egyptian Drug Authority systems:

- Medicine Directory API
- Controlled Substance Tracking
- Prescription Validation
- Drug Interaction Checking

---

## Annex 6: FRA Compliance Guide

Financial Regulatory Authority compliance requirements:

- Claims Data Standards
- Anti-Fraud Measures
- Eligibility Verification
- Payment Processing

---

## Annex 7: Testing Specifications

Conformance testing requirements:

- Wallet Certification Tests
- Issuer Conformance Tests
- Verifier Conformance Tests
- Interoperability Tests

---

## Annex 8: National ID Integration

Egyptian National ID (الرقم القومي) integration specifications:

- ID Validation Rules
- Governorate Codes
- Civil Registry Integration
- Identity Proofing Requirements

---

## Document Conventions

### Requirement Levels

| Term | Arabic | Meaning |
|------|--------|---------|
| MUST | يجب | Absolute requirement |
| MUST NOT | يجب ألا | Absolute prohibition |
| SHOULD | ينبغي | Recommended |
| SHOULD NOT | ينبغي ألا | Not recommended |
| MAY | يجوز | Optional |

### Requirement Identifiers

Requirements are identified using the format: `[CATEGORY]-[NUMBER]`

Examples:
- `WU-001`: Wallet Unit requirement #1
- `SEC-042`: Security requirement #42
- `EDA-007`: EDA integration requirement #7

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 | December 2024 | Initial release |
