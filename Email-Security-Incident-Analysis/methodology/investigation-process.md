# 🧠 Email Investigation Methodology

This document outlines the structured approach used to analyze email-based threats across all cases in this project.

---

## 1. Initial Triage
- Review subject, sender, and context
- Identify obvious red flags (urgency, rewards, impersonation)
- Assess initial risk level

---

## 2. Authentication Analysis
- Check SPF, DKIM, and DMARC results
- Determine whether the email is spoofed
- Understand limitations of authentication mechanisms

---

## 3. Email Path & IP Analysis
- Analyze “Received” headers
- Identify sending infrastructure
- Determine if IP belongs to trusted provider or hosting service

---

## 4. Domain & Infrastructure Validation
- Perform WHOIS lookup
- Check domain age and ownership
- Identify lookalike or suspicious domains

---

## 5. URL / Behavioral Analysis
- Analyze embedded links
- Observe redirect chains
- Identify abuse of legitimate services

---

## 6. Content & Behavioral Analysis
- Evaluate tone, intent, and request type
- Detect social engineering techniques
- Identify BEC patterns (no links, high urgency, financial requests)

---

## 7. Final Verdict
- Combine technical and contextual findings
- Classify email (Legitimate / Phishing / BEC)
- Assess risk level

---

## 🔑 Key Principle

Technical validation alone is not sufficient.  
Effective email analysis requires combining:

- Infrastructure analysis  
- Domain validation  
- Behavioral and contextual reasoning  

This reflects real-world SOC investigation practices.
