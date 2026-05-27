# 🧪 Meta User Experience Research Email Investigation

## 📌 Case Overview

This investigation documents the analysis of an email originating from Meta User Experience Research inviting recipients to participate in a Facebook research study.

The email initially raised suspicion due to:
- reward-based participation language
- unfamiliar subdomains
- external redirect links
- third-party mail delivery infrastructure

The investigation validated the legitimacy of the email through authentication analysis, infrastructure attribution, reputation validation, and behavioral assessment.

The investigation followed the structured SOC Email Investigation Workflow documented in this repository.

---

# 📋 Executive Summary

| Category | Value |
|---|---|
| Incident Type | Legitimate Marketing / Research Email |
| Threat Theme | User Research Invitation |
| Organization | Meta Platforms |
| Primary Objective | Research participation recruitment |
| Delivery Method | Email |
| Infrastructure Providers | Meta Platforms / Salesforce |
| Authentication Findings | SPF/DKIM/DMARC pass |
| Domain Characteristics | Long-established legitimate infrastructure |
| Risk Level | Low |
| Final Verdict | Legitimate Email Communication |

---

# 🎯 Investigation Scope

The investigation focused on:

- Email authentication validation
- Sender infrastructure analysis
- Redirect chain validation
- URL and domain reputation analysis
- WHOIS ownership verification
- Behavioral and social engineering assessment
- Threat classification and risk evaluation

---

# 🔎 1. Initial Triage

## Email Characteristics

| Field | Value |
|---|---|
| Display Name | Meta User Experience Research |
| Subject | Participate in a Facebook Research Study |
| Theme | Research participation invitation |
| Call-To-Action | Survey participation |
| Sender Domain | research[.]metamail[.]com |

---

## Initial Observations

Several characteristics initially resembled phishing-style communication patterns:

- Reward-based participation messaging
- External survey links
- Complex subdomain structure
- Third-party email delivery infrastructure
- Tracking redirect URLs

The following text required additional validation:

```text
"If you are selected and participate in a study session, you'll receive up to €0 EUR..."
```

The €0 reward value appeared unusual and warranted further investigation.

Despite these suspicious characteristics, no immediate indicators of credential harvesting, financial fraud, or malicious attachment delivery were identified.

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

Authentication mechanisms aligned successfully with Meta-controlled infrastructure.

The email demonstrated:

- Valid SPF authorization
- Legitimate DKIM signing
- Proper DMARC alignment
- Authorized sender infrastructure

Unlike phishing campaigns abusing authentication loopholes, the authentication results fully aligned with legitimate Meta infrastructure ownership.

The analysis significantly reduced the likelihood of spoofing or impersonation activity.

---

# 🖥️ 3. Header & Infrastructure Analysis

## Sending Infrastructure

| Attribute | Value |
|---|---|
| Primary Domain | metamail[.]com |
| Mail Infrastructure | bounce[.]research[.]metamail[.]com |
| Reply-To Domain | facebook-research[.]facebookmail[.]com |
| Infrastructure Provider | Salesforce |
| Country | United States |

---

## Header Analysis Findings

Analysis of the raw email headers identified:

- Legitimate Meta-controlled sender domains
- Proper authentication alignment
- Authorized mail delivery infrastructure
- Trusted third-party email delivery services
- Consistent relay path behavior

The infrastructure leveraged Salesforce-hosted email delivery services commonly used for enterprise-scale communication campaigns.

No suspicious relay behavior, spoofing attempts, or infrastructure anomalies were identified.

---

# 🌐 4. Domain & Reputation Validation

## Domain Information

| Attribute | Value |
|---|---|
| Domain | metamail[.]com |
| Registration Date | 1998-12-09 |
| Registrant | Meta Platforms, Inc. |
| Nameservers | ns[.]facebook[.]com |
| Registrar | RegistrarSEC LLC |

---

## Domain Analysis

WHOIS analysis confirmed:

- Long-established domain ownership
- Direct association with Meta Platforms
- Facebook-controlled nameserver infrastructure
- Legitimate enterprise registration details

Unlike phishing infrastructure, the domain demonstrated:

- Mature operational history
- Transparent ownership attribution
- Stable infrastructure management
- Enterprise-level domain governance

These characteristics strongly supported legitimacy.

---

## Reputation Findings

VirusTotal analysis showed:

- Zero malicious detections
- No phishing classifications
- No reputation-based security alerts

URLScan analysis additionally validated:

- Legitimate HTTPS configuration
- Salesforce infrastructure attribution
- Expected enterprise redirect behavior

No evidence of malicious infrastructure usage was identified.

---

# 🔗 5. URL & Redirect Analysis

URL analysis was performed using URLScan.io and VirusTotal.

---

## Redirect Behavior

The infrastructure utilized standard enterprise tracking redirects:

```text
click[.]research[.]metamail[.]com
        ↓
Meta research redirect handling
        ↓
Expired survey landing page
```

---

## Key Findings

### Enterprise Infrastructure Usage

The redirect infrastructure leveraged:

- Salesforce-hosted infrastructure
- Meta-owned domains
- HTTPS-secured communication
- Standard enterprise tracking behavior

---

### Redirect Analysis

URLScan analysis identified:

- Single redirect flow
- No malicious payload delivery
- No credential harvesting behavior
- No suspicious external infrastructure

The redirect behavior aligned with legitimate email campaign tracking commonly used in enterprise marketing and research operations.

---

### Detection Visibility

VirusTotal analysis demonstrated:

- Zero vendor detections
- Clean reputation status
- No threat intelligence associations

This behavior aligned with legitimate enterprise infrastructure rather than newly deployed or evasive phishing infrastructure.

---

# 🧠 6. Content & Social Engineering Analysis

## Social Engineering Techniques Identified

| Technique | Observed |
|---|---|
| Brand Impersonation | No |
| Reward-Based Lure | Limited |
| Urgency Language | No |
| Curiosity Trigger | Moderate |
| Embedded CTA | Yes |

---

## Behavioral Assessment

The email used standard enterprise communication patterns including:

- professional formatting
- transparent participation details
- legitimate branding
- voluntary participation language

Unlike phishing campaigns, the email did NOT attempt to:

- steal credentials
- create urgency
- induce panic
- request financial information
- deploy malicious payloads

Although reward-based participation language initially appeared suspicious, contextual analysis and infrastructure validation confirmed legitimate business intent.

---

# ⚠️ 7. Incident Classification & Risk Assessment

## Classification

| Category | Verdict |
|---|---|
| Spam | No |
| Phishing | No |
| BEC | No |
| Legitimate | Confirmed |

---

## Risk Assessment

| Risk Factor | Assessment |
|---|---|
| User Interaction Likelihood | Moderate |
| Credential Theft Potential | None Observed |
| Infrastructure Sophistication | Enterprise |
| Detection Evasion | Not Observed |
| Brand Abuse | No |

---

## Final Assessment

This investigation confirmed the email as legitimate Meta communication leveraging:

- properly authenticated infrastructure
- enterprise-grade email delivery systems
- trusted third-party infrastructure
- long-established domain ownership
- benign redirect behavior

Although several characteristics initially resembled phishing infrastructure, contextual and technical validation confirmed legitimate operational intent.

---

# 🚨 8. Indicators of Compromise (IOCs)

## Domains

```text
metamail[.]com
research[.]metamail[.]com
click[.]research[.]metamail[.]com
facebookmail[.]com
```

---

## IP Addresses

```text
128[.]245[.]99[.]166
```

---

## URLs

```text
https://click[.]research[.]metamail[.]com/
```

> All indicators have been defanged for safe handling and documentation purposes.

---

# 🛠️ 9. Containment & Remediation Recommendations

No containment actions were required.

Recommended analyst actions:

- Validate unfamiliar enterprise mail infrastructure before classification
- Correlate authentication results with ownership attribution
- Avoid relying solely on visual suspicion indicators
- Continue monitoring for infrastructure impersonation attempts involving Meta branding

---

# 🔑 10. Key Investigation Takeaways

This investigation demonstrates several important real-world email analysis principles:

- Legitimate enterprise infrastructure can initially appear suspicious
- Reward-based language alone does not confirm phishing activity
- Complex subdomains require ownership validation
- Authentication alignment remains critical for legitimacy assessment
- Infrastructure attribution is essential during email investigations
- Contextual analysis is necessary alongside technical indicators

---

# 📝 Analyst Notes

This case demonstrates how legitimate enterprise communication can resemble phishing activity when viewed without contextual analysis.

The investigation required correlating:

- authentication results,
- domain ownership,
- redirect behavior,
- infrastructure attribution,
- and behavioral analysis

to accurately classify the email as legitimate.

The case highlights the importance of analyst judgment and contextual reasoning within SOC operations.

---

# 📎 Related Evidence

| Evidence | Description |
|---|---|
| 01-meta-email-content-analysis.png | Initial email content and participation invitation |
| 02-meta-header-authentication-analysis.png | SPF/DKIM/DMARC validation findings |
| 03-meta-urlscan-infrastructure-analysis.png | URLScan redirect and infrastructure validation |
| 04-meta-domain-ownership-analysis.png | WHOIS ownership and domain legitimacy analysis |

---
