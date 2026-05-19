# Phase 5 — Kerberos Abuse and Service Account Analysis

## 🎯 Objective

The objective of this phase was to investigate suspicious Kerberos service ticket activity within the Active Directory environment.

The investigation focused on identifying:

- Kerberos Service Ticket Requests (TGS)
- Service account targeting activity
- RC4-encrypted Kerberos tickets
- Suspicious Kerberos authentication behavior
- Kerberoasting-related indicators
- Correlation between Kerberos activity and previously identified attacker infrastructure

---

# 🔍 Investigation Scope

The analysis focused on Kerberos authentication telemetry associated with suspicious activity originating from:

```text
192.168.10.250
```

This system was previously identified as the Kali Linux host used during the simulated adversary activity inside the lab environment.

Primary systems investigated:

- SOLARIS-DC-01
- SOLARIS-PC-01

Primary accounts investigated:

- Administrator
- svc_backup

---

# 📊 Telemetry Sources

| Source | Purpose |
|---|---|
| Windows Security Logs | Kerberos authentication monitoring |
| Splunk SIEM | Event aggregation, correlation, and investigation |
| Sysmon | Supplemental endpoint visibility |

---

# 🔐 Relevant Windows Event IDs

| Event ID | Description |
|---|---|
| 4769 | Kerberos Service Ticket Request |

---

# 🧠 Investigation Methodology

The Kerberos investigation followed a structured SOC-oriented workflow:

1. Identify Kerberos service ticket requests
2. Correlate requests by client source address
3. Analyze targeted service accounts
4. Investigate Kerberos encryption types
5. Identify RC4-encrypted ticket activity
6. Correlate Kerberos activity with previous investigation phases
7. Assess indicators of Kerberoasting-related behavior

---

# 🌐 Kerberos Investigation Focus Areas

Particular attention was given to:

- Event ID 4769 Kerberos activity
- RC4 (`0x17`) Kerberos encryption usage
- Service ticket requests targeting `svc_backup`
- Kerberos requests originating from `192.168.10.250`
- Administrative account activity
- Cross-phase attacker infrastructure correlation

These behaviors are commonly associated with:

- Kerberoasting
- Credential access operations
- Service account targeting
- Privilege escalation preparation
- Lateral movement activity

---

# ⚠️ Investigation Notes

The investigation identified Kerberos service ticket requests associated with the `svc_backup` service account using RC4 encryption (`0x17`).

RC4-encrypted Kerberos tickets are significant because they are commonly targeted during Kerberoasting operations due to their susceptibility to offline password cracking.

The Kerberos activity correlated with:

- Suspicious authentication activity
- Administrative remote access
- WMI-based remote execution
- LSASS credential dumping activity

This multi-phase correlation significantly increased confidence that the observed Kerberos activity was associated with adversary behavior inside the environment.

---

# 🔗 Investigation Progression

The Kerberos analysis expanded the investigation into:

- Service account abuse
- Credential access activity
- Kerberoasting behavior
- Privileged account targeting
- Domain compromise activity
