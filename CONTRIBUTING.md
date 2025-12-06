# Contributing to EHDI

# المساهمة في EHDI

Thank you for your interest in contributing to the Egyptian Healthcare Digital Identity (EHDI) Architecture and Reference Framework.

شكراً لاهتمامك بالمساهمة في إطار العمل المرجعي والمعماري للهوية الرقمية للرعاية الصحية المصرية (EHDI).

---

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How to Contribute](#how-to-contribute)
- [Contribution Types](#contribution-types)
- [Review Process](#review-process)
- [Style Guidelines](#style-guidelines)
- [Contact](#contact)

---

## Code of Conduct

### Our Pledge

We are committed to providing a welcoming and inclusive environment for all contributors, regardless of background, identity, or experience level.

### Expected Behavior

- Be respectful and considerate in all communications
- Welcome diverse perspectives and experiences
- Accept constructive criticism gracefully
- Focus on what is best for the Egyptian healthcare community
- Use professional language appropriate for government documentation

### Unacceptable Behavior

- Harassment, discrimination, or offensive comments
- Personal or political attacks
- Publishing others' private information
- Conduct that could be considered inappropriate in a professional setting

---

## How to Contribute

### GitHub Issues

Use GitHub Issues to:
- Report errors or inconsistencies in documentation
- Suggest improvements to specifications
- Ask questions about requirements
- Propose new features or use cases

### Pull Requests

1. **Fork** the repository
2. **Create** a feature branch (`git checkout -b feature/your-feature`)
3. **Make** your changes following our style guidelines
4. **Commit** with clear, descriptive messages
5. **Push** to your fork
6. **Submit** a pull request

### Working Groups

For substantial contributions, consider participating in official working groups:

| Working Group | Focus Area | Contact |
|---------------|------------|---------|
| Architecture | Core framework design | arch-wg@ehdi.gov.eg |
| Security | Security requirements | security-wg@ehdi.gov.eg |
| Interoperability | Standards & protocols | interop-wg@ehdi.gov.eg |
| Implementation | Deployment guidance | impl-wg@ehdi.gov.eg |

*(Email addresses are placeholders)*

---

## Contribution Types

### Documentation Improvements

- Fix typos, grammatical errors
- Improve clarity of explanations
- Add examples and diagrams
- Translate content to Arabic

### Technical Specifications

- Propose requirement changes
- Suggest protocol improvements
- Identify security considerations
- Recommend interoperability standards

### Use Case Proposals

- Describe new healthcare use cases
- Document user journeys
- Identify integration requirements
- Propose credential types

### Implementation Feedback

- Report implementation challenges
- Share lessons learned
- Suggest practical improvements
- Provide conformance test results

---

## Review Process

### For Documentation

1. Submitted PR reviewed within 5 business days
2. Technical accuracy verified
3. Editorial review for clarity
4. Arabic translation verified (if applicable)
5. Merge upon approval

### For Specifications

1. Initial review by maintainers
2. Technical working group review
3. Public comment period (for significant changes)
4. Regulatory review (if compliance-related)
5. Final approval and merge

### Review Criteria

| Criteria | Description |
|----------|-------------|
| Accuracy | Technically correct and complete |
| Clarity | Easy to understand for target audience |
| Consistency | Aligns with existing documentation |
| Compliance | Meets regulatory requirements |
| Localization | Appropriate for Egyptian context |

---

## Style Guidelines

### Language

- Primary language: English
- Arabic versions provided for user-facing content
- Use clear, professional language
- Avoid jargon unless necessary (define when used)

### Document Structure

- Use descriptive headings
- Include table of contents for long documents
- Use tables for structured information
- Include diagrams where helpful

### Markdown Conventions

```markdown
# Main Title
## Section
### Subsection

**Bold** for emphasis
`code` for technical terms
[Link text](url)

| Header 1 | Header 2 |
|----------|----------|
| Cell 1   | Cell 2   |
```

### Arabic Content

For Arabic content, use RTL wrapper:

```html
<div dir="rtl" align="right">

المحتوى العربي هنا

</div>
```

### Diagrams

- Use ASCII art for simple diagrams (compatible with all viewers)
- Use Mermaid for complex diagrams
- Include alt text descriptions

### Requirement Format

```
**[REQ-ID]** Requirement Title

The [ACTOR] [MUST/SHOULD/MAY] [ACTION] [CONDITION].

| Attribute | Value |
|-----------|-------|
| Category | [Category] |
| Priority | [High/Medium/Low] |
| Status | [Draft/Review/Approved] |
```

---

## Versioning

We use [Semantic Versioning](https://semver.org/):

- **MAJOR**: Incompatible specification changes
- **MINOR**: Backward-compatible additions
- **PATCH**: Backward-compatible fixes

---

## License

By contributing, you agree that your contributions will be licensed under the [EUPL 1.2](LICENCE).

---

## Contact

### General Inquiries

- **Email**: ehdi-contrib@healthflow.eg *(placeholder)*
- **GitHub**: [Issues](https://github.com/HealthFlow-Medical-HCX/Healthflow-DD/issues)

### Security Issues

For security vulnerabilities, please email: security@ehdi.gov.eg *(placeholder)*

Do not report security issues through public GitHub issues.

---

## Acknowledgments

We appreciate all contributions to the EHDI framework. Contributors will be acknowledged in:
- CHANGELOG for specific contributions
- Annual contributor recognition
- Working group acknowledgments

---

**Thank you for helping build Egypt's healthcare digital identity infrastructure!**

**!شكراً لمساعدتكم في بناء البنية التحتية للهوية الرقمية للرعاية الصحية في مصر**
