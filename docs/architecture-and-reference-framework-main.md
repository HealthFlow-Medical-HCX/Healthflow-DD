# Egyptian Healthcare Digital Identity Architecture and Reference Framework

**Version 1.0.0 | December 2024**

---

## Document Information

| Attribute | Value |
|-----------|-------|
| Document Title | Egyptian Healthcare Digital Identity Architecture and Reference Framework |
| Version | 1.0.0 |
| Status | Draft for Public Consultation |
| Date | December 2024 |
| Classification | Public |

---

## Table of Contents

1. [Introduction](#1-introduction)
2. [Scope and Objectives](#2-scope-and-objectives)
3. [Regulatory Context](#3-regulatory-context)
4. [Design Principles](#4-design-principles)
5. [Ecosystem Overview](#5-ecosystem-overview)
6. [Core Components](#6-core-components)
7. [Wallet Architecture](#7-wallet-architecture)
8. [Credential Lifecycle](#8-credential-lifecycle)
9. [Trust Framework](#9-trust-framework)
10. [Security Architecture](#10-security-architecture)
11. [Interoperability](#11-interoperability)
12. [Privacy and Data Protection](#12-privacy-and-data-protection)
13. [Implementation Guidelines](#13-implementation-guidelines)
14. [Annexes Reference](#14-annexes-reference)

---

## 1. Introduction

### 1.1 Background

Egypt's healthcare sector serves over 105 million citizens through a complex network of public and private healthcare providers, pharmacies, insurance companies, and regulatory bodies. The current fragmented identity landscape creates challenges in patient identification, credential verification, insurance claims processing, and health data exchange.

The Egyptian Healthcare Digital Identity (EHDI) initiative addresses these challenges by establishing a comprehensive digital identity framework specifically designed for the healthcare ecosystem. This framework is strategically adapted from the European Digital Identity (EUDI) Architecture and Reference Framework, leveraging proven standards and specifications while localizing for Egypt's unique regulatory, cultural, and operational requirements.

### 1.2 Purpose of This Document

This Architecture and Reference Framework (ARF) serves three primary purposes:

1. **Explains the Architecture**: Details the system components and their interactions, serving as background information for the High-Level Technical Requirements (HLTR) found in the Annexes.

2. **Guides Implementation**: Acts as a common reference for the harmonized implementation of the EHDI across Egypt's healthcare ecosystem, guiding the development of technical specifications, standards, and operational procedures.

3. **Supports Development**: Provides foundation for developing the EHDI Wallet reference implementation and future regulatory updates based on technological advancements.

### 1.3 Relationship to EUDI Framework

The EHDI ARF maintains alignment with the EUDI ARF while introducing Egypt-specific adaptations:

| EUDI Concept | EHDI Adaptation | Rationale |
|--------------|-----------------|-----------|
| Person Identification Data (PID) | Egyptian Health ID (EHI) | Integration with 14-digit National ID |
| Member State | Egypt (Governorate-level) | 27 governorates with healthcare variations |
| eIDAS Regulation | Egyptian Healthcare Laws | Local regulatory compliance |
| Cross-border | Cross-governorate | National interoperability focus |
| QTSP | Egyptian Healthcare Trust Provider | Ministry-certified trust services |

---

## 2. Scope and Objectives

### 2.1 Scope

This document applies exclusively to the EHDI ecosystem within Egypt's healthcare sector. The scope includes:

**In Scope:**
- Patient digital identity and health credentials
- Healthcare professional credential verification
- Digital prescription management
- Health insurance claim processing
- Healthcare facility authentication
- Emergency health information access
- Cross-governorate health data portability

**Out of Scope:**
- Non-healthcare digital identity use cases
- International health credential recognition (future phase)
- Clinical decision support systems
- Electronic health record systems (integration only)

### 2.2 Objectives

The EHDI framework aims to achieve:

1. **Universal Healthcare Identification**: Enable any Egyptian citizen or resident to obtain a verified digital health identity
2. **Professional Credential Verification**: Provide instant verification of healthcare professional qualifications
3. **Prescription Integrity**: Ensure authenticity and traceability of digital prescriptions
4. **Claims Efficiency**: Streamline insurance claim submission and processing
5. **Privacy Preservation**: Give citizens control over their health data sharing
6. **Interoperability**: Enable seamless credential exchange across the healthcare ecosystem

---

## 3. Regulatory Context

### 3.1 Egyptian Healthcare Regulatory Framework

The EHDI operates under the oversight of multiple regulatory bodies:

#### 3.1.1 Egyptian Drug Authority (EDA) - هيئة الدواء المصرية

Established under Law No. 2/2018, the EDA is responsible for:
- Pharmaceutical product registration and approval
- Egyptian Medicine Directory maintenance (47,292+ registered medicines)
- Controlled substance scheduling and monitoring
- Digital prescription standards
- Drug safety and pharmacovigilance

**EHDI Integration**: The EHDI integrates with EDA systems for prescription validation, medicine directory lookup, and controlled substance tracking.

#### 3.1.2 Financial Regulatory Authority (FRA) - الهيئة العامة للرقابة المالية

The FRA oversees:
- Health insurance company licensing
- Claims processing standards
- Anti-fraud measures
- Financial compliance for healthcare payments

**EHDI Integration**: The EHDI enables compliant claims submission through the Healthcare Claims Exchange (HCX) with FRA-mandated data standards.

#### 3.1.3 Ministry of Health and Population - وزارة الصحة والسكان

The Ministry is responsible for:
- Healthcare policy and national health strategy
- Healthcare facility licensing and accreditation
- Healthcare workforce regulation
- Public health programs
- Electronic health record standards

**EHDI Integration**: The EHDI implements Ministry-defined healthcare credential standards and facility authentication requirements.

#### 3.1.4 Universal Health Insurance Authority (UHIA) - الهيئة العامة للتأمين الصحي الشامل

Under Law No. 151/2019, UHIA manages:
- Universal health insurance coverage implementation
- Beneficiary enrollment and eligibility
- Provider network management
- Benefits administration

**EHDI Integration**: The EHDI verifies insurance eligibility and facilitates universal health insurance credential issuance.

### 3.2 Applicable Laws and Regulations

| Law/Regulation | Relevance to EHDI |
|----------------|-------------------|
| Law No. 151/2019 (Universal Health Insurance) | Beneficiary identification, coverage verification |
| Law No. 2/2018 (EDA Establishment) | Prescription standards, medicine directory |
| Law No. 151/2020 (Personal Data Protection) | Data privacy, consent management |
| Ministerial Decree 1985/2014 | Electronic health record standards |
| FRA Circular 2023/47 | Digital health insurance claims |
| EDA Guidelines 2024 | Digital prescription requirements |

---

## 4. Design Principles

### 4.1 User-Centricity (المستخدم أولاً)

The EHDI places users—patients, healthcare professionals, and healthcare facilities—at the center of the design:

- **Accessibility**: Available to all citizens regardless of technical proficiency
- **Simplicity**: Intuitive interfaces with clear Arabic and English support
- **Control**: Users decide what information to share and with whom
- **Transparency**: Clear visibility into how health data is used

### 4.2 Privacy by Design (الخصوصية في التصميم)

Privacy protection is embedded into the architecture:

- **Data Minimization**: Request only necessary health information
- **Selective Disclosure**: Share specific attributes without revealing full credentials
- **Unlinkability**: Prevent tracking across different healthcare encounters
- **Consent Management**: Explicit user consent for data sharing

### 4.3 Security by Design (الأمان في التصميم)

Security is foundational:

- **Hardware-backed Security**: Credentials protected by secure elements
- **Cryptographic Protection**: Strong encryption for data at rest and in transit
- **Authentication Assurance**: Multi-factor authentication for sensitive operations
- **Audit Trail**: Immutable logging of all credential operations

### 4.4 Interoperability (قابلية التشغيل البيني)

The EHDI ensures seamless interaction across the healthcare ecosystem:

- **Open Standards**: Based on internationally recognized specifications
- **Protocol Compliance**: OpenID4VCI, OpenID4VP, FHIR R4
- **Cross-platform**: Works across iOS, Android, and web platforms
- **Legacy Integration**: Bridges to existing healthcare systems

### 4.5 Regulatory Compliance (الامتثال التنظيمي)

The EHDI adheres to Egyptian healthcare regulations:

- **EDA Compliance**: Medicine directory integration, prescription standards
- **FRA Compliance**: Claims processing, anti-fraud measures
- **Ministry Standards**: Healthcare credential requirements
- **Data Protection**: Personal Data Protection Law compliance

---

## 5. Ecosystem Overview

### 5.1 Ecosystem Participants

The EHDI ecosystem comprises multiple participant types:

#### 5.1.1 Credential Holders

| Holder Type | Arabic | Description |
|-------------|--------|-------------|
| Patients | المرضى | Citizens seeking healthcare services |
| Physicians | الأطباء | Licensed medical doctors |
| Pharmacists | الصيادلة | Licensed pharmacy professionals |
| Nurses | الممرضون | Licensed nursing professionals |
| Allied Health | المهنيون الصحيون | Other licensed healthcare workers |

#### 5.1.2 Credential Issuers

| Issuer | Arabic | Credentials Issued |
|--------|--------|-------------------|
| Ministry of Health | وزارة الصحة | Egyptian Health ID, Facility License |
| Medical Syndicate | نقابة الأطباء | Physician License |
| Pharmacists Syndicate | نقابة الصيادلة | Pharmacist License |
| Nursing Syndicate | نقابة التمريض | Nursing License |
| Insurance Providers | شركات التأمين | Insurance Credential |
| Healthcare Facilities | المنشآت الصحية | Digital Prescriptions |

#### 5.1.3 Relying Parties (Healthcare Relying Parties - HRPs)

| HRP Type | Arabic | Use Case |
|----------|--------|----------|
| Hospitals | المستشفيات | Patient identification, professional verification |
| Clinics | العيادات | Patient identification, prescription issuance |
| Pharmacies | الصيدليات | Prescription verification, dispensing |
| Laboratories | المعامل | Patient identification, result delivery |
| Insurance Companies | شركات التأمين | Claims verification, eligibility check |
| Emergency Services | الطوارئ | Emergency health information access |

### 5.2 High-Level Architecture

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                        EHDI ECOSYSTEM ARCHITECTURE                          │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│                           ┌─────────────────┐                               │
│                           │   Trust Layer   │                               │
│                           │   (الثقة)       │                               │
│                           └────────┬────────┘                               │
│                                    │                                        │
│    ┌───────────────────────────────┼───────────────────────────────┐       │
│    │                               │                               │       │
│    ▼                               ▼                               ▼       │
│ ┌──────────────┐          ┌──────────────┐          ┌──────────────┐      │
│ │   Issuers    │          │   Wallets    │          │   Verifiers  │      │
│ │  (المصدرون)  │◀────────▶│  (المحافظ)   │◀────────▶│  (المحققون)  │      │
│ └──────┬───────┘          └──────┬───────┘          └──────┬───────┘      │
│        │                         │                         │              │
│        │    ┌────────────────────┼────────────────────┐    │              │
│        │    │                    │                    │    │              │
│        ▼    ▼                    ▼                    ▼    ▼              │
│    ┌─────────────────────────────────────────────────────────────┐       │
│    │                    EHDI Gateway (HCX Egypt)                  │       │
│    │                    بوابة EHDI (منصة HCX)                     │       │
│    └─────────────────────────────────────────────────────────────┘       │
│                                    │                                      │
│    ┌───────────────────────────────┼───────────────────────────────┐     │
│    │               │               │               │               │     │
│    ▼               ▼               ▼               ▼               ▼     │
│ ┌──────┐      ┌──────┐       ┌──────┐       ┌──────┐       ┌──────┐    │
│ │ EDA  │      │ FRA  │       │ MoH  │       │ UHIA │       │Civil │    │
│ │هيئة  │      │الرقابة│       │الصحة │       │التأمين│       │المدني│    │
│ │الدواء│      │المالية│       │      │       │الشامل│       │      │    │
│ └──────┘      └──────┘       └──────┘       └──────┘       └──────┘    │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 5.3 Functional Overview

The EHDI ecosystem supports the following primary functions:

1. **Identity Proofing**: Verification of user identity against authoritative sources
2. **Credential Issuance**: Generation and delivery of digital credentials to wallets
3. **Credential Storage**: Secure storage of credentials within user-controlled wallets
4. **Credential Presentation**: Selective sharing of credentials with relying parties
5. **Credential Verification**: Validation of credential authenticity and validity
6. **Credential Revocation**: Invalidation of credentials when necessary

---

## 6. Core Components

### 6.1 Egyptian Health ID (EHI)

The Egyptian Health ID is the foundational credential that binds a person's National ID to their healthcare identity.

#### 6.1.1 EHI Attributes

| Attribute | Arabic | Type | Source | Required |
|-----------|--------|------|--------|----------|
| national_id | الرقم القومي | string(14) | Civil Registry | Yes |
| full_name_ar | الاسم الكامل بالعربية | string | Civil Registry | Yes |
| full_name_en | الاسم الكامل بالإنجليزية | string | Civil Registry | Yes |
| date_of_birth | تاريخ الميلاد | date | Civil Registry | Yes |
| gender | النوع | enum | Civil Registry | Yes |
| governorate | المحافظة | string | Civil Registry | Yes |
| blood_type | فصيلة الدم | enum | Health Registry | Optional |
| emergency_contact | جهة الاتصال للطوارئ | object | User | Optional |
| chronic_conditions | الأمراض المزمنة | array | Health Registry | Optional |
| allergies | الحساسية | array | Health Registry | Optional |
| vaccination_status | حالة التطعيم | array | Health Registry | Optional |

#### 6.1.2 EHI Issuance

The EHI is issued by the Ministry of Health through authorized registration points:

1. **Identity Verification**: National ID verified against Civil Registry
2. **Biometric Capture**: Photo and fingerprint (if required)
3. **Health Data Linking**: Optional linking to existing health records
4. **Credential Generation**: Cryptographic credential created
5. **Wallet Delivery**: Credential delivered to user's EHDI Wallet

### 6.2 Healthcare Professional Credential (HPC)

The HPC verifies a healthcare professional's qualifications and practice authorization.

#### 6.2.1 HPC Attributes

| Attribute | Arabic | Type | Source | Required |
|-----------|--------|------|--------|----------|
| national_id | الرقم القومي | string(14) | Civil Registry | Yes |
| syndicate_number | رقم القيد النقابي | string | Syndicate | Yes |
| license_number | رقم الترخيص | string | Ministry of Health | Yes |
| profession_type | نوع المهنة | enum | Syndicate | Yes |
| specialty | التخصص | string | Syndicate | Optional |
| sub_specialty | التخصص الفرعي | string | Syndicate | Optional |
| license_issue_date | تاريخ إصدار الترخيص | date | Ministry | Yes |
| license_expiry_date | تاريخ انتهاء الترخيص | date | Ministry | Yes |
| practice_status | حالة المزاولة | enum | Syndicate | Yes |
| facility_affiliations | المنشآت التابع لها | array | Facility Registry | Optional |
| controlled_substance_auth | تصريح الأدوية المراقبة | boolean | EDA | Optional |

#### 6.2.2 Profession Types

| Type | Arabic | Issuing Syndicate |
|------|--------|-------------------|
| PHYSICIAN | طبيب | نقابة الأطباء |
| DENTIST | طبيب أسنان | نقابة الأطباء |
| PHARMACIST | صيدلي | نقابة الصيادلة |
| NURSE | ممرض | نقابة التمريض |
| PHYSIOTHERAPIST | أخصائي علاج طبيعي | نقابة العلاج الطبيعي |
| LAB_TECHNICIAN | فني معمل | النقابات العلمية |

### 6.3 Digital Prescription Credential

The Digital Prescription Credential represents an electronic prescription integrated with the EDA Medicine Directory.

#### 6.3.1 Prescription Attributes

| Attribute | Arabic | Type | Description |
|-----------|--------|------|-------------|
| prescription_id | رقم الوصفة | uuid | Unique identifier |
| prescriber_hpc | اعتماد الطبيب | HPC reference | Issuing professional |
| patient_ehi | هوية المريض | EHI reference | Patient identifier |
| issue_timestamp | وقت الإصدار | datetime | Creation time |
| facility_id | معرف المنشأة | string | Issuing facility |
| diagnosis_codes | أكواد التشخيص | array | ICD-10 codes |
| medications | الأدوية | array | Prescribed medicines |
| validity_period | فترة الصلاحية | duration | Prescription validity |
| digital_signature | التوقيع الرقمي | signature | Prescriber signature |

#### 6.3.2 Medication Item Structure

| Attribute | Arabic | Type | Source |
|-----------|--------|------|--------|
| eda_code | كود هيئة الدواء | string | EDA Directory |
| trade_name | الاسم التجاري | string | EDA Directory |
| generic_name | الاسم العلمي | string | EDA Directory |
| dosage_form | الشكل الدوائي | enum | EDA Directory |
| strength | التركيز | string | EDA Directory |
| quantity | الكمية | integer | Prescriber |
| dosage_instructions | تعليمات الجرعة | string | Prescriber |
| frequency | التكرار | string | Prescriber |
| duration | المدة | string | Prescriber |
| refills_authorized | إعادات الصرف المصرح بها | integer | Prescriber |
| controlled_schedule | جدول المراقبة | enum | EDA Directory |

### 6.4 Insurance Credential

The Insurance Credential represents health insurance coverage information.

#### 6.4.1 Insurance Attributes

| Attribute | Arabic | Type | Source |
|-----------|--------|------|--------|
| insurance_id | رقم التأمين | string | Insurer |
| insurer_code | كود شركة التأمين | string | FRA Registry |
| insurer_name | اسم شركة التأمين | string | FRA Registry |
| policy_number | رقم الوثيقة | string | Insurer |
| coverage_type | نوع التغطية | enum | Policy |
| coverage_start | بداية التغطية | date | Policy |
| coverage_end | نهاية التغطية | date | Policy |
| beneficiary_type | نوع المستفيد | enum | Policy |
| copayment_rate | نسبة المشاركة | decimal | Policy |
| annual_limit | الحد السنوي | decimal | Policy |
| network_type | نوع الشبكة | enum | Policy |
| pre_auth_required | موافقة مسبقة مطلوبة | array | Policy |

---

## 7. Wallet Architecture

### 7.1 EHDI Wallet Overview

The EHDI Wallet is a secure mobile application that enables users to store, manage, and present their healthcare credentials.

### 7.2 Wallet Components

```
┌─────────────────────────────────────────────────────────────────┐
│                     EHDI WALLET ARCHITECTURE                    │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │                    User Interface                        │   │
│  │                   (واجهة المستخدم)                       │   │
│  │  ┌───────────┐ ┌───────────┐ ┌───────────┐ ┌─────────┐  │   │
│  │  │Credentials│ │  Present  │ │  History  │ │Settings │  │   │
│  │  │الاعتمادات │ │   تقديم   │ │  السجل   │ │الإعدادات│  │   │
│  │  └───────────┘ └───────────┘ └───────────┘ └─────────┘  │   │
│  └─────────────────────────────────────────────────────────┘   │
│                              │                                  │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │                  Wallet Core Engine                      │   │
│  │                 (محرك المحفظة الأساسي)                   │   │
│  │  ┌──────────────────────────────────────────────────┐   │   │
│  │  │ Credential    │ Protocol    │ Consent            │   │   │
│  │  │ Manager       │ Handler     │ Manager            │   │   │
│  │  │ إدارة         │ معالج       │ إدارة              │   │   │
│  │  │ الاعتمادات    │ البروتوكول  │ الموافقات          │   │   │
│  │  └──────────────────────────────────────────────────┘   │   │
│  └─────────────────────────────────────────────────────────┘   │
│                              │                                  │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │              Wallet Secure Cryptographic Device          │   │
│  │              (جهاز التشفير الآمن للمحفظة)                │   │
│  │  ┌──────────────────────────────────────────────────┐   │   │
│  │  │ Key           │ Signature   │ Encryption         │   │   │
│  │  │ Management    │ Operations  │ Operations         │   │   │
│  │  │ إدارة         │ عمليات      │ عمليات             │   │   │
│  │  │ المفاتيح      │ التوقيع     │ التشفير            │   │   │
│  │  └──────────────────────────────────────────────────┘   │   │
│  └─────────────────────────────────────────────────────────┘   │
│                              │                                  │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │                   Secure Element                         │   │
│  │                  (العنصر الآمن)                          │   │
│  │           Hardware-backed key storage                    │   │
│  │           تخزين المفاتيح المدعوم بالأجهزة                │   │
│  └─────────────────────────────────────────────────────────┘   │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### 7.3 Wallet Security Requirements

| Requirement | Description |
|-------------|-------------|
| Secure Element | Hardware-backed cryptographic key storage |
| Biometric Authentication | Fingerprint or face recognition for access |
| PIN Protection | User-defined PIN as backup authentication |
| Remote Wipe | Capability to remotely erase wallet data |
| Tamper Detection | Detection of device compromise attempts |
| Secure Communication | TLS 1.3 for all network communications |

### 7.4 Supported Platforms

| Platform | Minimum Version | Secure Element |
|----------|-----------------|----------------|
| Android | 8.0 (Oreo) | StrongBox/TEE |
| iOS | 14.0 | Secure Enclave |
| Web | Modern browsers | WebAuthn |

---

## 8. Credential Lifecycle

### 8.1 Lifecycle States

```
┌─────────────────────────────────────────────────────────────────┐
│                    CREDENTIAL LIFECYCLE                         │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│    ┌──────────┐                                                 │
│    │ Requested│                                                 │
│    │  مطلوب   │                                                 │
│    └────┬─────┘                                                 │
│         │ Identity Proofing                                     │
│         ▼                                                       │
│    ┌──────────┐                                                 │
│    │  Issued  │◀──────────────────────────────┐                │
│    │  صادر    │                               │                │
│    └────┬─────┘                               │                │
│         │ Reaches validity start              │ Renewed        │
│         ▼                                     │ مجدد           │
│    ┌──────────┐                               │                │
│    │  Valid   │───────────────────────────────┘                │
│    │  صالح    │                                                 │
│    └────┬─────┘                                                 │
│         │                                                       │
│    ┌────┴────────────────┬───────────────────┐                 │
│    │                     │                   │                 │
│    ▼                     ▼                   ▼                 │
│ ┌──────────┐      ┌──────────┐       ┌──────────┐             │
│ │ Expired  │      │ Suspended│       │ Revoked  │             │
│ │ منتهي    │      │  موقوف   │       │  ملغي    │             │
│ └──────────┘      └────┬─────┘       └──────────┘             │
│                        │                                       │
│                        │ Reinstated                            │
│                        │ مُستعاد                               │
│                        ▼                                       │
│                   ┌──────────┐                                 │
│                   │  Valid   │                                 │
│                   │  صالح    │                                 │
│                   └──────────┘                                 │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### 8.2 State Definitions

| State | Arabic | Description |
|-------|--------|-------------|
| Requested | مطلوب | Credential request submitted, pending identity proofing |
| Issued | صادر | Credential generated but not yet valid |
| Valid | صالح | Credential is active and can be presented |
| Expired | منتهي | Credential validity period has ended |
| Suspended | موقوف | Credential temporarily invalidated |
| Revoked | ملغي | Credential permanently invalidated |

### 8.3 Issuance Protocol

The EHDI uses OpenID4VCI for credential issuance:

1. **Discovery**: Wallet discovers issuer metadata
2. **Authorization**: User authorizes credential request
3. **Token Exchange**: Wallet obtains access token
4. **Credential Request**: Wallet requests credential
5. **Credential Response**: Issuer returns signed credential
6. **Storage**: Wallet stores credential securely

### 8.4 Presentation Protocol

The EHDI uses OpenID4VP for credential presentation:

1. **Request**: Verifier sends presentation request
2. **Selection**: User selects credentials to present
3. **Consent**: User approves presentation
4. **Response**: Wallet sends verifiable presentation
5. **Verification**: Verifier validates presentation

---

## 9. Trust Framework

### 9.1 Trust Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                      EHDI TRUST FRAMEWORK                       │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│                    ┌──────────────────┐                         │
│                    │  EHDI Root CA    │                         │
│                    │ (Ministry of IT) │                         │
│                    └────────┬─────────┘                         │
│                             │                                   │
│         ┌───────────────────┼───────────────────┐              │
│         │                   │                   │              │
│         ▼                   ▼                   ▼              │
│    ┌─────────┐        ┌─────────┐        ┌─────────┐          │
│    │  MoH    │        │   EDA   │        │   FRA   │          │
│    │ Sub-CA  │        │ Sub-CA  │        │ Sub-CA  │          │
│    └────┬────┘        └────┬────┘        └────┬────┘          │
│         │                  │                  │                │
│    ┌────┴────┐        ┌────┴────┐        ┌────┴────┐          │
│    │         │        │         │        │         │          │
│    ▼         ▼        ▼         ▼        ▼         ▼          │
│ ┌─────┐  ┌─────┐  ┌─────┐  ┌─────┐  ┌─────┐  ┌─────┐        │
│ │EHI  │  │HPC  │  │Rx   │  │Drug │  │Ins  │  │Claim│        │
│ │Issuer│ │Issuer│ │Issuer│ │DB   │  │Issuer│ │Proc │        │
│ └─────┘  └─────┘  └─────┘  └─────┘  └─────┘  └─────┘        │
│                                                                 │
│  ┌───────────────────────────────────────────────────────────┐ │
│  │                    Trusted Lists                          │ │
│  │                   (قوائم الثقة)                           │ │
│  │  • Authorized Issuers        • Authorized Verifiers       │ │
│  │  • Wallet Providers          • Trust Service Providers    │ │
│  └───────────────────────────────────────────────────────────┘ │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### 9.2 Trust Service Providers

| Provider Type | Arabic | Role |
|---------------|--------|------|
| Credential Issuer | مصدر الاعتمادات | Issues verifiable credentials |
| Wallet Provider | مقدم المحفظة | Provides EHDI Wallet application |
| Trust Service Provider | مقدم خدمات الثقة | Provides cryptographic services |
| Status Service | خدمة الحالة | Provides credential status information |

### 9.3 Trusted Lists

The EHDI maintains trusted lists for:

1. **Authorized Credential Issuers**: Entities permitted to issue EHDI credentials
2. **Certified Wallet Providers**: Approved EHDI Wallet implementations
3. **Registered Relying Parties**: Healthcare entities authorized to verify credentials
4. **Trust Service Providers**: Certified cryptographic service providers

---

## 10. Security Architecture

### 10.1 Security Objectives

| Objective | Description |
|-----------|-------------|
| Confidentiality | Health data accessible only to authorized parties |
| Integrity | Credentials cannot be modified without detection |
| Availability | System accessible when needed for healthcare |
| Authentication | Verify identity of all ecosystem participants |
| Non-repudiation | Prevent denial of credential operations |
| Privacy | Protect personal health information |

### 10.2 Cryptographic Standards

| Function | Algorithm | Key Size |
|----------|-----------|----------|
| Credential Signing | ECDSA | P-256 |
| Key Exchange | ECDH | P-256 |
| Encryption (at rest) | AES-GCM | 256-bit |
| Encryption (in transit) | TLS 1.3 | - |
| Hashing | SHA-256/SHA-384 | - |
| Selective Disclosure | SD-JWT | - |

### 10.3 Authentication Levels

| Level | Arabic | Requirements | Use Cases |
|-------|--------|--------------|-----------|
| Low | منخفض | Password/PIN | View credentials |
| Substantial | متوسط | Password + device binding | Present credentials |
| High | عالي | Biometric + device binding | Sign prescriptions |

---

## 11. Interoperability

### 11.1 Standards Compliance

| Standard | Version | Application |
|----------|---------|-------------|
| OpenID4VCI | 1.0 | Credential issuance |
| OpenID4VP | 1.0 | Credential presentation |
| SD-JWT | Draft 07 | Selective disclosure |
| FHIR | R4 | Health data exchange |
| HL7 v2.x | 2.8.2 | Legacy integration |
| ICD-10-AM | 2022 | Diagnosis coding |
| ISO/IEC 18013-5 | 2021 | Mobile document |

### 11.2 Data Formats

| Format | Use |
|--------|-----|
| JSON | API communication |
| CBOR | Compact credential encoding |
| JWT | Token format |
| XML | Legacy system integration |

### 11.3 Integration Patterns

The EHDI supports multiple integration patterns:

1. **Direct Integration**: Native OpenID4VP/VCI implementation
2. **Gateway Integration**: Through EHDI Gateway (HCX Egypt)
3. **Legacy Bridge**: HL7/FHIR translation layer
4. **Batch Processing**: Bulk credential verification

---

## 12. Privacy and Data Protection

### 12.1 Privacy Principles

| Principle | Arabic | Implementation |
|-----------|--------|----------------|
| Data Minimization | تقليل البيانات | Request only necessary attributes |
| Purpose Limitation | تحديد الغرض | Use data only for stated purpose |
| Storage Limitation | تحديد التخزين | Retain data only as needed |
| Accuracy | الدقة | Keep credentials up to date |
| Integrity & Confidentiality | النزاهة والسرية | Secure data handling |
| Accountability | المساءلة | Audit trail of data access |

### 12.2 Selective Disclosure

The EHDI implements selective disclosure allowing users to share only specific attributes:

**Example: Age Verification for Controlled Substance**
- Full credential contains: name, date of birth, national ID, address
- Disclosed: "over_21: true" (derived claim)
- Not disclosed: actual date of birth, national ID

### 12.3 Consent Management

| Consent Type | Arabic | Description |
|--------------|--------|-------------|
| Issuance Consent | موافقة الإصدار | Permission to issue credential |
| Presentation Consent | موافقة التقديم | Permission to share credential |
| Data Access Consent | موافقة الوصول | Permission to access health data |
| Emergency Override | تجاوز الطوارئ | Predefined emergency access rules |

### 12.4 Data Protection Compliance

The EHDI complies with Egypt's Personal Data Protection Law (No. 151/2020):

- Explicit consent required for health data processing
- Right to access, correct, and delete personal data
- Data breach notification within 72 hours
- Data localization within Egyptian jurisdiction
- Appointment of Data Protection Officer where required

---

## 13. Implementation Guidelines

### 13.1 Phased Rollout

| Phase | Timeline | Scope |
|-------|----------|-------|
| Phase 1 | Q1-Q2 2025 | Pilot in 3 governorates |
| Phase 2 | Q3-Q4 2025 | Expand to 10 governorates |
| Phase 3 | 2026 | Nationwide deployment |

### 13.2 Pilot Governorates

1. **Cairo** - الجملة: Largest healthcare market
2. **Alexandria** - الإسكندرية: Second largest city
3. **Port Said** - بورسعيد: Universal Health Insurance pilot

### 13.3 Integration Requirements

Healthcare facilities must implement:

1. **Wallet Verification**: Capability to verify EHDI credentials
2. **Prescription Issuance**: Digital prescription generation (physicians)
3. **Claims Submission**: HCX-compliant claims processing
4. **Audit Logging**: Record all credential interactions

---

## 14. Annexes Reference

| Annex | Title | Description |
|-------|-------|-------------|
| Annex 1 | High-Level Technical Requirements | Normative requirements |
| Annex 2 | Credential Schemas | JSON schemas for all credentials |
| Annex 3 | API Specifications | OpenAPI definitions |
| Annex 4 | Security Requirements | Detailed security specifications |
| Annex 5 | EDA Integration Guide | Medicine directory integration |
| Annex 6 | FRA Compliance Guide | Insurance claims compliance |
| Annex 7 | Testing Specifications | Conformance testing requirements |

---

## Document History

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 | December 2024 | Initial release |

---

**Egyptian Healthcare Digital Identity**  
**Ministry of Health and Population**  
**Arab Republic of Egypt**

---

*This document is adapted from the European Digital Identity Wallet Architecture and Reference Framework, © European Union, 2024, licensed under EUPL 1.2*
