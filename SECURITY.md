# Security Policy

# سياسة الأمان

## Reporting Security Vulnerabilities

## الإبلاغ عن الثغرات الأمنية

The Egyptian Healthcare Digital Identity (EHDI) team takes security seriously. We appreciate your efforts to responsibly disclose any security vulnerabilities you find.

يأخذ فريق الهوية الرقمية للرعاية الصحية المصرية (EHDI) الأمان على محمل الجد. نقدر جهودكم في الإفصاح المسؤول عن أي ثغرات أمنية تجدونها.

---

## Reporting Process

### DO Report

- Security vulnerabilities in EHDI specifications
- Privacy concerns in credential handling
- Cryptographic weaknesses
- Authentication or authorization issues
- Data exposure risks

### DO NOT

- Report vulnerabilities through public GitHub issues
- Disclose vulnerabilities publicly before resolution
- Access or modify data belonging to others
- Perform testing that could disrupt services

---

## How to Report

### Email (Preferred)

Send security reports to: **security@ehdi.gov.eg** *(placeholder)*

### Report Contents

Please include:

1. **Description**: Clear description of the vulnerability
2. **Location**: Specific document, section, or specification affected
3. **Impact**: Potential impact if exploited
4. **Reproduction**: Steps to reproduce (if applicable)
5. **Suggestion**: Recommended fix (if any)

### PGP Encryption

For sensitive reports, use our PGP key:

```
Key ID: [To be published]
Fingerprint: [To be published]
```

---

## Response Timeline

| Phase | Timeline |
|-------|----------|
| Acknowledgment | Within 48 hours |
| Initial Assessment | Within 5 business days |
| Status Update | Every 7 days until resolution |
| Resolution Target | 90 days for critical issues |

---

## Severity Classification

### Critical (الحرجة)

- Credential forgery vulnerabilities
- Authentication bypass
- Private key exposure
- Mass data breach potential

**Response**: Immediate action, emergency update if needed

### High (العالية)

- Unauthorized data access
- Session hijacking
- Privilege escalation
- Cryptographic weaknesses

**Response**: Priority fix within 30 days

### Medium (المتوسطة)

- Information disclosure
- Denial of service potential
- Insufficient logging
- Configuration weaknesses

**Response**: Fix within 60 days

### Low (المنخفضة)

- Minor information leakage
- Best practice deviations
- Documentation inconsistencies

**Response**: Fix within 90 days

---

## Scope

### In Scope

- EHDI Architecture and Reference Framework specifications
- Credential format definitions
- Protocol specifications (OpenID4VCI, OpenID4VP adaptations)
- Security requirement specifications
- Trust framework definitions

### Out of Scope

- Third-party implementations (unless EHDI reference implementation)
- Infrastructure not managed by EHDI team
- Social engineering attacks
- Physical security

---

## Safe Harbor

We support safe harbor for security researchers who:

- Act in good faith
- Avoid privacy violations
- Avoid disruption of services
- Do not access or modify data beyond necessity
- Report findings responsibly

We will not pursue legal action against researchers who follow these guidelines.

---

## Security Standards

The EHDI follows these security standards:

| Standard | Application |
|----------|-------------|
| ISO 27001 | Information security management |
| ISO 27701 | Privacy information management |
| NIST Cybersecurity Framework | Security controls |
| OWASP Guidelines | Application security |
| Egyptian Data Protection Law | Personal data handling |

---

## Security Requirements Summary

### Cryptographic Requirements

| Function | Requirement |
|----------|-------------|
| Credential Signing | ECDSA P-256 or stronger |
| Key Exchange | ECDH P-256 or stronger |
| Symmetric Encryption | AES-256-GCM |
| Transport Security | TLS 1.3 |
| Hashing | SHA-256 minimum |

### Authentication Requirements

| Level | Requirements |
|-------|--------------|
| Low | Password/PIN |
| Substantial | Multi-factor (password + device) |
| High | Biometric + hardware-backed key |

### Data Protection Requirements

| Requirement | Implementation |
|-------------|----------------|
| At Rest | AES-256 encryption |
| In Transit | TLS 1.3 |
| Key Storage | Hardware Security Module (HSM) |
| Access Control | Role-based, least privilege |
| Audit Logging | Immutable, 7-year retention |

---

## Security Contacts

### Primary Contact

**Email**: security@ehdi.gov.eg *(placeholder)*

### Backup Contact

**Email**: ehdi-security@healthflow.eg *(placeholder)*

### Emergency Contact

For critical vulnerabilities requiring immediate attention:
**Phone**: +20-XX-XXXX-XXXX *(placeholder)*

---

## Acknowledgments

We acknowledge security researchers who help improve EHDI security. With your permission, we will credit you in our security acknowledgments.

### Hall of Fame

*No entries yet - be the first!*

---

## Updates

This security policy is reviewed quarterly and updated as needed.

**Last Updated**: December 2024  
**Next Review**: March 2025

---

**Egyptian Healthcare Digital Identity**  
**Security Team**  
**Arab Republic of Egypt**
