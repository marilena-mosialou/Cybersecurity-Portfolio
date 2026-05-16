# 🛡️ Mitigation Strategies

## 📌 Purpose

This document outlines defensive mitigation strategies relevant to the attack techniques demonstrated throughout the Active Directory attack simulation.

The objective is to identify practical security controls that could reduce the likelihood, impact, or detectability of the attack chain observed within the lab environment.

Rather than focusing on isolated vulnerabilities, this document emphasizes layered defense strategies across:

- Identity security
- Endpoint protection
- Authentication hardening
- Privilege management
- Active Directory security
- Monitoring and detection
- Network segmentation

The attack progression demonstrated throughout the lab highlights how multiple low-to-medium severity weaknesses can combine to create critical enterprise risk.

---

# 🎯 Defensive Security Goals

The primary defensive objectives within enterprise Active Directory environments should include:

- Prevent credential exposure
- Reduce attack surface
- Restrict lateral movement
- Enforce least privilege
- Improve authentication security
- Increase visibility into attacker behavior
- Detect credential abuse early
- Limit blast radius during compromise

---

# 🔐 Identity & Authentication Security

Compromised credentials played a central role throughout the attack chain.

Improving identity security significantly reduces attacker progression opportunities.

---

# 🟥 Mitigating LLMNR/NBT-NS Poisoning

## Weakness Observed

LLMNR and NetBIOS Name Service were enabled within the environment, allowing Responder-based credential interception attacks.

## Recommended Mitigations

### Disable LLMNR

LLMNR should generally be disabled through Group Policy within enterprise environments.

### Disable NetBIOS Name Service

NBT-NS should be disabled unless operationally required.

### Enforce SMB Signing

SMB signing helps reduce relay and authentication abuse opportunities.

### Network Segmentation

Restrict unnecessary workstation-to-workstation communication where possible.

## Defensive Impact

These mitigations significantly reduce opportunities for credential interception and rogue name resolution abuse.

---

# 🟧 Mitigating Weak Password Practices

## Weakness Observed

Weak and predictable passwords enabled credential validation and service account compromise.

## Recommended Mitigations

### Enforce Strong Password Policies

Implement:
- Minimum password length requirements
- Complexity requirements
- Password history enforcement

### Deploy Account Lockout Policies

Restrict password spraying and repeated authentication attempts.

### Prevent Password Reuse

Implement password filtering and reuse restrictions where possible.

### Encourage Long Passphrases

Length-based password strategies are generally more resilient than simple complexity rules alone.

## Defensive Impact

Strong credential hygiene significantly increases attacker cost during credential attacks.

---

# 🟨 Mitigating Active Directory Enumeration

## Weakness Observed

Valid credentials enabled large-scale Active Directory enumeration using BloodHound.

## Recommended Mitigations

### Limit Excessive ACL Exposure

Review and reduce unnecessary object permissions including:
- GenericWrite
- WriteDacl
- AddKeyCredentialLink

### Restrict Anonymous Enumeration

Ensure directory access permissions follow least privilege principles.

### Monitor Enumeration Activity

Detect:
- Excessive LDAP queries
- Privileged group enumeration
- Large-scale object collection

### Tier Administrative Access

Separate privileged administrative identities from standard user accounts.

## Defensive Impact

Reducing unnecessary visibility into directory relationships limits attacker reconnaissance capabilities.

---

# 🟦 Mitigating Lateral Movement

## Weakness Observed

Valid credentials enabled authentication across internal systems and administrative SMB access.

## Recommended Mitigations

### Restrict SMB Administrative Shares

Limit administrative share access to authorized administrators only.

### Limit Local Administrator Privileges

Avoid unnecessary administrative rights across workstations and servers.

### Implement Host-Based Firewalls

Restrict lateral communication paths between endpoints.

### Deploy Privileged Access Workstations (PAWs)

Separate administrative activity from standard user environments.

### Harden Remote Management Protocols

Restrict:
- WMI
- SMB
- PowerShell Remoting
- PsExec-style administrative workflows

## Defensive Impact

Restricting lateral movement pathways significantly reduces attacker freedom within enterprise environments.

---

# 🟪 Mitigating LSASS Credential Dumping

## Weakness Observed

Credential material stored within LSASS memory enabled privilege escalation and administrative compromise.

## Recommended Mitigations

### Enable LSASS Protection

Use:
- Credential Guard
- RunAsPPL (Protected Process Light)

### Deploy EDR Solutions

Modern EDR platforms can identify:
- LSASS access attempts
- Memory dumping behavior
- ProcDump abuse
- Credential theft tooling

### Restrict Debug Privileges

Limit SeDebugPrivilege usage to authorized administrators only.

### Monitor Process Access Behavior

Identify abnormal access to:
```text
lsass.exe
```

### Disable Unnecessary Credential Caching

Reduce reusable authentication material stored on systems.

## Defensive Impact

Protecting LSASS significantly increases attacker difficulty during post-exploitation credential theft attempts.

---

# 🟫 Mitigating Administrative SMB Access Abuse

## Weakness Observed

Recovered Administrator credentials enabled authenticated access to administrative SMB shares on the Domain Controller.

## Recommended Mitigations

### Restrict Administrative Share Usage

Limit remote access to:
- ADMIN$
- C$
- IPC$

### Implement Just-In-Time (JIT) Administration

Provide temporary administrative access only when required.

### Monitor High-Privilege Authentication

Track:
- Administrator logons
- Cross-host administrative activity
- Remote administrative access

### Separate Administrative Accounts

Use dedicated administrative accounts instead of shared privileged identities.

## Defensive Impact

Reducing privileged SMB exposure limits opportunities for lateral movement and post-compromise operations.

---

# 🟩 Mitigating Kerberoasting

## Weakness Observed

Service accounts with SPNs and weak passwords enabled offline Kerberos ticket cracking.

## Recommended Mitigations

### Use Strong Service Account Passwords

Service accounts should use:
- Long random passwords
- Managed credentials
- Rotation policies

### Deploy Group Managed Service Accounts (gMSAs)

gMSAs reduce manual password management risk.

### Minimize SPN Exposure

Only configure SPNs where operationally required.

### Restrict Legacy Kerberos Encryption

Disable RC4 support where possible.

### Monitor Kerberos TGS Requests

Identify:
- Abnormal service ticket volume
- Unusual SPN targeting
- High-frequency TGS requests

## Defensive Impact

Proper service account hygiene significantly reduces Kerberoasting exposure.

---

# 🟥 Mitigating NTDS.dit Extraction & Domain Compromise

## Weakness Observed

Administrative credentials enabled extraction of the Active Directory credential database.

## Recommended Mitigations

### Restrict Domain Admin Usage

Domain Admin accounts should be:
- Rarely used
- Highly monitored
- Isolated from standard operations

### Tier Administrative Access

Separate:
- Workstation administration
- Server administration
- Domain administration

### Monitor Replication Activity

Detect:
- DCSync behavior
- Abnormal replication requests
- Unauthorized directory replication access

### Harden Domain Controllers

Apply:
- Application whitelisting
- Reduced attack surface
- Strict administrative controls

### Protect krbtgt Account Integrity

Rotate krbtgt passwords after suspected compromise.

## Defensive Impact

Strong Domain Controller hardening dramatically reduces enterprise-wide compromise risk.

---

# 📊 Monitoring & Detection Recommendations

Effective defense depends heavily on visibility and behavioral monitoring.

---

# Recommended Logging Improvements

## Enable Sysmon

Sysmon provides visibility into:

- Process creation
- Network connections
- Process access
- Image loads
- PowerShell activity

## Centralize Logging

Aggregate:
- Windows Security Logs
- Sysmon telemetry
- PowerShell logs
- Authentication events

into centralized SIEM platforms.

## Monitor Authentication Behavior

Identify:
- Password spraying
- Lateral movement
- Cross-host authentication anomalies
- Administrative logon activity

## Correlate Multi-Stage Activity

Focus on behavioral chains rather than isolated events.

---

# 🔒 Privilege Management Recommendations

Least privilege enforcement remains one of the most effective defensive controls.

## Recommended Actions

- Remove unnecessary local administrators
- Audit privileged group membership regularly
- Restrict service account privileges
- Eliminate shared administrator accounts
- Limit standing privileged access

## Administrative Tiering

Separate:
- User accounts
- Server administration
- Domain administration

to reduce privilege escalation pathways.

---

# 🌐 Network Security Recommendations

## Segment Critical Systems

Separate:
- Workstations
- Servers
- Domain Controllers
- Administrative systems

using VLANs and firewall rules.

## Restrict Internal SMB Traffic

Limit workstation-to-workstation SMB communication where operationally possible.

## Monitor East-West Traffic

Track internal:
- SMB
- LDAP
- Kerberos
- WMI
- RPC

communication patterns.

## Defensive Impact

Network segmentation significantly reduces attacker lateral movement opportunities.

---

# 🧠 Security Awareness & Operational Security

Technical controls alone are insufficient without strong operational security practices.

## Recommended Operational Improvements

- Train administrators on credential hygiene
- Reduce privileged account exposure
- Separate administrative workflows
- Enforce MFA for privileged accounts
- Regularly audit Active Directory permissions

---

# ⚠️ Defense-in-Depth Considerations

One of the primary lessons demonstrated throughout this lab is the importance of layered security controls.

No single defensive control would have fully prevented the attack chain.

However, combining:

- Strong password policies
- LSASS protection
- Segmentation
- Monitoring
- Privilege restriction
- Service account hardening

would have significantly reduced attacker success probability.

---

# 🔗 Relationship Between Offensive & Defensive Security

This project intentionally demonstrates the relationship between:

- Offensive attack methodology
- Defensive visibility
- Security hardening
- Monitoring maturity

Each offensive technique observed throughout the attack chain directly maps to corresponding defensive controls and detection opportunities.

This relationship is explored further in the associated SOC investigation project.

---

# 🚀 Key Takeaways

The attack simulation demonstrates that successful Active Directory compromise frequently results from multiple combined weaknesses rather than a single catastrophic vulnerability.

Key defensive lessons include:

- Weak credentials remain a major enterprise risk
- Credential exposure enables rapid attack progression
- Service accounts significantly expand attack surface
- Privilege boundaries help slow attacker movement
- Monitoring and detection are critical for early response
- Layered security controls dramatically improve resilience
- Defense-in-depth remains essential within Active Directory environments
