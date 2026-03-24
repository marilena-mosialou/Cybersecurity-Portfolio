# 🔴 Active Directory Attack Lab – End-to-End Attack Simulation

## 📌 Overview

This project simulates a real-world Active Directory compromise in a controlled lab environment.  

The objective was to replicate a full attack lifecycle — from initial access to domain dominance — while also analyzing detection opportunities through centralized logging (Sysmon + Splunk).

---

## 🏢 Scenario

This lab simulates a fictional company, **Solaris Creative**, a fast-growing digital agency managing sensitive client data.

As the organization's Security Engineer, the objective was to design, deploy, and assess the security of a centralized Active Directory environment, while monitoring activity through Splunk.

The environment reflects common real-world challenges such as rapid scaling, weak credential practices, and misconfigured access controls.

---

## 🎯 Objectives

- Simulate common enterprise attack techniques
- Perform credential harvesting and abuse
- Achieve lateral movement across systems
- Escalate privileges to Domain Admin
- Analyze logs and identify detection opportunities

---

## 🏗️ Lab Environment

### 🖥️ Infrastructure

- **Domain Controller:** Windows Server 2022 (SOLARIS-DC-01)
- **Client Machine:** Windows 11 (SOLARIS-PC-01)
- **Attacker Machine:** Kali Linux
- **SIEM Server:** Ubuntu (Splunk + Sysmon ingestion)

### 🌐 Network

- Domain: `solaris.local`
- Internal IP Range: `192.168.10.0/24`

---

## ⚙️ Environment Configuration

### 🔧 Active Directory Setup

- Domain created: `solaris.local`
- Automated provisioning via PowerShell (`provision.ps1`)

Organizational Units (OUs):

- 01-Executives
- 02-Creative
- 03-Finance
- 04-IT-Admin
- 05-Service-Accounts

Provisioning was performed via a PowerShell script to simulate scalable enterprise deployment rather than manual configuration.

### 👥 User Simulation

- 9 domain users created via PowerShell automation
- Realistic attributes (department, role, descriptions)
- Multiple password patterns used (e.g., `Solaris2026!`, `AdminSolaris!`, `Backup123!`)

⚠️ Simulates weak and inconsistent enterprise credential practices

### 🔗 Domain Integration

- Windows 11 machine joined to domain
- Users mapped to appropriate groups

---

## ⚠️ Intentional Vulnerabilities

To simulate real-world weaknesses:

- LLMNR & NetBIOS enabled → Responder attacks
- Weak password policy → Password spraying risk
- Overprivileged accounts (e.g., helpdesk user)
- SMB share exposed to Domain Users
- Windows Defender partially disabled via GPO
- SMBv1 enabled on selected host

---

## 📊 Logging & Monitoring

- Sysmon deployed on endpoints
- Logs forwarded to Splunk server
- Enables detection of:
- Credential dumping
- Lateral movement
- Suspicious authentication patterns

---

# ⚔️ Attack Simulation

## Phase 1: Initial Foothold (Responder)
Captured NTLM hash via LLMNR poisoning.

> "Intercepted broadcast traffic and obtained user authentication hash."

---

## Phase 2: Credential Validation (CrackMapExec)
Validated captured credentials across domain systems.

> "Confirmed password reuse across multiple systems."

---

## Phase 3: Domain Enumeration (BloodHound)
Mapped Active Directory relationships and attack paths.

> "Identified shortest path to Domain Admin through misconfigured privileges."

---

## Phase 4: Lateral Movement (Impacket)
Executed remote commands on target machines.

> "Leveraged valid credentials to gain remote access."

---

## Phase 5: Privilege Escalation (Mimikatz / PowerView)
Extracted high-privileged credentials from memory.

> "Dumped credentials from LSASS and escalated privileges."

---

## Phase 6: Kerberoasting (Planned / In Progress)
Identify service accounts with Service Principal Names (SPNs) and extract Kerberos tickets for offline cracking.

> "Targeted service accounts to obtain crackable Kerberos tickets and escalate privileges."

---

# 🔍 Detection & Analysis

### Key Indicators of Compromise (IOCs)
- Abnormal NTLM authentication traffic
- Multiple failed login attempts (password spraying)
- Suspicious process creation (Mimikatz)
- Remote execution events

### Example Logs
- Event ID 4624 (Logon)
- Event ID 4625 (Failed logon)
- Sysmon Event ID 1 (Process creation)
- Sysmon Event ID 10 (Process access)

---

# 🛡️ Mitigation Strategies

- Disable LLMNR & NetBIOS
- Enforce strong password policies
- Implement least privilege access
- Restrict SMB share permissions
- Monitor authentication anomalies
- Enable Defender / EDR protections

---

# 🧠 Lessons Learned

- Weak credentials remain a critical entry point
- Misconfigured privileges enable rapid escalation
- Visibility (logging) is essential for detection
- Attack paths in AD are often non-obvious without tools like BloodHound

---

# 📸 Screenshots

- Lab architecture diagram
- AD user structure
- PowerShell automation output
- Sysmon installation
- Attack execution evidence

---

# 🚀 Key Takeaways

This lab demonstrates the ability to:
- Build and secure an AD environment
- Simulate real-world attack techniques
- Analyze attacker behavior through logs
- Understand both offensive and defensive perspectives

---
