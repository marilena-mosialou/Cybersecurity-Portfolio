# Phase 1 — Authentication Analysis

## 🎯 Objective

The objective of this phase was to identify suspicious authentication activity associated with potential credential abuse within the Active Directory environment.

The investigation focused on analyzing Windows authentication telemetry to identify:

- Failed authentication attempts
- Successful remote logons
- Suspicious logon patterns
- Authentication attempts originating from attacker-controlled infrastructure
- Evidence of lateral authentication activity

---

# 🔍 Investigation Scope

The analysis focused primarily on:

- Windows Security Event Logs
- Authentication-related Event IDs
- Source IP correlation
- Logon type analysis
- Cross-host authentication behavior

Primary systems investigated:

- SOLARIS-DC-01
- SOLARIS-PC-01

Suspected attacker source:

- 192.168.10.250 (Kali Linux)

---

# 📊 Telemetry Sources

| Source | Purpose |
|---|---|
| Windows Security Logs | Authentication monitoring |
| Splunk SIEM | Event correlation and investigation |
| Sysmon | Supplemental endpoint visibility |

---

# 🧠 Investigation Methodology

The authentication analysis followed a structured SOC investigation workflow:

1. Identify failed authentication attempts
2. Correlate successful logons
3. Analyze logon types
4. Investigate source IP behavior
5. Correlate authentication activity across hosts
6. Assess potential credential abuse indicators

---

# 🔐 Relevant Windows Event IDs

| Event ID | Description |
|---|---|
| 4624 | Successful logon |
| 4625 | Failed logon |
| 4648 | Explicit credential logon |
| 4672 | Special privileges assigned |

---

# ⚠️ Investigation Focus

Particular attention was given to:

- Logon Type 3 network logons
- Repeated failed authentication attempts
- Administrative account usage
- Authentication events originating from non-standard systems
- Cross-system authentication correlation

These behaviors are commonly associated with:

- Password spraying
- Credential validation
- SMB authentication abuse
- Lateral movement preparation
- Remote administrative access attempts
