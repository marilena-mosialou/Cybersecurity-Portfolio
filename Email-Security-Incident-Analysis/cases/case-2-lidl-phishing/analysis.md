# 🧪 Email Analysis — Lidl Phishing Email

---

## 🧾 Step 1 — Initial Triage

**Subject:** mari... - έχετε κερδίσει ένα Σετ Parkside 3 Τεμαχίων 🎁ID#109891  
*(mari... - you have won a Parkside 3 Piece Set 🎁ID#109891)*  

**Sender:** info@xwrvndlxgx.checklipsteck.com.tr  
**Spam classification:** Classified as spam by Gmail  

**Initial Impression:**  
The email presents itself as a prize notification from Lidl, claiming that the recipient has won a “Parkside 3-piece set.” The message uses promotional language and persuasive wording to encourage the user to claim the reward.  

Several red flags are immediately visible. The sender domain (checklipsteck.com.tr) is unrelated to Lidl’s official domains, indicating a likely malicious or spoofed source. The email also attempts to impersonate Lidl’s branding by including a logo; however, the design appears inconsistent with the company’s official branding, suggesting a visual spoofing attempt.  

Additionally, the message contains common phishing characteristics such as an unexpected reward, a prominent call-to-action button (“Claim your reward”), and generic messaging.  

The email was correctly classified as spam by the email filtering system and, based on initial inspection, strongly indicates a phishing attempt.

---

## 🔐 Step 2 — Authentication Analysis

SPF, DKIM, and DMARC checks all passed successfully, indicating that the email was sent from an authorized mail server associated with the domain checklipsteck.com.tr. The sending IP address (103.195.191.92) is permitted to send emails on behalf of this domain, and the message was cryptographically signed using DKIM.  

However, these authentication results only verify that the email is legitimately sent from the domain it claims to originate from, not that the domain itself is trustworthy. The domain (checklipsteck.com.tr) is not consistent with known official Lidl domains and therefore raises suspicion.  

Additionally, the DMARC policy for the domain is set to p=NONE, which means no enforcement action (quarantine or reject) is applied even if authentication fails. This weak policy is commonly observed in malicious or poorly managed domains and does not provide meaningful protection against abuse.  

At this stage, the email is confirmed to be non-spoofed, but the legitimacy of the sending domain remains unverified and requires further investigation. This behavior is commonly observed in phishing campaigns, where attackers register their own domains and configure proper authentication records to bypass basic email security checks.

---

## 🌐 Step 3 — Email Path & IP Analysis

Analysis of the email headers shows that the message originated from the server static.103.195.191.92.orangevps.com with IP address 103.195.191.92, which is associated with a data center hosting provider rather than legitimate corporate email infrastructure.  

The hostname (orangevps.com / servepics.com) indicates the use of a generic VPS hosting service, which is commonly leveraged in phishing campaigns due to low cost and ease of setup.  

Additionally, the presence of an internal relay domain (fzletuuxhjgdku.com) further raises suspicion, as it appears to be a randomly generated and non-branded domain, inconsistent with legitimate email delivery systems.  

The email path does not align with expected infrastructure for a well-known organization such as Lidl and instead reflects characteristics commonly associated with attacker-controlled environments.

---

## 🌍 Step 4 — Domain & Infrastructure Validation

WHOIS analysis of the domain checklipsteck.com.tr reveals that the registrant information is hidden, and no identifiable organization is associated with the domain. This lack of transparency is commonly observed in suspicious or low-trust domains.  

The domain was registered relatively recently (October 2025), which is inconsistent with the expected long-standing presence of a legitimate global brand such as Lidl.  

Additionally, the domain name itself (checklipsteck.com.tr) does not align with Lidl’s official branding and appears to be randomly generated or intentionally obfuscated to mimic legitimacy.  

The domain uses Cloudflare name servers, which, while legitimate, are frequently used by attackers to mask underlying infrastructure and provide anonymity.  

Based on domain characteristics, registration details, and lack of association with Lidl, the domain is highly likely to be malicious and part of a phishing campaign.  

Additionally, the domain name structure appears irregular and unrelated to Lidl’s official branding, which indicates deceptive domain naming or typosquatting techniques commonly used in phishing campaigns.

---

## 🔗 Step 5 — URL Analysis

The embedded link in the email was analyzed using urlscan.io to observe its behavior in a safe, sandboxed environment.  

The analysis revealed that the initial URL redirects through multiple domains before reaching the final destination. Specifically:  

- Initial URL: storage.googleapis.com/...  
- Intermediate redirect: snaptasrasail.com/...  
- Final landing page: suspicious promotional page  

The use of multiple redirects is a common technique in phishing campaigns to evade detection and obscure the final destination.  

Although the initial domain (storage.googleapis.com) is a legitimate Google service, it is being abused as a redirect mechanism — a known tactic used by attackers to increase trust and bypass security filters.  

The final domain (snaptasrasail.com) appears unrelated to Lidl and does not match any official company infrastructure. Additionally, the domain is relatively new and lacks established reputation.  

Based on redirect behavior, domain mismatch, and abuse of legitimate services, the URL is highly suspicious and likely part of a phishing or scam campaign.

---

### 🔍 Additional Validation — VirusTotal Analysis

The URL was further analyzed using VirusTotal to assess its reputation across multiple security vendors.  

The scan result showed 0 detections out of 91 security vendors, indicating that the URL is not currently flagged as malicious.  

However, this does not guarantee that the URL is safe. Newly created or low-volume phishing URLs often evade detection due to limited exposure and lack of prior reports.  

Additionally, the URL leverages a legitimate domain (storage.googleapis.com), which can further reduce detection rates as attackers commonly abuse trusted platforms to host or redirect malicious content.  

These findings highlight the importance of behavioral analysis (e.g., redirect chains and domain mismatches) over reliance on reputation-based tools alone.
