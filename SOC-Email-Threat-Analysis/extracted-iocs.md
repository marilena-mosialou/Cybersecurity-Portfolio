# 🚨 Consolidated Threat Intelligence & IOC Reference

> This document consolidates extracted Indicators of Compromise (IOCs), infrastructure findings, and behavioral indicators identified across all investigations within this repository.

> All indicators have been defanged for safe handling and documentation purposes.

---

# 📌 Investigation Index

| Case ID | Investigation |
|---|---|
| 01 | Meta Legitimate Email Investigation |
| 02 | Lidl Phishing Investigation |
| 03 | Fountain / Vercel Phishing Investigation |
| 04 | BEC Urgent Payment Simulation |

---

# 🟢 01 — Meta Legitimate Email Investigation

## Classification

```text
Legitimate Email
```

---

## Domains

```text
facebookmail[.]com
metamail[.]com
facebook[.]com
```

---

## Infrastructure Indicators

```text
bounce.research.metamail[.]com
reply-SIDPGNERTODU5AHQYYQKMBWHBA[.]110049@facebook-research[.]facebookmail[.]com
```

---

## Key Findings

- Valid Meta-owned infrastructure
- Legitimate domain ownership
- Long-standing enterprise infrastructure
- Proper SPF/DKIM/DMARC alignment
- No phishing or malicious redirect behavior observed

---

# 🔴 02 — Lidl Phishing Investigation

## Classification

```text
Confirmed Phishing Campaign
```

---

## Domains

```text
mpusniska[.]uk[.]com
optimistic-digital[.]xyz
storage[.]googleapis[.]com
```

---

## URLs

```text
https://storage[.]googleapis[.]com/xhr09fe05fe2026/optimisticdigital[.]xyz[.]html
http://optimistic-digital[.]xyz/
```

---

## IP Addresses

```text
136[.]243[.]99[.]211
185[.]80[.]129[.]75
```

---

## Behavioral Indicators

```text
Reward-based phishing lure
Trusted cloud infrastructure abuse
Springboard redirect behavior
Client-side redirect delivery
Sandbox-aware infrastructure behavior
Brand impersonation
```

---

## Key Findings

- Abuse of Google Cloud Storage
- Redirect-based phishing delivery
- Newly registered phishing infrastructure
- Conditional redirect behavior observed
- Low public detection visibility
- Trusted infrastructure abuse

---

# 🔴 03 — Fountain / Vercel Phishing Investigation

## Classification

```text
Confirmed Phishing Campaign
```

---

## Domains

```text
fountain[.]com
link[.]fountain[.]com
challenge-captcha-job-applications[.]vercel[.]app
google-team[.]awsapps[.]com
```

---

## URLs

```text
https://link[.]fountain[.]com/ls/click
https://challenge-captcha-job-applications[.]vercel[.]app
```

---

## Email Indicators

```text
notifications@fountain[.]com
selena[.]kloe@google-team[.]awsapps[.]com
```

---

## IP Addresses

```text
192[.]254[.]121[.]177
64[.]29[.]17[.]131
104[.]18[.]18[.]164
216[.]198[.]79[.]195
```

---

## Behavioral Indicators

```text
Trusted SaaS infrastructure abuse
Open redirect abuse
Recruitment-themed phishing
Cloud-hosted phishing infrastructure
Reply-To manipulation
Professional targeting
Low-detection infrastructure
```

---

## Key Findings

- Abuse of legitimate Fountain recruitment infrastructure
- Open redirect phishing delivery chain
- Vercel-hosted phishing infrastructure
- Valid SPF/DKIM/DMARC alignment
- Trusted cloud infrastructure abuse
- Professional social engineering targeting

---

# 🟠 04 — BEC Urgent Payment Simulation

## Classification

```text
Simulated Business Email Compromise (BEC)
```

---

## Email Indicators

```text
john.keller@company-corp[.]com
finance@company[.]com
```

---

## Lookalike Domain Indicators

```text
company-corp[.]com
company[.]com
```

---

## Behavioral Indicators

```text
Executive impersonation
Financial fraud request
Urgency manipulation
Verification suppression
Lookalike domain abuse
Operational pressure tactics
```

---

## Key Findings

- Lookalike corporate domain impersonation
- Successful SPF/DKIM/DMARC alignment
- No malware or phishing URLs
- Behavioral/social engineering-focused attack
- Financial fraud targeting
- Trust exploitation methodology

---

# 🛡️ Common Threat Patterns Observed

## Trusted Infrastructure Abuse

Observed across multiple phishing investigations:

```text
Google Cloud Storage
Fountain
SendGrid
Vercel
Cloudflare
AWS infrastructure
```

Threat actors increasingly leverage legitimate infrastructure to:

- bypass reputation-based filtering,
- reduce detection visibility,
- and increase user trust.

---

## Authentication Evasion Patterns

Multiple cases demonstrated:

```text
SPF PASS
DKIM PASS
DMARC PASS
```

This reinforces a critical SOC investigation principle:

> Successful authentication validation does not guarantee legitimacy.

---

## Social Engineering Themes Identified

```text
Recruitment targeting
Executive impersonation
Reward-based phishing
Urgency manipulation
Trust exploitation
Professional context abuse
```

---

# ⚠️ MITRE ATT&CK Techniques Observed

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

# 📌 Analyst Notes

The investigations within this repository demonstrate how modern phishing and Business Email Compromise campaigns increasingly prioritize:

- trusted infrastructure abuse,
- valid authentication alignment,
- social engineering sophistication,
- and behavioral deception

over traditional malware-based delivery.

Several campaigns successfully bypassed conventional trust indicators through:

- SaaS infrastructure abuse,
- redirect-based delivery chains,
- cloud-hosted phishing infrastructure,
- and lookalike domain impersonation.

These cases reinforce the importance of combining:

- technical validation,
- contextual reasoning,
- behavioral analysis,
- and infrastructure investigation

during modern SOC email threat analysis workflows.
