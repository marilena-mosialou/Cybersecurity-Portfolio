# 🧪 Email Analysis — Meta Research Email

---

## 🧾 Step 1 — Initial Triage

**Subject:** Reminder - Participate in a Facebook Research Study about our products | 4/2–4/10  
**Sender:** facebook@research.metamail.com  
**Spam classification:** Classified as spam by Gmail 

**Initial Impression:**  
The email appears professionally formatted and does not contain obvious grammatical errors. The sender address includes a subdomain (research.metamail.com) that is not immediately recognizable as an official Meta domain, which raises initial suspicion. Additionally, the email was automatically classified as spam by Gmail, increasing the need for further investigation. No immediate high-risk indicators such as urgency or threatening language were observed.
The use of a subdomain rather than a primary domain (e.g. meta.com) introduces ambiguity and warrants further verification.

---

## 🔐 Step 2 — Authentication Analysis

SPF, DKIM, and DMARC checks all passed successfully, indicating that the email was sent from an authorized mail server associated with the domain research.metamail.com. Additionally, the message was signed using DKIM by both research.metamail.com and Salesforce infrastructure, suggesting the use of a legitimate email delivery service.
However, while these authentication mechanisms confirm that the email is not spoofed, they do not verify the legitimacy of the organization behind the domain. The domain research.metamail.com is not immediately recognizable as an official Meta domain, and therefore requires further validation.

Authentication results extracted from email headers using Gmail ‘Show original’ feature.

spf=pass (domain designates 128.245.67.34 as permitted sender)
dkim=pass (domain: research.metamail.com)
dmarc=pass (policy=reject)

Although the email is not spoofed and passes authentication checks, the risk lies in the potential misuse of a legitimate domain or marketing infrastructure to deliver misleading content. This could facilitate social engineering attacks by encouraging the user to interact with links or provide information under the assumption that the message is trustworthy.

---

## 🌐 Step 3 — Email Path & IP Analysis

Analysis of the email headers shows that the message was received from the mail server `mta2.facebook-research.facebookmail.com` with IP address `128.245.67.34`. The email was directly transmitted to Google’s mail servers without passing through suspicious or unknown intermediaries.

The sending infrastructure appears to be associated with Meta’s email delivery systems (facebookmail.com), which suggests a potential link to legitimate infrastructure but does not independently confirm authenticity.

The absence of unusual relay servers or geographic anomalies reduces the likelihood of email tampering or malicious redirection during transmission.

---

## 🌍 Step 4 — Domain & Infrastructure Validation

WHOIS analysis of the domain `metamail.com` shows that it is registered to Meta Platforms, Inc., with name servers pointing to facebook.com, confirming its association with Meta’s infrastructure. The domain was originally registered in 1998, indicating long-term legitimacy rather than recent creation.  

Additionally, the sending IP address (`128.245.67.34`) is associated with Salesforce, a widely used enterprise email delivery platform. The hostname (facebookmail.com) confirms that the email was sent through Meta’s official communication infrastructure.  

These findings validate the authenticity of the sending infrastructure and resolve the ambiguity identified in earlier analysis steps.

---

## 🔗 Step 5 — URL Analysis

The embedded link in the email was analyzed to determine its behavior and legitimacy.  

The URL points to the subdomain:  
`click.research.metamail.com`  

which is consistent with previously identified Meta-controlled infrastructure.  

An attempt was made to analyze the URL using urlscan.io; however, the scan could not be completed. This may occur due to access restrictions, bot protection mechanisms, or security configurations that block automated scanning tools. Such behavior is commonly observed in legitimate enterprise systems as well as protected environments.  

Additional analysis using VirusTotal showed 0 detections across multiple security vendors, indicating no known malicious classification.  

While the absence of detection does not guarantee safety, the domain consistency (research.metamail.com), alignment with known Meta infrastructure, and lack of suspicious redirect behavior or domain mismatches support the conclusion that the URL is legitimate.  

No indicators of malicious redirection, domain abuse, or phishing behavior were identified during analysis.  

The consistent use of a Meta-controlled subdomain for link redirection is typical of legitimate email tracking and campaign management systems.
