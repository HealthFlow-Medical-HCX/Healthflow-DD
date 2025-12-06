# Changelog

# سجل التغييرات

All notable changes to the Egyptian Healthcare Digital Identity (EHDI) Architecture and Reference Framework will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [Unreleased]

### Planned
- Annex completion (Annexes 1-8)
- Arabic translation of all annexes
- Implementation reference code
- Conformance test suite

---

## [1.0.0] - 2024-12-06

### Added

#### Core Documentation
- Main README with English and Arabic versions
- Architecture and Reference Framework main document
- Contributing guidelines
- Security policy

#### Egyptian Localization
- Egyptian National ID (الرقم القومي) integration specifications
- 14-digit National ID validation rules
- Governorate code mappings (27 governorates)
- Arabic language support throughout

#### Healthcare-Specific Components
- Egyptian Health ID (EHI) credential specification
- Healthcare Professional Credential (HPC) specification
- Digital Prescription credential integrated with EDA Medicine Directory
- Insurance Credential specification aligned with FRA requirements

#### Regulatory Framework
- Egyptian Drug Authority (EDA) integration guidelines
- Financial Regulatory Authority (FRA) compliance requirements
- Ministry of Health credential standards
- Universal Health Insurance Authority (UHIA) integration
- Medical and Pharmacists Syndicate verification

#### Architecture
- EHDI Wallet architecture specification
- Trust framework adapted for Egyptian healthcare
- Security architecture based on EUDI standards
- Interoperability specifications (FHIR R4, OpenID4VCI/VP)

#### Use Cases
- Digital prescription flow
- Insurance claim processing
- Emergency health information access
- Cross-governorate health data portability

### Adapted from EUDI

This release is based on the European Digital Identity (EUDI) Architecture and Reference Framework with the following Egyptian adaptations:

| EUDI Component | EHDI Adaptation |
|----------------|-----------------|
| Person Identification Data (PID) | Egyptian Health ID (EHI) with National ID integration |
| Electronic Attestation of Attributes (EAA) | Healthcare Credential Attestation (HCA) |
| Qualified Trust Service Provider (QTSP) | Egyptian Healthcare Trust Provider (EHTP) |
| Member State interoperability | Cross-governorate interoperability |
| eIDAS Regulation compliance | Egyptian healthcare law compliance |

### Known Limitations
- Annexes are in draft status
- Implementation reference not yet available
- Conformance tests pending development

---

## Version History Summary

| Version | Date | Description |
|---------|------|-------------|
| 1.0.0 | 2024-12-06 | Initial release - Egyptian localization of EUDI ARF |

---

## Upcoming Releases

### Version 1.1.0 (Planned Q1 2025)
- Complete Annex specifications
- EDA Medicine Directory API integration details
- FRA claims processing specifications
- Pilot implementation guidelines

### Version 1.2.0 (Planned Q2 2025)
- Conformance test specifications
- Reference implementation documentation
- Security audit results
- Pilot feedback incorporation

---

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for information on how to contribute to this project.

---

## License

This project is licensed under the EUPL 1.2 - see [LICENCE](LICENCE) for details.

---

**Egyptian Healthcare Digital Identity**  
**HealthFlow Group**  
**Arab Republic of Egypt**
