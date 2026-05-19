# Suspicious Remote Authentication Activity

## 🎯 Purpose

Detect repeated remote network authentication activity originating from a single source system against multiple hosts within the environment.

This detection is designed to identify behavior commonly associated with:

- Lateral movement
- SMB authentication abuse
- Credential validation
- Unauthorized remote access activity
- Early-stage intrusion activity

---

# 📊 Data Source

| Source | Details |
|---|---|
| Windows Security Logs | Authentication telemetry |
| Event IDs | 4624, 4625 |

---

# 🧠 ATT&CK Mapping

| Technique | ATT&CK ID |
|---|---|
| SMB/Windows Admin Shares | T1021.002 |
| Valid Accounts | T1078 |

---

# 🔍 Detection Logic

This detection identifies repeated successful and failed Logon Type 3 network authentication activity associated with the same source system.

The detection correlates:

- source IP addresses
- targeted systems
- authentication volume
- associated accounts

to identify suspicious remote authentication behavior across multiple hosts.

---

# ⚠️ False Positives

Potential legitimate sources of activity include:

- Remote administration platforms
- Vulnerability scanners
- Backup infrastructure
- Enterprise monitoring systems
- IT support operations

Investigation should focus on:
- unusual authentication volume
- uncommon source systems
- administrative account usage
- cross-host authentication patterns

---

# 🛡️ SOC Detection Query

```spl
index=endpoint sourcetype="WinEventLog:Security"
(EventCode=4624 OR EventCode=4625)
Logon_Type=3
| stats count values(EventCode) as EventCodes values(ComputerName) as TargetHosts by Source_Network_Address Account_Name
| where count > 5
| rename Source_Network_Address as SourceIP
| sort - count
```

---

# 🧠 Analyst Notes

This detection is intended as a generalized SOC analytic rather than an investigation-specific query.

The detection logic was developed based on authentication behavior observed during the Solaris Active Directory compromise investigation.
