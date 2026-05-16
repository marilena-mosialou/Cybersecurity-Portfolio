# 🔍 Detection Opportunities

## 📌 Purpose

This document outlines key detection opportunities observed throughout the Active Directory attack simulation.

The objective is not to provide full detection engineering implementation, but rather to identify observable attacker behaviors, relevant telemetry sources, and security monitoring opportunities that defenders could leverage to identify malicious activity within a Windows enterprise environment.

The attack chain generated multiple forms of detectable activity across:

- Windows Event Logs
- Sysmon telemetry
- Authentication workflows
- Kerberos operations
- SMB authentication
- Process creation activity
- Credential access behavior

This document bridges the gap between offensive methodology and defensive visibility.

> 📎 Detailed investigation workflows, Splunk analysis, and detection engineering implementation are documented in the associated SOC investigation project.

---

# 🎯 Detection Strategy Overview

The attack chain demonstrates a critical defensive reality:

> Modern Active Directory attacks are often highly detectable when sufficient logging and behavioral monitoring are implemented.

Rather than focusing exclusively on malware signatures, defenders should prioritize visibility into:

- Authentication anomalies
- Credential access behavior
- Lateral movement patterns
- Administrative abuse
- Kerberos misuse
- Unusual process activity

The attack progression within this lab generated multiple opportunities for early detection before full domain compromise occurred.

---

# 📊 Logging & Telemetry Sources

The environment was configured with centralized monitoring through Sysmon and Splunk.

## Telemetry Sources Included

| Source | Purpose |
|---|---|
| Windows Security Logs | Authentication & account activity |
| Sysmon | Process and system activity |
| PowerShell Logging | Script execution visibility |
| SMB Authentication Events | Lateral movement monitoring |
| Kerberos Logs | Ticket request monitoring |
| Process Access Events | LSASS access detection |

---

# 🟥 Phase 1 — LLMNR/NBT-NS Poisoning Detection Opportunities

## Attack Activity

The attacker leveraged Responder to intercept broadcast-based name resolution requests and capture NTLMv2 authentication material.

## Observable Behaviors

- Abnormal LLMNR traffic
- NBT-NS broadcast responses
- Rogue SMB authentication responses
- Unexpected responder behavior on internal hosts

## Potential Detection Indicators

| Detection Opportunity | Description |
|---|---|
| Unusual LLMNR/NBT-NS traffic | Systems responding to broadcast name queries |
| Rogue SMB service behavior | SMB authentication requests to unauthorized systems |
| Responder fingerprinting | Known Responder traffic patterns |
| Unexpected local network authentication | Authentication attempts to non-standard systems |

## Relevant Monitoring Sources

- Network traffic analysis
- IDS/IPS telemetry
- Windows authentication logs
- Sysmon network activity

## Defensive Considerations

LLMNR and NBT-NS should generally be disabled within enterprise environments unless operationally required.

---

# 🟧 Phase 2 — Credential Validation Detection Opportunities

## Attack Activity

Captured credentials were validated across internal systems using CrackMapExec.

## Observable Behaviors

- Repeated SMB authentication attempts
- Authentication attempts across multiple hosts
- Abnormal logon patterns
- Credential validation behavior

## Potential Detection Indicators

| Detection Opportunity | Description |
|---|---|
| Multiple SMB logons | Authentication attempts across several systems |
| Authentication spraying behavior | Repeated credential testing |
| Logon type anomalies | Unusual network logons |
| Lateral authentication attempts | Same account authenticating to multiple hosts |

## Relevant Event Sources

| Event ID | Purpose |
|---|---|
| 4624 | Successful authentication |
| 4625 | Failed authentication |
| 4648 | Explicit credential usage |

## Defensive Considerations

Monitoring authentication patterns across endpoints can help identify password spraying and credential validation behavior.

---

# 🟨 Phase 3 — Active Directory Enumeration Detection Opportunities

## Attack Activity

BloodHound enumeration was performed to map Active Directory relationships and identify attack paths.

## Observable Behaviors

- LDAP enumeration activity
- Sharp increases in AD object queries
- Group membership enumeration
- ACL relationship collection

## Potential Detection Indicators

| Detection Opportunity | Description |
|---|---|
| Abnormal LDAP query volume | Large-scale directory enumeration |
| Enumeration of privileged groups | Domain Admins, Backup Operators, etc. |
| BloodHound collection behavior | SharpHound/BloodHound-style queries |
| ACL enumeration activity | Object permission analysis |

## Relevant Monitoring Sources

- LDAP monitoring
- PowerShell logging
- Sysmon process creation
- Directory service logs

## Defensive Considerations

Large-scale directory enumeration often precedes privilege escalation attempts and should be treated as suspicious reconnaissance activity.

---

# 🟦 Phase 4 — Remote Execution Attempt Detection Opportunities

## Attack Activity

Remote execution attempts were performed using Impacket tooling including psexec and wmiexec.

## Observable Behaviors

- SMB administrative access attempts
- WMI authentication activity
- Service creation attempts
- Remote execution patterns

## Potential Detection Indicators

| Detection Opportunity | Description |
|---|---|
| ADMIN$ access attempts | Remote administrative authentication |
| Service creation activity | psexec-style execution behavior |
| WMI remote execution | Suspicious WMI usage |
| Authentication from unusual hosts | Lateral movement behavior |

## Relevant Event Sources

| Event ID | Purpose |
|---|---|
| 4624 | Successful network logons |
| 7045 | Service creation |
| Sysmon ID 1 | Process creation |
| Sysmon ID 3 | Network connections |

## Defensive Considerations

Remote administrative execution should be tightly monitored and correlated with authentication activity.

---

# 🟪 Phase 5 — LSASS Credential Dumping Detection Opportunities

## Attack Activity

ProcDump was used to create LSASS memory dumps which were later parsed offline using pypykatz.

## Observable Behaviors

- Access to lsass.exe process memory
- Memory dumping behavior
- Suspicious process access rights
- ProcDump execution

## Potential Detection Indicators

| Detection Opportunity | Description |
|---|---|
| LSASS process access | Unauthorized memory access attempts |
| ProcDump execution | Known credential dumping tooling |
| Suspicious dump file creation | Memory dump artifacts |
| Handle access anomalies | High-privilege process access |

## Relevant Event Sources

| Event ID | Purpose |
|---|---|
| Sysmon ID 1 | Process creation |
| Sysmon ID 10 | Process access |
| Windows Defender alerts | Credential dumping behavior |
| PowerShell logging | Script-based dumping attempts |

## Defensive Considerations

Credential dumping remains one of the highest-value detection opportunities within Windows environments.

Monitoring LSASS access is critical for detecting post-exploitation credential theft activity.

---

# 🟫 Phase 6 — SMB Administrative Access Detection Opportunities

## Attack Activity

Recovered Administrator credentials were used to authenticate against SMB administrative shares on the Domain Controller.

## Observable Behaviors

- Administrative share access
- Remote SMB authentication
- Access to sensitive directories
- Administrative credential usage

## Potential Detection Indicators

| Detection Opportunity | Description |
|---|---|
| ADMIN$ / C$ access | Administrative share usage |
| Remote authentication anomalies | Cross-host administrative access |
| Authentication from workstation to DC | Unusual administrative behavior |
| High-privilege account usage | Administrator account activity |

## Relevant Event Sources

| Event ID | Purpose |
|---|---|
| 4624 | Successful authentication |
| 5140 | Network share access |
| 5145 | Detailed share access |
| Sysmon ID 3 | Network connections |

## Defensive Considerations

Administrative SMB share access should be restricted and closely monitored, especially when involving Domain Controllers.

---

# 🟩 Phase 7 — Kerberoasting Detection Opportunities

## Attack Activity

Kerberos service tickets were requested for SPN-associated service accounts and extracted for offline password cracking.

## Observable Behaviors

- Abnormal Kerberos TGS requests
- Service ticket enumeration
- Increased ticket request volume
- Requests targeting service accounts

## Potential Detection Indicators

| Detection Opportunity | Description |
|---|---|
| High volume TGS requests | Potential Kerberoasting activity |
| Requests for unusual SPNs | Service account targeting |
| RC4 encryption usage | Legacy Kerberos encryption |
| Multiple ticket requests from single host | Enumeration behavior |

## Relevant Event Sources

| Event ID | Purpose |
|---|---|
| 4769 | Kerberos service ticket requests |
| 4624 | Authentication events |
| Sysmon ID 1 | Tool execution visibility |

## Defensive Considerations

Service account hardening and monitoring abnormal TGS requests are critical for reducing Kerberoasting exposure.

---

# 🟥 Phase 8 — NTDS.dit Extraction Detection Opportunities

## Attack Activity

Administrator credentials were used to extract NTDS.dit and retrieve domain credential material using Impacket secretsdump.

## Observable Behaviors

- Domain replication activity
- Access to sensitive AD database files
- DRSUAPI operations
- Credential database extraction behavior

## Potential Detection Indicators

| Detection Opportunity | Description |
|---|---|
| Unusual replication requests | DCSync-style behavior |
| Access to NTDS.dit | Sensitive database interaction |
| secretsdump-related activity | Credential extraction tooling |
| High-volume credential access | Bulk credential exposure attempts |

## Relevant Event Sources

| Event ID | Purpose |
|---|---|
| 4662 | Directory service access |
| 4624 | Authentication events |
| Sysmon ID 1 | Tool execution |
| Directory replication logs | Replication monitoring |

## Defensive Considerations

Domain replication abuse and NTDS extraction activity should be treated as critical-severity security incidents.

---

# 🔄 Attack Correlation Opportunities

One of the most important defensive concepts demonstrated within this lab is attack correlation.

Individually, many attack behaviors may appear benign.

However, when correlated together, they form a highly suspicious attack progression.

## Example Correlation Chain

| Activity | Risk Context |
|---|---|
| LLMNR traffic | Initial credential harvesting |
| Multiple SMB authentications | Credential validation |
| LDAP enumeration | Reconnaissance |
| LSASS access | Credential theft |
| Kerberos TGS requests | Kerberoasting |
| SMB admin access | Lateral movement |
| NTDS extraction | Domain compromise |

Defenders should prioritize behavioral correlation over isolated event analysis.

---

# 🛡️ Defensive Visibility Gaps

The lab intentionally demonstrates several common enterprise visibility limitations.

## Potential Gaps

- Lack of network segmentation
- Insufficient authentication monitoring
- Incomplete endpoint protection
- Weak Kerberos visibility
- Limited lateral movement detection
- Inadequate service account monitoring

These gaps significantly increase attacker freedom of movement within enterprise environments.

---

# 🔐 Recommended Defensive Improvements

## Identity & Authentication Security

- Disable LLMNR & NBT-NS
- Enforce strong password policies
- Implement account lockout protections
- Deploy MFA for privileged accounts

## Endpoint Protection

- Enable LSASS protection
- Deploy EDR solutions
- Restrict administrative tooling
- Monitor process access behavior

## Active Directory Hardening

- Audit service accounts regularly
- Reduce excessive privileges
- Monitor Kerberos ticket anomalies
- Restrict SMB administrative access

## Monitoring & Detection

- Centralize logging
- Enable Sysmon
- Monitor authentication patterns
- Correlate multi-stage attack behaviors
- Implement alert prioritization workflows

---

# 🔗 Related SOC Investigation Project

This document focuses on identifying observable attacker behavior and detection opportunities generated during the attack simulation.

The associated SOC-focused project expands on these concepts through:

- Splunk investigations
- Detection engineering
- Event correlation
- Alert analysis
- Timeline reconstruction
- Threat hunting workflows

➡️ Refer to the companion SOC investigation repository for detailed defensive analysis.

---

# 🚀 Key Takeaways

This lab demonstrates that modern Active Directory attacks frequently generate substantial telemetry when appropriate logging and monitoring controls are implemented.

Key lessons include:

- Credential attacks are highly observable
- Lateral movement produces multiple detectable artifacts
- Kerberos abuse creates valuable detection opportunities
- LSASS access remains a critical monitoring priority
- Multi-stage attacks should be analyzed behaviorally rather than as isolated events
- Effective defense depends heavily on visibility, correlation, and monitoring maturity
