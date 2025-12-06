# Egyptian Healthcare Digital Identity Wallet (EHDI)

[![License](https://img.shields.io/badge/License-EUPL%201.2-blue.svg)](LICENCE)
[![Version](https://img.shields.io/badge/Version-1.0.0-green.svg)](CHANGELOG.md)

> **محفظة الهوية الرقمية للرعاية الصحية المصرية**

The Egyptian Healthcare Digital Identity Wallet (EHDI) provides a comprehensive digital identity infrastructure for Egypt's healthcare ecosystem, serving 105+ million citizens. This framework is adapted from the European Digital Identity (EUDI) Architecture and Reference Framework, localized for Egypt's regulatory and operational requirements.

**[🇪🇬 اقرأ بالعربية](docs/ar/README.md)**

---

## Table of Contents

- [Overview](#overview)
- [Egyptian Healthcare Context](#egyptian-healthcare-context)
- [The EHDI Wallet](#the-ehdi-wallet)
- [Architecture and Reference Framework](#architecture-and-reference-framework)
- [Key Components](#key-components)
- [Use Cases](#use-cases)
- [Technical Specifications](#technical-specifications)
- [Regulatory Compliance](#regulatory-compliance)
- [Repository Contents](#repository-contents)
- [Contributing](#contributing)
- [License](#license)

---

## Overview

Under Egypt's healthcare digitization initiatives, the Ministry of Health and Population, Egyptian Drug Authority (EDA), and Financial Regulatory Authority (FRA) are working together to establish a unified digital identity framework for healthcare. The EHDI addresses the need for:

- **Secure patient identification** across healthcare facilities
- **Verified healthcare professional credentials** linked to syndicate registrations
- **Digital prescription authentication** integrated with the Egyptian Medicine Directory
- **Streamlined insurance claims processing** through the Healthcare Claims Exchange (HCX)
- **Privacy-preserving health data sharing** under patient control

The EHDI Wallet will be:

| Feature | Description |
|---------|-------------|
| **Universally Available** | Any Egyptian citizen, resident, or healthcare provider can obtain an EHDI Wallet |
| **Healthcare-Focused** | Primary identification method across Egypt's healthcare system |
| **User-Controlled** | Citizens choose what health information to share and with whom |
| **Regulatory Compliant** | Meets EDA, FRA, and Ministry of Health requirements |
| **Interoperable** | Works across public and private healthcare facilities nationwide |

---

## Egyptian Healthcare Context

### Regulatory Framework

The EHDI operates within Egypt's healthcare regulatory landscape:

| Regulatory Body | Arabic Name | Primary Role |
|-----------------|-------------|--------------|
| Egyptian Drug Authority (EDA) | هيئة الدواء المصرية | Pharmaceutical regulation, medicine directory |
| Financial Regulatory Authority (FRA) | الهيئة العامة للرقابة المالية | Health insurance oversight, claims standards |
| Ministry of Health & Population | وزارة الصحة والسكان | Healthcare policy, facility licensing |
| Universal Health Insurance Authority | الهيئة العامة للتأمين الصحي الشامل | Universal coverage implementation |
| Medical Syndicate | نقابة الأطباء | Physician registration and licensing |
| Pharmacists Syndicate | نقابة الصيادلة | Pharmacist registration and licensing |

### Key Statistics

| Metric | Value |
|--------|-------|
| Population Served | 105+ million |
| Daily Prescriptions Processed | 575,000+ |
| Registered Medicines (EDA) | 47,292 |
| Healthcare Facilities | 7,000+ |
| Licensed Pharmacies | 80,000+ |
| Registered Physicians | 250,000+ |
| Governorates | 27 |

### Applicable Regulations

- **Law No. 151/2019**: Universal Health Insurance Law
- **Law No. 2/2018**: Egyptian Drug Authority Establishment
- **Ministerial Decree 1985/2014**: Electronic Health Records Standards
- **FRA Circular 2023/47**: Digital Health Insurance Claims
- **EDA Guidelines 2024**: Digital Prescription Standards

---

## The EHDI Wallet

### Core Capabilities

The EHDI Wallet enables healthcare stakeholders to:

**For Patients (المرضى):**
- Store and present verified health identity credentials
- Control access to personal health information
- Receive and manage digital prescriptions
- Submit insurance claims digitally
- Access emergency medical information
- Maintain vaccination records

**For Healthcare Professionals (المهنيون الصحيون):**
- Present verified professional credentials
- Sign digital prescriptions with legal validity
- Access authorized patient health records
- Verify patient identity and insurance coverage

**For Healthcare Facilities (المنشآت الصحية):**
- Verify patient and professional identities
- Process digital prescriptions
- Submit insurance claims
- Access authorized health records

**For Pharmacies (الصيدليات):**
- Verify prescription authenticity
- Confirm prescriber credentials
- Dispense controlled substances with audit trail
- Process insurance reimbursements

### Identity Types

| Identity Type | Arabic | Issuer | Primary Use |
|---------------|--------|--------|-------------|
| Patient Health ID | الهوية الصحية للمريض | Ministry of Health | Patient identification |
| Professional License | رخصة مزاولة المهنة | Medical/Pharmacists Syndicate | Professional verification |
| Facility License | ترخيص المنشأة | Ministry of Health | Facility authentication |
| Insurance Card | بطاقة التأمين | Insurance Providers | Coverage verification |

---

## Architecture and Reference Framework

### Adaptation from EUDI

The EHDI Architecture and Reference Framework (ARF) adapts the European Digital Identity Framework for Egyptian requirements:

| EUDI Component | EHDI Equivalent | Egyptian Localization |
|----------------|-----------------|----------------------|
| Person Identification Data (PID) | Egyptian Health ID (EHI) | Integration with 14-digit National ID |
| Electronic Attestation of Attributes (EAA) | Healthcare Credential Attestation (HCA) | EDA/FRA verified credentials |
| Qualified Trust Service Provider (QTSP) | Egyptian Healthcare Trust Provider (EHTP) | Ministry-certified trust services |
| Wallet Provider | EHDI Wallet Provider | Licensed healthcare wallet operators |
| Relying Party | Healthcare Relying Party (HRP) | Hospitals, pharmacies, insurers |

### Egyptian National ID Integration

The EHDI binds healthcare credentials to the Egyptian National ID (الرقم القومي):

```
National ID Structure (14 digits):
┌─────────────────────────────────────────────────────────────┐
│ [C] [YY] [MM] [DD] [GG] [SSSS] [V]                          │
│  │   │    │    │    │     │     │                           │
│  │   │    │    │    │     │     └─ Check digit              │
│  │   │    │    │    │     └─ Unique sequence (0001-9999)    │
│  │   │    │    │    └─ Governorate code (01-27)             │
│  │   │    │    └─ Birth day (01-31)                         │
│  │   │    └─ Birth month (01-12)                            │
│  │   └─ Birth year (00-99)                                  │
│  └─ Century (2=1900s, 3=2000s)                              │
└─────────────────────────────────────────────────────────────┘
```

This enables:
- Identity verification against Civil Status Authority
- Governorate-based healthcare service routing
- Age verification for pharmaceutical restrictions
- Cross-reference with health insurance registries

### System Architecture

```
┌─────────────────────────────────────────────────────────────────────────┐
│                    EHDI ECOSYSTEM ARCHITECTURE                          │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  ┌─────────────┐    ┌─────────────┐    ┌─────────────┐                 │
│  │   Patient   │    │   Doctor    │    │  Pharmacist │                 │
│  │   Wallet    │    │   Wallet    │    │   Wallet    │                 │
│  └──────┬──────┘    └──────┬──────┘    └──────┬──────┘                 │
│         │                  │                  │                         │
│         └──────────────────┼──────────────────┘                         │
│                            │                                            │
│                   ┌────────▼────────┐                                   │
│                   │  EHDI Gateway   │                                   │
│                   │   (HCX Egypt)   │                                   │
│                   └────────┬────────┘                                   │
│                            │                                            │
│    ┌───────────┬───────────┼───────────┬───────────┐                   │
│    │           │           │           │           │                   │
│    ▼           ▼           ▼           ▼           ▼                   │
│ ┌──────┐  ┌──────┐   ┌──────┐   ┌──────┐   ┌──────────┐               │
│ │ EDA  │  │ FRA  │   │ MoH  │   │ UHIA │   │ Civil    │               │
│ │      │  │      │   │      │   │      │   │ Registry │               │
│ └──────┘  └──────┘   └──────┘   └──────┘   └──────────┘               │
│                                                                         │
│  Egyptian Drug  Financial   Ministry   Universal   National ID         │
│   Authority    Regulatory   of Health   Health    Authority            │
│                Authority               Insurance                        │
└─────────────────────────────────────────────────────────────────────────┘
```

---

## Key Components

### 1. Egyptian Health ID (EHI)

The foundational identity credential binding National ID to healthcare services:

| Attribute | Arabic | Source | Required |
|-----------|--------|--------|----------|
| National ID Number | الرقم القومي | Civil Registry | Yes |
| Full Name (Arabic) | الاسم الكامل | Civil Registry | Yes |
| Full Name (Latin) | الاسم باللاتينية | Civil Registry | Yes |
| Date of Birth | تاريخ الميلاد | Civil Registry | Yes |
| Gender | النوع | Civil Registry | Yes |
| Blood Type | فصيلة الدم | Health Registry | Optional |
| Emergency Contact | جهة الاتصال للطوارئ | User Provided | Optional |
| Chronic Conditions | الأمراض المزمنة | Health Registry | Optional |
| Allergies | الحساسية | Health Registry | Optional |

### 2. Healthcare Professional Credential (HPC)

Verified credentials for healthcare professionals:

| Attribute | Arabic | Source | Required |
|-----------|--------|--------|----------|
| National ID Number | الرقم القومي | Civil Registry | Yes |
| Syndicate Registration | رقم القيد النقابي | Medical Syndicate | Yes |
| License Number | رقم الترخيص | Ministry of Health | Yes |
| Specialty | التخصص | Syndicate | Yes |
| Practice Authorization | تصريح المزاولة | Ministry of Health | Yes |
| Facility Affiliation | المنشأة التابع لها | Facility Registry | Optional |
| Controlled Substance Auth | تصريح الأدوية المخدرة | EDA | Optional |

### 3. Digital Prescription Credential

Electronic prescription format integrated with EDA Medicine Directory:

| Attribute | Arabic | Description |
|-----------|--------|-------------|
| Prescription ID | رقم الوصفة | Unique identifier |
| Prescriber ID | معرف الطبيب | HPC reference |
| Patient ID | معرف المريض | EHI reference |
| Issue Date | تاريخ الإصدار | Timestamp |
| Medications | الأدوية | EDA medicine codes |
| Dosage Instructions | تعليمات الجرعة | Structured dosing |
| Validity Period | فترة الصلاحية | Expiration date |
| Refill Authorization | تصريح إعادة الصرف | Refill count |
| Digital Signature | التوقيع الرقمي | Prescriber signature |

### 4. Insurance Credential

Health insurance coverage verification:

| Attribute | Arabic | Source |
|-----------|--------|--------|
| Insurance ID | رقم التأمين | Insurance Provider |
| Coverage Type | نوع التغطية | Insurance Provider |
| Policy Number | رقم الوثيقة | Insurance Provider |
| Coverage Start | بداية التغطية | Insurance Provider |
| Coverage End | نهاية التغطية | Insurance Provider |
| Beneficiary Status | حالة المستفيد | UHIA |
| Co-payment Rate | نسبة المشاركة | Policy Terms |

---

## Use Cases

### Use Case 1: Digital Prescription Flow

```
┌─────────────────────────────────────────────────────────────────┐
│                  DIGITAL PRESCRIPTION FLOW                      │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌──────────┐         ┌──────────┐         ┌──────────┐        │
│  │ Patient  │────────▶│  Doctor  │────────▶│ Pharmacy │        │
│  └──────────┘ Visit   └──────────┘ Rx      └──────────┘        │
│       │                    │                    │               │
│       │ Present EHI        │ Sign Rx           │ Verify Rx     │
│       ▼                    ▼                    ▼               │
│  ┌──────────┐         ┌──────────┐         ┌──────────┐        │
│  │  Wallet  │         │  Wallet  │         │  Wallet  │        │
│  └──────────┘         └──────────┘         └──────────┘        │
│       │                    │                    │               │
│       └────────────────────┼────────────────────┘               │
│                            ▼                                    │
│                    ┌──────────────┐                             │
│                    │  HCX Egypt   │                             │
│                    │   Gateway    │                             │
│                    └──────────────┘                             │
│                            │                                    │
│              ┌─────────────┼─────────────┐                      │
│              ▼             ▼             ▼                      │
│         ┌────────┐   ┌────────┐   ┌────────┐                   │
│         │  EDA   │   │  FRA   │   │ Insurer│                   │
│         └────────┘   └────────┘   └────────┘                   │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

**Process Steps:**

1. Patient visits doctor and presents EHI from EHDI Wallet
2. Doctor verifies patient identity and insurance coverage
3. Doctor creates prescription selecting from EDA medicine directory
4. Doctor signs prescription with HPC credential
5. Prescription transmitted to patient's wallet via HCX
6. Patient presents prescription at pharmacy
7. Pharmacist verifies prescription authenticity and prescriber credentials
8. Pharmacist dispenses medication and records in system
9. Claim automatically submitted to insurance via HCX

### Use Case 2: Insurance Claim Processing

```
┌─────────────────────────────────────────────────────────────────┐
│                 INSURANCE CLAIM PROCESSING                      │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌──────────┐    ┌──────────┐    ┌──────────┐    ┌──────────┐  │
│  │ Patient  │───▶│ Provider │───▶│   HCX    │───▶│ Insurer  │  │
│  │          │    │          │    │  Egypt   │    │          │  │
│  └──────────┘    └──────────┘    └──────────┘    └──────────┘  │
│       │              │               │               │          │
│   1. Service     2. Submit      3. Validate     4. Process     │
│      Request        Claim          Claim          Claim        │
│                                                                 │
│  ┌─────────────────────────────────────────────────────────────┤
│  │ Claim Validation Checks:                                    │
│  │ ✓ Patient eligibility (EHI + Insurance Credential)          │
│  │ ✓ Provider authorization (HPC + Facility License)           │
│  │ ✓ Service coding (ICD-10, CPT mapped to Egyptian codes)     │
│  │ ✓ Medication verification (EDA Medicine Directory)          │
│  │ ✓ Prior authorization (if required)                         │
│  │ ✓ Duplicate claim detection                                 │
│  └─────────────────────────────────────────────────────────────┤
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### Use Case 3: Emergency Access

```
┌─────────────────────────────────────────────────────────────────┐
│                    EMERGENCY ACCESS FLOW                        │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │ Emergency Responder scans Patient's Emergency QR Code     │  │
│  └──────────────────────────────────────────────────────────┘  │
│                            │                                    │
│                            ▼                                    │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │ Immediately Accessible (No Authentication Required):      │  │
│  │ • Blood type                                              │  │
│  │ • Critical allergies                                      │  │
│  │ • Current medications                                     │  │
│  │ • Emergency contact                                       │  │
│  │ • Chronic conditions (diabetes, heart disease, etc.)      │  │
│  └──────────────────────────────────────────────────────────┘  │
│                            │                                    │
│                            ▼                                    │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │ Extended Access (Healthcare Facility Authentication):     │  │
│  │ • Complete medical history                                │  │
│  │ • Recent lab results                                      │  │
│  │ • Imaging records                                         │  │
│  │ • Prescription history                                    │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

## Technical Specifications

### Data Formats

| Standard | Application |
|----------|-------------|
| FHIR R4 | Health data exchange |
| HL7 v2.x | Legacy system integration |
| ICD-10-AM | Diagnosis coding |
| SNOMED CT | Clinical terminology |
| ISO/IEC 18013-5 | Mobile document (mDoc) |
| SD-JWT | Selective disclosure credentials |
| OpenID4VCI | Credential issuance |
| OpenID4VP | Credential presentation |

### Security Requirements

| Requirement | Specification |
|-------------|---------------|
| Encryption at Rest | AES-256 |
| Encryption in Transit | TLS 1.3 |
| Digital Signatures | ECDSA P-256 |
| Key Storage | Hardware Security Module (HSM) |
| Authentication | Multi-factor required |
| Session Management | 15-minute timeout |
| Audit Logging | Immutable, 7-year retention |

### Interoperability

| Protocol | Purpose |
|----------|---------|
| OAuth 2.0 | Authorization |
| SAML 2.0 | Legacy federation |
| SCIM 2.0 | Identity provisioning |
| REST/JSON | API communication |
| mTLS | Service authentication |

---

## Regulatory Compliance

### Data Protection

The EHDI complies with Egyptian data protection requirements:

- **Law No. 151/2020**: Personal Data Protection Law
- Patient consent required for data sharing
- Right to access, correct, and delete personal data
- Data localization within Egyptian jurisdiction
- 72-hour breach notification requirement

### Healthcare-Specific Requirements

- **EDA Compliance**: Medicine directory integration, controlled substance tracking
- **FRA Compliance**: Claims processing standards, anti-fraud measures
- **UHIA Integration**: Universal health insurance eligibility verification
- **Syndicate Verification**: Professional credential authentication

### Certification Requirements

EHDI Wallet Providers must obtain:

1. Ministry of Health Digital Healthcare License
2. FRA Financial Services Authorization
3. National Information Technology Industry Development Agency (ITIDA) Security Certification
4. EDA Integration Certification

---

## Repository Contents

This repository contains:

| Directory/File | Description |
|----------------|-------------|
| [`docs/architecture-and-reference-framework-main.md`](docs/architecture-and-reference-framework-main.md) | Main ARF document |
| [`docs/annexes/`](docs/annexes/) | Normative requirements and specifications |
| [`docs/ar/`](docs/ar/) | Arabic language documentation |
| [`hltr/`](hltr/) | High-Level Technical Requirements |
| [`security/`](security/) | Security specifications and guidelines |
| [`CHANGELOG.md`](CHANGELOG.md) | Version history |
| [`CONTRIBUTING.md`](CONTRIBUTING.md) | Contribution guidelines |
| [`LICENCE`](LICENCE) | EUPL 1.2 License |

---

## Contributing

We welcome contributions from healthcare technology stakeholders, government agencies, and the developer community. Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct and the process for submitting pull requests.

### Feedback Channels

- **GitHub Issues**: Technical specifications and documentation
- **Email**: ehdi-feedback@healthflow.eg (placeholder)
- **Working Groups**: Contact Ministry of Health for participation

---

## License

This project is licensed under the European Union Public License 1.2 - see the [LICENCE](LICENCE) file for details.

---

## Acknowledgments

- European Commission Digital Identity Framework
- EU Digital Identity Wallet Architecture and Reference Framework
- Egyptian Ministry of Health and Population
- Egyptian Drug Authority
- Financial Regulatory Authority
- HealthFlow Group Technical Team

---

**Version**: 1.0.0  
**Last Updated**: December 2024  
**Status**: Draft for Public Consultation
