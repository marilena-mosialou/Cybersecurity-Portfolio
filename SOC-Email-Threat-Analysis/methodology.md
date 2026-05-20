# 📧 SOC Email Investigation Workflow

This document outlines the structured workflow used to investigate email-based threats across all cases within this project.

The investigation process combines technical validation, infrastructure analysis, behavioral assessment, and contextual reasoning to determine whether an email is legitimate, malicious, or part of a broader social engineering campaign.

---

# 🔎 1. Initial Triage

### Objectives
- Review sender, subject line, recipients, and overall context
- Identify urgency, impersonation attempts, financial themes, or suspicious requests
- Assess preliminary risk level and potential business impact

### Focus Areas
- Suspicious sender behavior
- Unusual requests
- Social engineering indicators
- High-risk keywords or themes

---

# 🛡️ 2. Authentication Analysis

### Objectives
- Validate SPF, DKIM, and DMARC results
- Determine whether authentication aligns with the sending infrastructure
- Identify spoofing attempts or abuse of legitimate services

### Focus Areas
- SPF alignment
- DKIM validation
- DMARC policy enforcement
- Authentication inconsistencies

---

# 🖥️ 3. Header & Infrastructure Analysis

### Objectives
- Analyze email headers and routing paths
- Identify originating infrastructure and sending servers
- Determine whether infrastructure is legitimate, suspicious, or anonymized

### Focus Areas
- "Received" header analysis
- Sending IP identification
- Mail relay path analysis
- Infrastructure provider validation

---

# 🌐 4. Domain & Reputation Validation

### Objectives
- Validate domain legitimacy and reputation
- Identify typosquatting, newly registered domains, or suspicious infrastructure
- Correlate findings with OSINT and threat intelligence sources

### Focus Areas
- WHOIS analysis
- Domain registration timelines
- Passive reputation analysis
- Infrastructure ownership validation

---

# 🔗 5. URL & Redirect Analysis

### Objectives
- Analyze embedded URLs and redirect behavior
- Detect credential harvesting or malicious payload delivery
- Identify abuse of trusted platforms and cloud services

### Focus Areas
- Redirect chain analysis
- Landing page inspection
- URL reputation analysis
- Abuse of legitimate infrastructure

---

# 🧠 6. Content & Social Engineering Analysis

### Objectives
- Evaluate tone, intent, and behavioral indicators
- Detect phishing and Business Email Compromise (BEC) techniques
- Assess psychological manipulation tactics

### Focus Areas
- Urgency and pressure tactics
- Financial fraud indicators
- Executive impersonation
- Credential harvesting language
- Request legitimacy

---

# ⚠️ 7. Incident Classification & Risk Assessment

### Objectives
- Correlate technical and contextual findings
- Determine final incident classification
- Assess severity and potential business impact

### Classification Types
- Legitimate
- Spam
- Phishing
- Business Email Compromise (BEC)

### Risk Factors
- Credential exposure
- Financial fraud potential
- Infrastructure reputation
- User interaction likelihood

---

# 🚨 8. Containment & Remediation Recommendations

### Objectives
- Define response and mitigation actions
- Reduce organizational exposure
- Support incident containment and future prevention

### Potential Actions
- Purge malicious emails from mailboxes
- Block malicious domains and IP addresses
- Escalate incidents to security teams
- Notify affected users
- Initiate IOC threat hunts across enterprise telemetry

---

# 🛠️ Tools & Platforms Used

This section outlines the tools and platforms used throughout the investigation process and their role within the workflow.

---

# Header & Authentication Analysis

## Google Admin Toolbox – Messageheader

### Purpose
- Parses raw email headers
- Extracts SPF, DKIM, and DMARC results
- Identifies sending infrastructure and routing paths
- Assists in spoofing detection and sender validation

### Use Cases
- Authentication validation
- Email path reconstruction
- Sending server identification

---

# Domain & Infrastructure Analysis

## WHOIS

### Purpose
- Retrieves domain registration details
- Identifies registrar information and registration timelines
- Detects newly registered or suspicious domains associated with phishing activity

### Use Cases
- Typosquatting detection
- Infrastructure validation
- Domain legitimacy assessment

---

## AbuseIPDB

### Purpose
- Performs IP reputation analysis
- Identifies historical malicious activity associated with IP addresses
- Assists in validating suspicious hosting infrastructure

### Use Cases
- Infrastructure reputation analysis
- Malicious IP identification

---

# URL & Redirect Analysis

## URLScan.io

### Purpose
- Analyzes URL behavior within a sandboxed environment
- Observes redirect chains and final destinations
- Detects phishing pages and abuse of legitimate cloud infrastructure

### Use Cases
- Redirect chain analysis
- Credential phishing investigation
- Infrastructure relationship mapping

---

## VirusTotal

### Purpose
- Aggregates detections from multiple security vendors
- Evaluates domain, IP, and URL reputation
- Identifies known malicious infrastructure and related artifacts

### Use Cases
- IOC enrichment
- Threat reputation analysis
- Infrastructure correlation

---

# Open Source Intelligence (OSINT)

## Google Search

### Purpose
- Validates organizational legitimacy and infrastructure ownership
- Identifies known associations between domains, services, and organizations
- Assists in distinguishing legitimate infrastructure from impersonation attempts

### Use Cases
- Infrastructure validation
- Threat context enrichment
- Reputation analysis

---

# 🔑 Key Investigation Principle

Technical indicators alone do not determine the final verdict.

Effective email threat analysis requires:
- Correlation of technical findings
- Infrastructure validation
- Behavioral analysis
- Contextual risk assessment
- Analyst judgment

This reflects real-world SOC investigation practices where technical evidence and contextual reasoning must be evaluated together.
