# Phase 2 — Active Directory Reconnaissance

## 🎯 Objective

The objective of this phase was to investigate potential Active Directory reconnaissance activity performed after the initial suspicious authentication events identified during Phase 1.

The investigation focused on identifying:

- Group membership enumeration
- Privilege discovery activity
- Remote access capability discovery
- Administrative group reconnaissance
- Indicators of lateral movement preparation

---

# 🔍 Investigation Scope

The investigation analyzed Windows Security telemetry associated with suspicious enumeration activity involving:

```text
p.olson
```

This account was previously observed during suspicious remote authentication activity originating from:

```text
192.168.10.250
```

which was later identified as the attacker-controlled Kali Linux system used during the simulated adversary activity.

---

# 📊 Telemetry Sources

| Source | Purpose |
|---|---|
| Windows Security Logs | Group enumeration and authentication telemetry |
| Splunk SIEM | Event aggregation and correlation |
| Sysmon | Supplemental endpoint visibility |

---

# 🔐 Relevant Windows Event IDs

| Event ID | Description |
|---|---|
| 4799 | Security-enabled local group membership enumeration |
| 4624 | Successful authentication events |

---

# 🧠 Investigation Methodology

The investigation followed a structured reconnaissance analysis workflow:

1. Identify suspicious enumeration activity
2. Correlate enumerated groups
3. Investigate processes associated with enumeration
4. Identify privilege-related discovery activity
5. Assess indicators of lateral movement preparation
6. Correlate findings with earlier authentication activity

---

# 🌐 Reconnaissance Focus Areas

Particular attention was given to enumeration involving:

- Administrators
- Remote Desktop Users
- Remote Management Users
- Distributed COM Users

These groups are frequently targeted during Active Directory reconnaissance because they provide visibility into:

- privileged access
- remote administration capabilities
- lateral movement opportunities
- remote execution paths

---

# ⚠️ Investigation Notes

The investigation identified clear evidence of group membership enumeration activity associated with the account:

```text
p.olson
```

Process telemetry revealed the use of:

```text
C:\Windows\System32\net1.exe
```

which is commonly associated with Windows command-line enumeration activity.

Additional process activity involving:

```text
RuntimeBroker.exe
```

was also observed during the investigation, although the relationship to direct attacker-controlled enumeration activity could not be conclusively verified.

---

# 🔗 Investigation Progression

The reconnaissance activity identified during this phase significantly increased confidence that the suspicious authentication activity observed during Phase 1 was associated with adversary behavior rather than legitimate administrative activity.

The findings established a clear progression toward later investigation phases involving:

- remote execution activity
- credential access
- lateral movement
- privileged domain compromise
