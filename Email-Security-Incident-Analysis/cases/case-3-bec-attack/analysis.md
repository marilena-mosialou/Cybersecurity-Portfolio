# 🧪 Email Analysis — Business Email Compromise (BEC)

---

## 🧾 Scenario

Finance team reports an urgent payment request from “John (CEO)”.

---

## 🧾 Step 1 — Initial Triage

**Subject:** Urgent: Payment Required Today  
**Sender:** john.k@company-corp.com  
**Recipient:** finance@company.com  
**Spam classification:** Delivered to inbox (not flagged)  

**Initial Impression:**  
The email appears professionally written and does not contain obvious grammatical errors, malicious links, or attachments. However, it requests an urgent financial transaction, which is unusual and high risk.  

Immediate red flags include:  
- Urgent payment request (“today”, “end of day”)  
- Authority impersonation (CEO/manager tone)  
- Attempt to prevent verification (“in a meeting”)  
- Lack of standard signature or internal references  

Despite the clean presentation, the nature of the request raises strong suspicion of a Business Email Compromise (BEC) attempt.

---

## 🔐 Step 2 — Authentication Analysis

SPF, DKIM, and DMARC checks are assumed to pass, indicating that the email was sent from infrastructure authorized by the domain company-corp.com.  

However, these mechanisms only verify that the sender controls the domain—not that the domain is legitimate or affiliated with the target organization.  

At this stage, the email is considered non-spoofed, but the legitimacy of the sending domain remains unverified and requires further investigation.

---

## 🌐 Step 3 — Email Path & IP Analysis

Header analysis indicates that the email was delivered through standard email infrastructure (e.g., Google Workspace or similar cloud provider), with no unusual relay chains or transmission anomalies.  

The absence of suspicious routing does not indicate safety. BEC attacks commonly use legitimate email services to avoid detection.  

No technical anomalies were identified in the email path; therefore, risk assessment must rely on domain validation and content analysis.

---

## 🌍 Step 4 — Domain & Infrastructure Validation

The sender domain (company-corp.com) closely resembles the legitimate corporate domain (company.com) but is not identical.  

This discrepancy suggests the use of a lookalike domain, a common technique in BEC attacks to impersonate trusted entities.  

Such domains are often registered by attackers to appear legitimate at a glance while remaining under their control.  

This represents a form of typosquatting / deceptive domain naming, where small variations are used to mislead recipients.

---

## 🧠 Step 5 — Content & Behavioral Analysis (Critical)

The email contains no malicious links or attachments, which is consistent with BEC tactics that rely purely on social engineering.  

Key behavioral indicators include:  
- **Authority impersonation:** Sender presents as a senior executive  
- **Urgency:** Request framed as time-sensitive  
- **Financial action:** Direct request for payment  
- **Isolation tactic:** “I’m in a meeting” discourages verification  
- **Lack of standard process:** No invoice, approval chain, or internal reference  

These elements are characteristic of BEC attacks designed to bypass technical controls and exploit human trust.
