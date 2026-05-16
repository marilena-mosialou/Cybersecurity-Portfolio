# 🎯 MITRE ATT&CK Mapping

## 📌 Purpose

This document maps the attack techniques demonstrated throughout the Active Directory attack simulation to the MITRE ATT&CK framework.

The objective is to align observed attacker behavior with standardized adversary tactics and techniques commonly used in enterprise threat modeling, detection engineering, and security operations workflows.

Mapping attack activity to MITRE ATT&CK helps defenders:

- Understand adversary behavior patterns
- Improve detection engineering coverage
- Identify visibility gaps
- Prioritize defensive controls
- Correlate attack stages across incidents
- Standardize threat analysis workflows

The attack chain demonstrated throughout this project includes multiple techniques commonly associated with:

- Active Directory compromise
- Credential access
- Lateral movement
- Privilege escalation
- Enterprise reconnaissance
- Domain dominance operations

---

# 🧭 ATT&CK Tactic Overview

The attack progression touched multiple MITRE ATT&CK tactical categories.

| Tactic | ATT&CK ID |
|---|---|
| Reconnaissance | TA0043 |
| Credential Access | TA0006 |
| Discovery | TA0007 |
| Lateral Movement | TA0008 |
| Privilege Escalation | TA0004 |
| Defense Evasion | TA0005 |
| Collection | TA0009 |
| Persistence | TA0003 |

---

# 🔗 Full Attack Technique Mapping

| Attack Phase | Technique | ATT&CK ID | Tactic |
|---|---|---|---|
| LLMNR/NBT-NS Poisoning | Adversary-in-the-Middle | T1557 | Credential Access |
| NTLMv2 Hash Capture | Steal or Forge Authentication Certificates / Credentials | T1649 / T1003 | Credential Access |
| Credential Validation | Password Spraying | T1110.003 | Credential Access |
| SMB Authentication Testing | Valid Accounts | T1078 | Defense Evasion / Persistence |
| Active Directory Enumeration | Domain Trust Discovery | T1482 | Discovery |
| BloodHound Enumeration | Account Discovery | T1087 | Discovery |
| LDAP Enumeration | Directory Discovery | T1087.002 | Discovery |
| ACL Relationship Analysis | Permission Groups Discovery | T1069 | Discovery |
| Remote Execution Attempt | SMB/Windows Admin Shares | T1021.002 | Lateral Movement |
| WMI Remote Execution | Windows Management Instrumentation | T1047 | Execution |
| LSASS Memory Dumping | OS Credential Dumping: LSASS Memory | T1003.001 | Credential Access |
| ProcDump Usage | Signed Binary Proxy Execution | T1218 | Defense Evasion |
| Kerberoasting | Steal or Forge Kerberos Tickets: Kerberoasting | T1558.003 | Credential Access |
| Service Account Abuse | Valid Accounts | T1078 | Persistence / Defense Evasion |
| SMB Administrative Access | Remote Services: SMB/Windows Admin Shares | T1021.002 | Lateral Movement |
| NTDS.dit Extraction | OS Credential Dumping: NTDS | T1003.003 | Credential Access |
| Domain Credential Dumping | Credential Dumping | T1003 | Credential Access |
| DCSync / Replication Abuse | DCSync | T1003.006 | Credential Access |
| krbtgt Compromise | Golden Ticket Preparation | T1558.001 | Persistence |

---

# 🟥 Phase 1 — Initial Access & Credential Interception

## ATT&CK Techniques

| Technique | ATT&CK ID |
|---|---|
| Adversary-in-the-Middle | T1557 |
| LLMNR/NBT-NS Poisoning | T1557.001 |
| Credential Access | TA0006 |

## Description

The attacker leveraged broadcast name resolution protocols to intercept authentication traffic and capture NTLMv2 authentication material.

This behavior aligns closely with:
- adversary-in-the-middle behavior
- credential interception workflows
- internal authentication abuse

## Operational Relevance

This technique remains common in enterprise environments where:
- LLMNR remains enabled
- segmentation is weak
- authentication protocols are not hardened

---

# 🟧 Phase 2 — Credential Validation & Authentication Abuse

## ATT&CK Techniques

| Technique | ATT&CK ID |
|---|---|
| Password Spraying | T1110.003 |
| Valid Accounts | T1078 |
| SMB Authentication Abuse | T1021.002 |

## Description

Captured credentials were validated across internal systems using SMB authentication workflows.

The attacker leveraged legitimate authentication mechanisms rather than exploitation vulnerabilities.

## Operational Relevance

Valid account abuse remains one of the most common enterprise intrusion techniques because it frequently bypasses traditional security controls.

---

# 🟨 Phase 3 — Active Directory Enumeration

## ATT&CK Techniques

| Technique | ATT&CK ID |
|---|---|
| Account Discovery | T1087 |
| Domain Trust Discovery | T1482 |
| Permission Groups Discovery | T1069 |
| Directory Discovery | T1087.002 |

## Description

BloodHound-based enumeration was used to identify:
- users
- groups
- ACL relationships
- attack paths
- privilege boundaries

## Operational Relevance

Directory enumeration often precedes:
- privilege escalation
- lateral movement
- credential theft
- persistence operations

---

# 🟦 Phase 4 — Remote Execution Attempts

## ATT&CK Techniques

| Technique | ATT&CK ID |
|---|---|
| SMB/Windows Admin Shares | T1021.002 |
| Windows Management Instrumentation | T1047 |
| Remote Services | T1021 |

## Description

The attacker attempted remote command execution using Impacket tooling over SMB and WMI.

Although execution was denied, authentication succeeded.

## Operational Relevance

Remote administrative protocols are frequently abused for:
- lateral movement
- ransomware deployment
- remote tool execution
- post-exploitation operations

---

# 🟪 Phase 5 — LSASS Credential Dumping

## ATT&CK Techniques

| Technique | ATT&CK ID |
|---|---|
| OS Credential Dumping: LSASS Memory | T1003.001 |
| Credential Dumping | T1003 |
| Signed Binary Proxy Execution | T1218 |

## Description

ProcDump was used to generate LSASS memory dumps which were later parsed offline to recover reusable credential material.

## Operational Relevance

Credential dumping remains one of the highest-value post-exploitation techniques within Windows environments.

Recovered credentials often enable:
- privilege escalation
- lateral movement
- persistence
- domain compromise

---

# 🟫 Phase 6 — Administrative SMB Access

## ATT&CK Techniques

| Technique | ATT&CK ID |
|---|---|
| SMB/Windows Admin Shares | T1021.002 |
| Valid Accounts | T1078 |
| Remote Services | T1021 |

## Description

Recovered Administrator credentials enabled authenticated access to administrative SMB shares on the Domain Controller.

## Operational Relevance

Administrative share abuse remains extremely common in:
- ransomware intrusions
- enterprise lateral movement
- credential theft operations

---

# 🟩 Phase 7 — Kerberoasting & Service Account Abuse

## ATT&CK Techniques

| Technique | ATT&CK ID |
|---|---|
| Kerberoasting | T1558.003 |
| Steal or Forge Kerberos Tickets | T1558 |
| Valid Accounts | T1078 |

## Description

The attacker requested Kerberos service tickets associated with SPN-enabled service accounts and performed offline cracking against the extracted hashes.

## Operational Relevance

Kerberoasting remains highly effective against:
- weak service account passwords
- legacy service account management
- environments lacking gMSAs

---

# 🟥 Phase 8 — Domain Credential Extraction & Domain Compromise

## ATT&CK Techniques

| Technique | ATT&CK ID |
|---|---|
| NTDS Credential Dumping | T1003.003 |
| DCSync | T1003.006 |
| Credential Dumping | T1003 |
| Golden Ticket Preparation | T1558.001 |

## Description

Administrator credentials were leveraged to extract NTDS.dit and recover domain-wide credential material including the krbtgt account.

## Operational Relevance

Compromise of the krbtgt account enables:
- Golden Ticket attacks
- persistent domain access
- long-term enterprise compromise

This represents one of the highest-impact outcomes within Active Directory intrusions.

---

# 🔄 Attack Lifecycle Mapping

The attack chain demonstrates a realistic progression across multiple ATT&CK tactics.

| Attack Stage | ATT&CK Tactic |
|---|---|
| Initial Credential Capture | Credential Access |
| Credential Validation | Defense Evasion |
| Enumeration | Discovery |
| Remote Authentication | Lateral Movement |
| LSASS Dumping | Credential Access |
| Kerberoasting | Credential Access |
| SMB Administrative Access | Lateral Movement |
| NTDS Extraction | Credential Access / Persistence |

---

# 📊 Defensive Value of ATT&CK Mapping

MITRE ATT&CK mapping provides significant operational value for defenders.

## Benefits Include

- Improved detection engineering alignment
- Threat-informed defense planning
- Better SOC alert categorization
- Standardized reporting workflows
- Gap analysis for monitoring coverage
- Security control prioritization

---

# 🛡️ ATT&CK-Informed Defensive Priorities

The techniques observed throughout this project highlight several high-priority defensive monitoring areas.

## Critical Monitoring Priorities

| Technique | Defensive Focus |
|---|---|
| T1557 | Network poisoning detection |
| T1003.001 | LSASS access monitoring |
| T1558.003 | Kerberos ticket anomaly detection |
| T1021.002 | SMB lateral movement monitoring |
| T1003.006 | Replication abuse detection |

---

# 🔗 Relationship to SOC Investigation Workflow

The ATT&CK mappings documented within this project directly support:

- SIEM correlation
- Detection engineering
- SOC triage workflows
- Threat hunting operations
- Incident investigation

The associated SOC investigation project expands on these concepts through:
- Splunk analysis
- Event correlation
- Alert triage
- Timeline reconstruction
- Detection validation

---

# 🚀 Key Takeaways

This project demonstrates how modern Active Directory intrusions frequently involve multiple ATT&CK techniques chained together across several tactical stages.

Key lessons include:

- Credential abuse drives many enterprise intrusions
- Legitimate administrative protocols are frequently weaponized
- Enumeration and reconnaissance are critical attack phases
- Credential dumping remains central to domain compromise
- ATT&CK mapping improves defensive visibility and operational understanding
- Multi-stage attack chains require layered monitoring and detection coverage
