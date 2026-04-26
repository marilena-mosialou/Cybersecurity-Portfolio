# 📧 Email Security Incident Analysis

**Analyst Summary:**  
Investigated three email scenarios (legitimate, phishing, and BEC) to identify indicators of compromise, validate infrastructure, and assess risk using a structured SOC investigation methodology.

This project demonstrates how email threats are analyzed in real-world environments, combining technical validation with contextual reasoning to accurately determine legitimacy and risk.

---

## 🎯 Project Objectives

- Analyze real and simulated emails for security threats  
- Identify indicators of compromise (IOCs)  
- Differentiate between legitimate and malicious communications  
- Demonstrate investigation methodology used in SOC environments  

---

## 🧠 Methodology

Each case follows a structured investigation approach:

1. **Initial Triage** — Review sender, subject, and context  
2. **Authentication Analysis** — SPF, DKIM, DMARC validation  
3. **Email Path & IP Analysis** — Review infrastructure and delivery path  
4. **Domain & Infrastructure Validation** — WHOIS, DNS, reputation  
5. **URL / Behavioral Analysis** — Redirects, payload behavior  
6. **Final Verdict** — Risk assessment and conclusion  

This methodology reflects real-world incident response workflows and prioritizes both technical validation and contextual analysis.

---

## 📂 Cases Overview

### 🟢 Case 1 — Legitimate Email (Meta)
Analysis of a real email sent via Meta infrastructure.  
➡️ [View Full Analysis](./cases/case-1-meta-legitimate/analysis.md)

Focus: distinguishing legitimate communication from potential phishing.

**Key takeaway:**  
Authentication alone does not determine trust — infrastructure and context matter.

---

### 🔴 Case 2 — Phishing Email (Lidl Impersonation)
Analysis of a phishing email using brand impersonation and redirect chains.  
➡️ [View Full Analysis](./cases/case-2-lidl-phishing/analysis.md)

**Techniques identified:**
- Lookalike domain  
- VPS-based infrastructure  
- Redirect chaining via legitimate services  
- Social engineering incentives  

**Key takeaway:**  
Attackers can bypass detection by abusing trusted platforms and clean reputation domains.

---

### 🟡 Case 3 — Business Email Compromise (BEC)
Simulated scenario involving an urgent payment request from a spoofed executive identity.  
➡️ [View Full Analysis](./cases/case-3-bec-attack/analysis.md)

**Techniques identified:**
- Authority impersonation  
- Urgency and time pressure  
- Lookalike domain  
- No technical payload (pure social engineering)  

**Key takeaway:**  
BEC attacks rely on human manipulation rather than technical exploits.

---

## 🛠️ Tools Used

- **Google Admin Toolbox (Messageheader)** — Header analysis  
- **WHOIS (whois.com)** — Domain and IP investigation  
- **AbuseIPDB** — IP reputation  
- **VirusTotal** — URL reputation analysis  
- **URLScan.io** — Behavioral URL analysis  
- **Google Search (OSINT)** — Domain reputation and infrastructure validation  

---

## 📊 Key Skills Demonstrated

- Email header analysis (SPF, DKIM, DMARC)  
- Threat detection and phishing analysis  
- Domain and infrastructure validation  
- Behavioral analysis of malicious URLs  
- Social engineering detection (BEC)  
- Incident reporting and documentation  

---

## 📌 Key Insights

- Passing authentication ≠ safe email  
- Legitimate services can be abused for malicious purposes  
- Behavior and context are critical in threat detection  
- Not all attacks rely on malware — some target human trust  

---

## 🚀 Why This Project Matters

This project demonstrates practical, job-ready skills required for:

- SOC Analyst roles  
- Threat Detection & Incident Response  
- Email Security Analysis  

It reflects how real-world investigations are conducted, combining technical tools with analytical reasoning.
