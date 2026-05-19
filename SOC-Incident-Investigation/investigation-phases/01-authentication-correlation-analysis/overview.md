# Phase 1 — Authentication Correlation Analysis

## 🎯 Objective

The objective of this phase was to identify and correlate suspicious remote authentication activity within the Active Directory environment.

The investigation focused on identifying:

- Successful remote network logons
- Cross-host authentication activity
- Administrative account authentication
- Service account authentication
- Potential unauthorized remote access behavior
- Early indicators of lateral movement preparation

---

# 🔍 Investigation Scope

The analysis focused on Windows authentication telemetry generated during suspicious remote access activity originating from:

```text
192.168.10.250
```

This system was later identified as the Kali Linux host used during the simulated adversary activity inside the lab environment.

Primary systems investigated:

- SOLARIS-DC-01
- SOLARIS-PC-01

---

# 📊 Telemetry Sources

| Source | Purpose |
|---|---|
| Windows Security Logs | Authentication telemetry and logon monitoring |
| Splunk SIEM | Event aggregation, correlation, and investigation |
| Sysmon | Supplemental endpoint visibility |

---

# 🔐 Relevant Windows Event IDs

| Event ID | Description |
|---|---|
| 4624 | Successful logon |
| 4672 | Special privileges assigned to new logon |

---

# 🧠 Investigation Methodology

The authentication investigation followed a structured SOC-oriented workflow:

1. Identify remote authentication activity
2. Correlate authentication events by source IP
3. Analyze Logon Type 3 network logons
4. Investigate authentication activity across multiple systems
5. Identify privileged and service account usage
6. Assess indicators of unauthorized access activity

---

# 🌐 Authentication Focus Areas

Particular attention was given to:

- Logon Type 3 network authentication events
- Authentication activity originating from 192.168.10.250
- Cross-system authentication behavior
- Administrative account usage
- Service account authentication
- Potential SMB-based remote access activity

These behaviors are commonly associated with:

- Credential validation
- Remote administration
- SMB authentication abuse
- Lateral movement preparation
- Unauthorized domain access

---

# ⚠️ Investigation Notes

The investigation primarily identified successful remote authentication activity rather than failed authentication attempts.

This behavior is consistent with attackers operating with already valid credentials or previously compromised accounts, reducing the need for brute-force or password spraying activity.

At this stage of the investigation, the authentication activity was considered suspicious but not yet sufficient to independently confirm malicious compromise.

Later investigation phases involving:

- WMI-based remote execution
- Credential dumping
- Kerberoasting
- Domain compromise activity

provided additional evidence confirming adversary activity within the environment.

---

# 🔗 Investigation Progression

The authentication analysis established the foundation for subsequent investigation phases focused on:

- Domain enumeration
- Lateral movement
- Credential access
- Kerberos abuse
- Privileged domain compromise
