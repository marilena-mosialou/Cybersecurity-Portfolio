# 🧪 Fountain / Vercel Recruitment Phishing Investigation

## 📌 Case Overview

This investigation documents the analysis of a phishing campaign leveraging trusted SaaS recruitment infrastructure and free cloud hosting services to deliver attacker-controlled phishing content.

The campaign abused legitimate recruitment platform infrastructure through an open redirect mechanism and redirected victims toward phishing pages hosted on Vercel cloud infrastructure.

Unlike traditional phishing campaigns relying on obviously malicious infrastructure, the operation blended into trusted traffic patterns using:

- valid email authentication,
- legitimate SaaS delivery systems,
- trusted cloud providers,
- and HTTPS-enabled phishing hosting.

The investigation followed the structured SOC Email Investigation Workflow documented in this repository.

---

# 📋 Executive Summary

| Category | Value |
|---|---|
| Incident Type | Phishing |
| Threat Theme | Recruitment / Career Opportunity Scam |
| Delivery Platform | Fountain Recruitment Infrastructure |
| Cloud Hosting Abuse | Vercel |
| Primary Objective | User interaction and phishing redirection |
| Delivery Method | Email |
| Redirect Mechanism | Open Redirect Abuse |
| Authentication Findings | SPF/DKIM/DMARC pass |
| Infrastructure Reputation | Mostly trusted / low detection |
| Risk Level | High |
| Final Verdict | Confirmed Phishing Campaign |

---

# 🎯 Investigation Scope

The investigation focused on:

- Email authentication validation
- Recruitment-themed social engineering
- SaaS infrastructure abuse
- Open redirect analysis
- Cloud-hosted phishing infrastructure
- Threat intelligence validation
- Domain and infrastructure reputation analysis
- Detection evasion characteristics

---

# 🔎 1. Initial Triage

## Email Characteristics

| Field | Value |
|---|---|
| Display Name | Selena \| HR Recruitment |
| Sender Domain | fountain[.]com |
| Theme | Recruitment / career opportunity |
| Subject | Your Background in Paid Media & Performance Marketing |
| CTA | “Schedule a Conversation” |
| Target Profile | Marketing professionals |

---

## Initial Observations

Several indicators suggested phishing-related social engineering activity:

- Trusted recruitment branding
- Personalized professional targeting
- Social engineering recruitment lure
- Embedded interaction CTA
- Trusted SaaS delivery infrastructure
- External redirect behavior
- Legitimate-looking formatting

The campaign attempted to reduce recipient suspicion by leveraging professional recruitment themes and legitimate cloud-based infrastructure.

---

# 🛡️ 2. Authentication Analysis

Authentication analysis was performed using Google Admin Toolbox – Messageheader.

## Authentication Results

| Control | Result |
|---|---|
| SPF | PASS |
| DKIM | PASS |
| DMARC | PASS |

---

## Analysis

The email successfully passed all major authentication checks.

The message originated from infrastructure aligned with:

```text
fountain[.]com
```

This demonstrates a common modern phishing characteristic:

> Successful authentication does not guarantee legitimacy.

The campaign leveraged legitimate SaaS recruitment infrastructure to reduce detection likelihood and increase recipient trust.

Analysis of the headers identified:

- trusted SendGrid delivery infrastructure,
- valid SPF alignment,
- valid DKIM signing,
- successful DMARC validation,
- and standard enterprise email delivery patterns.

---

## Reply-To Manipulation

Further header analysis identified reply-to manipulation behavior.

The email redirected recipient responses toward infrastructure unrelated to official Google recruitment operations:

```text
selena.kloe@google-team.awsapps[.]com
```

This technique is commonly observed in phishing campaigns attempting to separate visible sender identity from attacker-controlled response channels.

---

# 🖥️ 3. Header & Infrastructure Analysis

## Sending Infrastructure

| Attribute | Value |
|---|---|
| Sending Platform | SendGrid |
| SaaS Provider | Fountain |
| Delivery Reputation | Trusted |
| Infrastructure Type | Commercial SaaS Email Delivery |
| Cloud Provider | Twilio / SendGrid |

---

## Header Analysis Findings

Analysis of the raw headers identified:

- legitimate SaaS email delivery patterns,
- cloud-based transactional infrastructure,
- successful authentication alignment,
- and trusted enterprise mail routing behavior.

This infrastructure significantly reduced the likelihood of automated blocking because the delivery path matched normal enterprise communication patterns.

The campaign demonstrates how attackers increasingly abuse:

- trusted SaaS ecosystems,
- commercial email delivery providers,
- and enterprise cloud infrastructure

to bypass reputation-based security controls.

---

# 🌐 4. Domain & Reputation Validation

## Domain Information

| Attribute | Value |
|---|---|
| Domain | fountain[.]com |
| Registration Date | 1997-05-20 |
| Registrar | GoDaddy |
| Infrastructure Protection | Cloudflare |
| Domain Reputation | Established / legitimate |

---

## Domain Analysis

Unlike disposable phishing domains, the infrastructure leveraged a long-standing legitimate SaaS platform.

Key observations included:

- legitimate domain ownership,
- enterprise-grade infrastructure,
- trusted DNS providers,
- and established operational history.

No evidence of:

- typosquatting,
- newly registered domains,
- or disposable phishing infrastructure

was identified.

Instead, the campaign relied on legitimate platform abuse.

---

# 🔗 5. URL & Redirect Analysis

URL analysis was performed using URLScan.io and VirusTotal.

---

## Redirect Behavior

The phishing workflow leveraged a multi-stage redirect chain:

```text
Fountain Recruitment Infrastructure
        ↓
Open Redirect Endpoint
        ↓
challenge-captcha-job-applications[.]vercel[.]app
        ↓
Cloud-hosted phishing content
```

---

## Key Findings

### Open Redirect Abuse

The campaign abused a trusted Fountain redirect mechanism:

```text
link[.]fountain[.]com
```

to redirect users toward attacker-controlled phishing infrastructure hosted on Vercel.

This technique increases trust perception and reduces gateway filtering effectiveness.

---

### Free Cloud Hosting Abuse

The phishing content was hosted on:

```text
challenge-captcha-job-applications[.]vercel[.]app
```

leveraging trusted Vercel infrastructure and HTTPS-enabled cloud hosting.

This enabled rapid deployment of phishing content while blending into legitimate traffic patterns.

---

### Deceptive Infrastructure Naming

The phishing infrastructure used verification-themed naming conventions:

```text
challenge-captcha-job-applications
```

to simulate legitimate security verification workflows and reduce recipient suspicion.

---

### Multi-Stage Delivery Chain

The investigation confirmed a chained delivery workflow combining:

- trusted SaaS infrastructure,
- redirect abuse,
- and cloud-hosted phishing content.

This significantly complicates automated reputation-based detection.

---

# 🧠 6. Content & Social Engineering Analysis

## Social Engineering Techniques Identified

| Technique | Observed |
|---|---|
| Recruitment Impersonation | Yes |
| Trusted Branding Abuse | Yes |
| Personalized Targeting | Yes |
| Professional Context Targeting | Yes |
| Embedded CTA | Yes |
| Redirect Obfuscation | Yes |

---

## Behavioral Assessment

The phishing email relied heavily on professional recruitment-themed social engineering.

Key manipulation techniques included:

### Trusted Brand Association

The campaign leveraged Google-related branding and recruitment terminology to increase recipient trust.

---

### Personalized Professional Targeting

The email referenced professional marketing experience to simulate legitimate recruiter outreach behavior.

---

### CTA-Based Interaction Lure

The “Schedule a Conversation” button served as the primary interaction lure directing victims into the phishing workflow.

---

### Trust Perception Manipulation

Use of:

- legitimate SaaS platforms,
- valid unsubscribe functionality,
- professional formatting,
- and enterprise cloud infrastructure

significantly reduced suspicion indicators typically associated with phishing campaigns.

---

# ⚠️ 7. Incident Classification & Risk Assessment

## Classification

| Category | Verdict |
|---|---|
| Spam | No |
| Phishing | Confirmed |
| BEC | No |
| Legitimate | No |

---

## Risk Assessment

| Risk Factor | Assessment |
|---|---|
| User Interaction Likelihood | High |
| Infrastructure Sophistication | Moderate–High |
| Detection Evasion | Present |
| Trusted Infrastructure Abuse | Confirmed |
| Cloud Hosting Abuse | Confirmed |

---

## Final Assessment

This campaign represents a confirmed phishing operation leveraging:

- trusted SaaS recruitment infrastructure,
- valid authentication alignment,
- open redirect abuse,
- free cloud hosting,
- recruitment-themed social engineering,
- and low-visibility phishing infrastructure.

The operation demonstrates how modern phishing campaigns increasingly rely on legitimate infrastructure abuse rather than overtly malicious domains or payload delivery.

---

# 🚨 8. Indicators of Compromise (IOCs)

## Domains

```text
fountain[.]com
link[.]fountain[.]com
challenge-captcha-job-applications[.]vercel[.]app
awsapps[.]com
```

---

## Email Indicators

```text
notifications@fountain[.]com
selena.kloe@google-team.awsapps[.]com
```

---

## IP Addresses

```text
192[.]254[.]121[.]177
64[.]29[.]17[.]131
104[.]18[.]18[.]164
```

---

## URLs

```text
https://link[.]fountain[.]com/ls/click
https://challenge-captcha-job-applications[.]vercel[.]app
```

> All indicators have been defanged for safe handling and documentation purposes.

---

# 🛠️ 9. Containment & Remediation Recommendations

Recommended response actions:

- Block identified phishing URLs and redirect paths
- Monitor for abuse of trusted SaaS redirect mechanisms
- Implement URL rewriting and redirect inspection policies
- Conduct user awareness training regarding recruitment-themed phishing
- Review cloud-hosted phishing detection capabilities
- Monitor for suspicious Vercel-hosted phishing infrastructure
- Validate recruiter communications through independent channels

---

# 🔑 10. Key Investigation Takeaways

This investigation demonstrates several important modern phishing characteristics:

- Successful SPF/DKIM/DMARC validation does not guarantee legitimacy
- Threat actors increasingly abuse trusted SaaS infrastructure
- Open redirects remain highly effective phishing delivery mechanisms
- Free cloud hosting platforms are frequently abused for phishing
- Recruitment-themed phishing significantly increases interaction likelihood
- Trusted infrastructure abuse reduces automated detection visibility
- Contextual analysis is essential alongside technical reputation analysis

---

# 📝 Analyst Notes

This investigation demonstrates how modern phishing campaigns increasingly prioritize infrastructure legitimacy over overtly malicious delivery techniques.

Rather than relying on:

- disposable phishing domains,
- obvious spoofing,
- or malware payloads,

the campaign leveraged:

- trusted SaaS platforms,
- enterprise cloud hosting,
- valid authentication,
- redirect abuse,
- and professional social engineering.

The investigation required correlating:

- authentication results,
- redirect behavior,
- cloud infrastructure analysis,
- threat intelligence,
- and behavioral assessment

to accurately classify the activity as phishing despite largely trusted infrastructure indicators.

---

# 📎 Related Evidence

| Evidence | Description |
|---|---|
| 01-recruitment-phishing-lure-analysis.png | Recruitment-themed social engineering indicators |
| 02-authentication-and-infrastructure-analysis.png | SPF/DKIM/DMARC validation and SaaS infrastructure abuse |
| 03-open-redirect-http-analysis.png | Open redirect workflow and phishing delivery chain |
| 04-cloud-phishing-infrastructure-analysis.png | Vercel phishing hosting and multi-stage redirect analysis |
| 05-threat-intelligence-detection-analysis.png | VirusTotal detection visibility assessment |
| 06-domain-reputation-analysis.png | Fountain domain legitimacy and infrastructure analysis |
| 07-sending-infrastructure-reputation.png | SendGrid and infrastructure reputation assessment |

---
