# Suspicious Local Group Enumeration Activity

## 🎯 Purpose

Detect local group enumeration activity commonly associated with attacker reconnaissance and privilege assessment behavior.

This detection is designed to identify:

- Privileged group enumeration
- Local group discovery
- Reconnaissance activity
- Permission assessment behavior

---

# 📊 Data Source

| Source | Details |
|---|---|
| Windows Security Logs | Group enumeration telemetry |
| Event IDs | 4799 |

---

# 🧠 ATT&CK Mapping

| Technique | ATT&CK ID |
|---|---|
| Permission Groups Discovery | T1069 |

---

# 🔍 Detection Logic

This detection identifies repeated enumeration of security-enabled local groups performed by user accounts.

The detection correlates:

- enumerated groups
- associated processes
- user accounts
- affected systems

to identify suspicious reconnaissance behavior commonly associated with adversary discovery activity.

---

# ⚠️ False Positives

Potential legitimate sources of activity include:

- IT administration tools
- Asset inventory platforms
- Endpoint management software
- System auditing utilities

Investigation should focus on:
- privileged group targeting
- unusual enumeration volume
- suspicious user accounts
- uncommon process execution

---

# 🛡️ SOC Detection Query

```spl
index=endpoint sourcetype="WinEventLog:Security"
EventCode=4799
| stats count values(Group_Name) as EnumeratedGroups values(Process_Name) as Processes by Account_Name ComputerName
| where count > 3
| sort - count
```

---

# 🧠 Analyst Notes

This detection was developed from local group enumeration activity observed during the Solaris Active Directory compromise investigation involving privilege assessment and reconnaissance behavior.
