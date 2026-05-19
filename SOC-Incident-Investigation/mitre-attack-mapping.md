# MITRE ATT&CK Mapping

## 🎯 Overview

This document maps adversary behaviors identified during the Solaris Active Directory compromise investigation to the MITRE ATT&CK framework.

The mapping demonstrates how telemetry observed throughout the investigation aligns with known adversary tactics, techniques, and procedures (TTPs) commonly associated with Active Directory compromise activity.

The investigation reconstructed a multi-stage attack lifecycle involving:

- remote authentication activity
- domain reconnaissance
- lateral movement
- credential dumping
- Kerberos abuse
- privileged domain compromise behavior

The ATT&CK mappings throughout this document are based on evidence identified through:

- Windows Security Logs
- Sysmon telemetry
- Splunk SIEM correlation
- authentication analysis
- endpoint telemetry investigation

---

# 🧠 ATT&CK Tactic Overview

| ATT&CK Tactic | Description |
|---|---|
| Initial Access | Unauthorized access into the environment |
| Discovery | Reconnaissance and environment enumeration |
| Lateral Movement | Remote execution and host-to-host movement |
| Credential Access | Credential theft and Kerberos abuse |
| Privilege Escalation | Elevated access and privileged authentication |
| Defense Evasion | Reduced telemetry visibility and stealth behavior |

---

# 🔐 Initial Access and Authentication Activity

## Technique: Valid Accounts

| Field | Value |
|---|---|
| ATT&CK ID | T1078 |
| Tactic | Initial Access |
| Investigation Phase | Authentication Correlation Analysis |

### Observed Behavior

The investigation identified repeated successful remote network authentication activity originating from the attacker-controlled system.

Observed indicators included:

- Logon Type 3 authentication
- cross-host authentication activity
- administrative account authentication
- service account usage

### Relevant Telemetry

| Source | Event |
|---|---|
| Windows Security Logs | Event ID 4624 |
| Windows Security Logs | Event ID 4672 |

### Detection Opportunities

- abnormal authentication volume
- privileged account monitoring
- cross-host authentication correlation
- suspicious Logon Type 3 activity

---

# 🔎 Discovery Activity

## Technique: Permission Groups Discovery

| Field | Value |
|---|---|
| ATT&CK ID | T1069 |
| Tactic | Discovery |
| Investigation Phase | Domain Enumeration Analysis |

### Observed Behavior

The compromised account performed enumeration of privileged local groups within the Active Directory environment.

Enumerated groups included:

- Administrators
- Remote Desktop Users
- Remote Management Users
- Distributed COM Users

### Relevant Telemetry

| Source | Event |
|---|---|
| Windows Security Logs | Event ID 4799 |

### Associated Processes

- net1.exe
- RuntimeBroker.exe

### Detection Opportunities

- repeated group enumeration
- privileged group targeting
- suspicious discovery activity
- abnormal enumeration behavior

---

# 🌐 Lateral Movement Activity

## Technique: Windows Management Instrumentation

| Field | Value |
|---|---|
| ATT&CK ID | T1047 |
| Tactic | Lateral Movement |
| Investigation Phase | WMI Lateral Movement Analysis |

### Observed Behavior

The investigation identified WMI-based remote command execution activity associated with lateral movement behavior.

Observed indicators included:

- WmiPrvSE.exe spawning cmd.exe
- ADMIN$ share references
- remote command execution behavior
- administrative remote execution activity

### Relevant Telemetry

| Source | Event |
|---|---|
| Sysmon | Event ID 1 |
| Windows Security Logs | Event ID 4624 |

### Detection Opportunities

- WMI provider process monitoring
- suspicious parent-child relationships
- remote shell execution
- ADMIN$ activity monitoring

---

## Technique: SMB/Windows Admin Shares

| Field | Value |
|---|---|
| ATT&CK ID | T1021.002 |
| Tactic | Lateral Movement |
| Investigation Phase | WMI Lateral Movement Analysis |

### Observed Behavior

Remote administrative shares were used during remote execution activity.

Observed indicators included:

- ADMIN$ references
- remote authentication activity
- SMB administrative behavior
- cross-host command execution

### Relevant Telemetry

| Source | Event |
|---|---|
| Sysmon | Event ID 1 |
| Windows Security Logs | Event ID 4624 |

### Detection Opportunities

- administrative share monitoring
- suspicious SMB activity
- remote execution correlation
- authentication-to-process correlation

---

# 🔑 Credential Access Activity

## Technique: OS Credential Dumping — LSASS Memory

| Field | Value |
|---|---|
| ATT&CK ID | T1003.001 |
| Tactic | Credential Access |
| Investigation Phase | Credential Dumping Analysis |

### Observed Behavior

The investigation identified suspicious LSASS memory access activity associated with credential dumping behavior.

Observed indicators included:

- ProcDump execution
- suspicious LSASS access
- high privilege handle access
- credential dumping artifacts

### Relevant Telemetry

| Source | Event |
|---|---|
| Sysmon | Event ID 10 |
| Sysmon | Event ID 1 |

### Associated Tools

- procdump64.exe
- mimikatz.exe

### Detection Opportunities

- LSASS access monitoring
- suspicious process access
- credential dumping analytics
- memory dumping detection

---

## Technique: Kerberoasting

| Field | Value |
|---|---|
| ATT&CK ID | T1558.003 |
| Tactic | Credential Access |
| Investigation Phase | Kerberos Abuse Analysis |

### Observed Behavior

The investigation identified suspicious RC4-encrypted Kerberos service ticket requests targeting privileged service accounts.

Observed indicators included:

- RC4 Kerberos encryption
- service account targeting
- repeated TGS requests
- Kerberos abuse behavior

### Relevant Telemetry

| Source | Event |
|---|---|
| Windows Security Logs | Event ID 4769 |

### Detection Opportunities

- RC4 Kerberos monitoring
- service account analytics
- abnormal TGS request volume
- Kerberos anomaly detection

---

# 👑 Privileged Domain Compromise Activity

## Technique: Steal or Forge Kerberos Tickets

| Field | Value |
|---|---|
| ATT&CK ID | T1558 |
| Tactic | Credential Access |
| Investigation Phase | Domain Compromise Assessment |

### Observed Behavior

The investigation identified repeated privileged authentication activity involving administrative and service accounts following credential access operations.

Observed indicators included:

- privileged account authentication
- repeated remote administrative logons
- service account activity
- lateral movement into the Domain Controller

### Relevant Telemetry

| Source | Event |
|---|---|
| Windows Security Logs | Event ID 4624 |
| Windows Security Logs | Event ID 4672 |
| Windows Security Logs | Event ID 4769 |

### Detection Opportunities

- privileged authentication monitoring
- service account baselining
- administrative logon correlation
- post-compromise authentication analysis

---

# 🧩 Attack Lifecycle Correlation

## Reconstructed Adversary Workflow

The investigation reconstructed the following high-confidence attack progression:

1. Remote authentication activity identified
2. Privileged group enumeration performed
3. WMI-based lateral movement initiated
4. Administrative shares abused
5. LSASS credential dumping activity detected
6. Kerberos service ticket abuse observed
7. Privileged domain authentication activity identified

---

# 📊 ATT&CK Technique Summary

| ATT&CK ID | Technique | Tactic |
|---|---|---|
| T1078 | Valid Accounts | Initial Access |
| T1069 | Permission Groups Discovery | Discovery |
| T1047 | Windows Management Instrumentation | Lateral Movement |
| T1021.002 | SMB/Windows Admin Shares | Lateral Movement |
| T1003.001 | OS Credential Dumping: LSASS Memory | Credential Access |
| T1558.003 | Kerberoasting | Credential Access |
| T1558 | Steal or Forge Kerberos Tickets | Credential Access |

---

# 🧠 Defensive Visibility Summary

The investigation demonstrated the importance of correlating:

- authentication telemetry
- endpoint process activity
- Kerberos authentication events
- process access telemetry
- remote execution behavior

to successfully reconstruct complex Active Directory compromise activity.

The ATT&CK mapping also highlighted how:

- endpoint telemetry,
- behavioral analytics,
- and cross-source correlation

significantly improve SOC detection engineering and investigative effectiveness.

---

# 🎯 Final Assessment

The Solaris Active Directory compromise investigation successfully mapped multiple adversary behaviors to the MITRE ATT&CK framework using evidence reconstructed through Splunk SIEM analysis and endpoint telemetry correlation.

The investigation demonstrated practical blue-team methodology involving:

- ATT&CK-aligned investigation workflows
- detection engineering principles
- behavioral analytics
- authentication correlation
- endpoint-focused investigation techniques

The ATT&CK mappings throughout this project provide a structured representation of the adversary behaviors identified during the simulated enterprise compromise lifecycle.
