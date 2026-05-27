# 🛡️ SOC Email Threat Analysis

A hands-on SOC-focused email security investigation repository documenting the analysis of legitimate emails, phishing campaigns, trusted infrastructure abuse, and Business Email Compromise (BEC) scenarios.

This project demonstrates practical email threat analysis workflows used in modern Security Operations Center (SOC) environments, combining:

- authentication analysis,
- header and infrastructure investigation,
- redirect-chain analysis,
- threat intelligence correlation,
- social engineering assessment,
- and contextual risk evaluation.

The investigations emphasize real-world phishing tradecraft, including:

- trusted SaaS abuse,
- cloud-hosted phishing infrastructure,
- open redirect delivery chains,
- lookalike domain impersonation,
- and authentication bypass techniques.

---

# 🎯 Project Objectives

This repository was created to demonstrate practical SOC analyst capabilities including:

- Email threat investigation
- SPF/DKIM/DMARC analysis
- Header and infrastructure analysis
- IOC extraction and documentation
- URL and redirect-chain investigation
- Cloud infrastructure abuse detection
- Social engineering analysis
- Threat classification and risk assessment
- Security reporting and documentation

The investigations follow a structured SOC investigation methodology designed to mirror real-world analyst workflows.

---

# 📂 Repository Structure

```text
SOC-Email-Threat-Analysis/
│
├── README.md
├── methodology.md
├── extracted-iocs.md
│
├── cases/
│   │
│   ├── 01-meta-legitimate-email-investigation/
│   │   ├── report.md
│   │   └── artifacts/
│   │
│   ├── 02-lidl-phishing-investigation/
│   │   ├── report.md
│   │   └── artifacts/
│   │
│   ├── 03-fountain-vercel-phishing-investigation/
│   │   ├── report.md
│   │   └── artifacts/
│   │
│   └── 04-bec-urgent-payment-simulation/
│       ├── report.md
│       └── artifacts/
```

---

# 🧪 Investigations Included

| Case | Investigation Type | Focus Area |
|---|---|---|
| 01 | Legitimate Email Validation | Authentication & infrastructure verification |
| 02 | Lidl Phishing Campaign | Cloud redirect abuse & phishing infrastructure |
| 03 | Fountain/Vercel Phishing Campaign | Open redirects & trusted SaaS abuse |
| 04 | Business Email Compromise Simulation | Executive impersonation & financial fraud |

---

# 🔍 Investigation Workflow

All investigations follow the standardized workflow documented in:

```text
methodology.md
```

Core investigation phases include:

1. Initial Triage  
2. Authentication Analysis  
3. Header & Infrastructure Analysis  
4. Domain & Reputation Validation  
5. URL & Redirect Analysis  
6. Content & Social Engineering Analysis  
7. Incident Classification & Risk Assessment  
8. Containment & Remediation Recommendations  

---

# 🛠️ Tools & Platforms Used

| Category | Tools |
|---|---|
| Header Analysis | Google Admin Toolbox |
| Domain Analysis | WHOIS |
| Reputation Analysis | AbuseIPDB |
| URL Analysis | URLScan.io |
| Threat Intelligence | VirusTotal |
| OSINT | Google Search |

---

# 🚨 Threat Techniques Demonstrated

This repository demonstrates several modern phishing and BEC techniques including:

- Trusted SaaS infrastructure abuse
- Open redirect phishing delivery
- Cloud-hosted phishing infrastructure
- Springboard redirect chains
- Reply-To manipulation
- Lookalike domain impersonation
- Executive impersonation
- Recruitment-themed phishing
- Reward-based phishing lures
- Behavioral/social engineering attacks
- Low-detection phishing infrastructure

---

# ⚠️ MITRE ATT&CK Techniques

| Technique | ID |
|---|---|
| Phishing | T1566 |
| Spearphishing Link | T1566.002 |
| Impersonation | T1656 |
| User Execution | T1204 |
| Trusted Relationship Abuse | T1199 |
| Web Service Abuse | T1583.006 |
| Financial Theft | T1657 |

---

# 📎 Investigation Evidence

Each investigation contains:

- detailed SOC-style investigation reports,
- annotated screenshots,
- infrastructure analysis,
- IOC extraction,
- authentication findings,
- and behavioral assessments.

Artifacts are stored within each case directory:

```text
cases/<case-name>/artifacts/
```

---

# 🧠 Key Investigation Principles

This repository emphasizes several important SOC investigation concepts:

- SPF/DKIM/DMARC passing does not guarantee legitimacy
- Low public detections do not imply benign infrastructure
- Trusted infrastructure is frequently abused by attackers
- Behavioral analysis is critical alongside technical validation
- Contextual reasoning is essential during phishing investigations
- Modern phishing increasingly relies on infrastructure legitimacy rather than malware delivery

---

# 📌 Analyst Notes

The investigations within this repository were designed to reflect realistic SOC analyst workflows and threat analysis methodologies.

The project focuses heavily on:

- investigation methodology,
- analyst reasoning,
- behavioral assessment,
- infrastructure validation,
- and contextual threat analysis

rather than simple IOC collection alone.

Several cases demonstrate how attackers abuse legitimate infrastructure such as:

- Google Cloud Storage,
- Fountain,
- SendGrid,
- Vercel,
- Cloudflare,
- and AWS

to reduce detection visibility and increase user trust.

---

# 🔐 Disclaimer

This repository is intended strictly for:

- educational purposes,
- defensive security research,
- SOC workflow demonstration,
- and cybersecurity portfolio development.

All malicious indicators have been defanged for safe documentation and handling.

No phishing infrastructure or malicious payloads are hosted or redistributed by this repository.
