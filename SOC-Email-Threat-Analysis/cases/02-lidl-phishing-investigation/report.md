# 🧪 Lidl Reward Phishing Campaign Investigation

## 📌 Case Overview

This investigation documents the analysis of a phishing email impersonating Lidl and leveraging reward-based social engineering to lure recipients into interacting with attacker-controlled infrastructure.

The campaign abused trusted cloud infrastructure, implemented multi-stage redirect behavior, and utilized newly registered domains to reduce detection likelihood and complicate automated analysis.

The investigation followed the structured SOC Email Investigation Workflow documented in this repository.

---

# 📋 Executive Summary

| Category | Value |
|---|---|
| Incident Type | Phishing |
| Threat Theme | Reward / Prize Scam |
| Impersonated Brand | Lidl |
| Primary Objective | User interaction and potential credential harvesting |
| Delivery Method | Email |
| Infrastructure Abuse | Google Cloud Storage |
| Authentication Findings | SPF/DKIM pass with DMARC failure |
| Domain Characteristics | Newly registered suspicious domain |
| Risk Level | High |
| Final Verdict | Confirmed Phishing Campaign |

---

# 🎯 Investigation Scope

The investigation focused on:

- Email authentication validation
- Sender infrastructure analysis
- Redirect chain behavior
- URL and infrastructure reputation
- Domain registration analysis
- Social engineering techniques
- Threat classification and risk assessment

---

# 🔎 1. Initial Triage

## Email Characteristics

| Field | Value |
|---|---|
| Display Name | Lidl |
| Subject | Reward / prize notification |
| Theme | “You have won a Parkside 3 Piece Set” |
| Call-To-Action | Claim reward |
| Sender Domain | mpusniska[.]uk[.]com |

---

## Initial Observations

Several indicators immediately suggested malicious intent:

- Brand impersonation using Lidl identity
- Reward-based social engineering
- Urgency and excitement-driven language
- Suspicious sender infrastructure
- Generic phishing formatting
- Embedded interaction lure

The message attempted to create curiosity and urgency while encouraging rapid user interaction.

---

# 🛡️ 2. Authentication Analysis

Authentication analysis was performed using Google Admin Toolbox – Messageheader.

## Authentication Results

| Control | Result |
|---|---|
| SPF | PASS |
| DKIM | PASS |
| DMARC | FAIL |

---

## Analysis

Although SPF and DKIM passed successfully, neither result validated legitimate Lidl ownership or infrastructure alignment.

The email was authenticated only for the attacker-controlled domain:

```text
bkyhdkuciu[.]mpusniska[.]uk[.]com
```

DMARC alignment failed because the authenticated infrastructure did not align with the impersonated Lidl identity.

This behavior is commonly observed in phishing campaigns leveraging attacker-owned infrastructure while abusing trusted email authentication mechanisms to bypass basic filtering controls.

---

# 🖥️ 3. Header & Infrastructure Analysis

## Sending Infrastructure

| Attribute | Value |
|---|---|
| Sending IP | 136[.]243[.]99[.]211 |
| Hosting Provider | Hetzner |
| Country | Germany |
| Infrastructure Type | VPS / Hosting Provider |

---

## Header Analysis Findings

Analysis of the raw headers identified:

- Authenticated delivery from attacker-controlled infrastructure
- Successful SMTP delivery through legitimate mail relays
- DKIM signing tied to the malicious domain
- Non-alignment between sender identity and infrastructure ownership

The sending infrastructure demonstrated characteristics commonly associated with disposable phishing infrastructure:

- VPS hosting usage
- Newly registered domains
- Cloudflare nameserver usage
- Short operational lifecycle

---

# 🌐 4. Domain & Reputation Validation

## Domain Information

| Attribute | Value |
|---|---|
| Domain | mpusniska[.]uk[.]com |
| Registration Date | 2026-05-05 |
| Expiration | 1 year |
| Nameservers | Cloudflare |
| Registrar | Instra Corporation Pty Ltd |

---

## Domain Analysis

The domain was registered shortly before campaign activity.

Key suspicious indicators included:

- Newly registered domain
- Short registration lifecycle
- No legitimate Lidl association
- Infrastructure anonymization through Cloudflare
- Randomized domain naming pattern

These characteristics align strongly with phishing infrastructure designed for short-term operational use.

---

## AbuseIPDB Findings

The sending IP had limited public reporting history at the time of analysis.

This does not reduce suspicion.

Low-reputation or newly deployed phishing infrastructure frequently exhibits minimal historical reporting due to limited exposure time.

---

# 🔗 5. URL & Redirect Analysis

URL analysis was performed using URLScan.io and VirusTotal.

---

## Redirect Behavior

The phishing infrastructure leveraged a multi-stage redirect chain:

```text
Google Cloud Storage
        ↓
optimistic-digital[.]xyz
        ↓
Conditional redirect behavior
        ↓
Benign RSS/news content
```

---

## Key Findings

### Trusted Infrastructure Abuse

The campaign abused Google Cloud Storage as a springboard mechanism to:

- Increase legitimacy
- Reduce detection likelihood
- Bypass reputation-based filtering

---

### Client-Side Redirection

The infrastructure utilized redirect chains and conditional routing behavior to obscure the final destination and complicate automated sandbox analysis.

---

### Anti-Analysis Behavior

URLScan results demonstrated that the infrastructure served benign RSS/news content during automated analysis.

This behavior strongly suggests sandbox-aware or conditional payload delivery logic.

---

### Detection Visibility

VirusTotal analysis showed minimal vendor detections despite suspicious redirect behavior.

This indicates:

- Recently deployed infrastructure
- Limited exposure window
- Detection evasion effectiveness

---

# 🧠 6. Content & Social Engineering Analysis

## Social Engineering Techniques Identified

| Technique | Observed |
|---|---|
| Brand Impersonation | Yes |
| Reward-Based Lure | Yes |
| Urgency Language | Yes |
| Curiosity Trigger | Yes |
| Embedded CTA | Yes |

---

## Behavioral Assessment

The phishing email relied heavily on reward-based psychological manipulation.

The campaign attempted to:

- Exploit curiosity
- Encourage impulsive interaction
- Leverage trusted branding
- Reduce recipient skepticism

The email structure followed common consumer phishing patterns frequently associated with credential harvesting or malicious redirect campaigns.

---

# ⚠️ 7. Incident Classification & Risk Assessment

## Classification

| Category | Verdict |
|---|---|
| Spam | Yes |
| Phishing | Confirmed |
| BEC | No |
| Legitimate | No |

---

## Risk Assessment

| Risk Factor | Assessment |
|---|---|
| User Interaction Likelihood | High |
| Credential Theft Potential | Moderate–High |
| Infrastructure Sophistication | Moderate |
| Detection Evasion | Present |
| Brand Abuse | Confirmed |

---

## Final Assessment

This campaign represents a confirmed phishing operation leveraging:

- Brand impersonation
- Trusted infrastructure abuse
- Conditional redirect behavior
- Newly registered attacker-controlled domains
- Authentication bypass techniques
- Reward-based social engineering

The infrastructure and behavioral indicators collectively demonstrate malicious intent despite limited public reputation data.

---

# 🚨 8. Indicators of Compromise (IOCs)

## Domains

```text
mpusniska[.]uk[.]com
optimistic-digital[.]xyz
storage[.]googleapis[.]com
```

---

## IP Addresses

```text
136[.]243[.]99[.]211
185[.]80[.]129[.]75
```

---

## URLs

```text
https://storage[.]googleapis[.]com/xhr09fe05fe2026/optimisticdigital[.]xyz[.]html
http://optimistic-digital[.]xyz/
```

> All indicators have been defanged for safe handling and documentation purposes.

---

# 🛠️ 9. Containment & Remediation Recommendations

Recommended response actions:

- Block identified domains and IP addresses
- Purge malicious emails from affected mailboxes
- Perform enterprise-wide IOC searches
- Monitor for related phishing infrastructure
- Educate users regarding reward-based phishing campaigns
- Implement stricter DMARC enforcement policies
- Review email gateway filtering for cloud-storage redirect abuse

---

# 🔑 10. Key Investigation Takeaways

This investigation demonstrates several important real-world phishing characteristics:

- SPF/DKIM passing does not validate legitimacy
- DMARC alignment failures remain critical indicators
- Threat actors increasingly abuse trusted cloud infrastructure
- Newly registered domains remain a strong phishing indicator
- Low public detection does not imply benign activity
- Behavioral and contextual analysis are essential alongside technical indicators

---

# 📝 Analyst Notes

This case demonstrates how modern phishing campaigns combine:

- legitimate infrastructure abuse,
- authentication manipulation,
- redirect obfuscation,
- and social engineering

to reduce detection likelihood and increase user interaction success rates.

The investigation required correlating authentication results, infrastructure analysis, redirect behavior, domain intelligence, and contextual reasoning to reach a final classification.

---

# 📎 Related Evidence

| Evidence | Description |
|---|---|
| 01-phishing-email-lure-analysis.png | Social engineering and phishing indicators |
| 02-email-authentication-analysis.png | SPF/DKIM/DMARC validation findings |
| 03-springboard-http-analysis.png | HTTP transactions and redirect behavior |
| 04-redirect-chain-analysis.png | Redirect chain and anti-analysis behavior |
| 05-low-detection-analysis.png | Vendor detection visibility assessment |
| 06-domain-registration-analysis.png | Domain registration and infrastructure analysis |

---
