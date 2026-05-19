# Active Directory Reconnaissance Detection Logic

## 🎯 Detection Goal

Identify reconnaissance activity associated with privilege discovery, group enumeration, and lateral movement preparation within the Active Directory environment.

---

# 🔎 Detection 1 — Group Membership Enumeration Activity

## Purpose

Identify suspicious enumeration of security-enabled local groups associated with remote access and privileged administration.

## Splunk Search

```spl
index=endpoint EventCode=4799 "p.olson"
| table _time Group_Name Process_Name Message
| sort _time
```

## Detection Logic

This detection focuses on Windows Security Event ID 4799, which is generated when security-enabled local group membership is enumerated.

The investigation specifically identified enumeration involving:

- Administrators
- Remote Desktop Users
- Remote Management Users
- Distributed COM Users

These groups are frequently targeted during attacker reconnaissance because they reveal:

- privileged users
- remote administration access
- lateral movement paths
- remote execution opportunities

---

# 📌 Key Indicators Observed

| Indicator | Observation |
|---|---|
| Account | p.olson |
| Enumeration Process | C:\Windows\System32\net1.exe |
| Additional Process Activity | RuntimeBroker.exe |
| Enumerated Groups | Administrators, Remote Desktop Users, Remote Management Users, Distributed COM Users |

---

# 🧠 Analyst Notes

The presence of:

```text
C:\Windows\System32\net1.exe
```

provided strong evidence of command-line based group enumeration activity.

The observed enumeration behavior strongly aligned with attacker reconnaissance techniques commonly used to:

- identify privileged access
- discover remote administration capabilities
- assess lateral movement opportunities
- identify high-value systems and accounts

Additional RuntimeBroker.exe activity was observed during the investigation, although the exact relationship to attacker-controlled enumeration activity could not be conclusively validated.

---

# 🔎 Detection 2 — Enumeration Correlation Analysis

## Purpose

Correlate group enumeration activity, associated processes, and account behavior to assess reconnaissance scope.

## Splunk Search

```spl
index=endpoint EventCode=4799
| stats values(Group_Name) as EnumeratedGroups values(Process_Name) as Processes count by Account_Name
| where Account_Name="p.olson"
```

## Detection Logic

This correlation search aggregates:

- enumerated groups
- associated processes
- enumeration event frequency

to reconstruct the scope of reconnaissance activity associated with the investigated account.

---

# 📌 Correlated Findings

| Category | Findings |
|---|---|
| Enumerated Groups | Administrators, Remote Desktop Users, Remote Management Users, Distributed COM Users |
| Processes Observed | net1.exe, RuntimeBroker.exe |
| Enumeration Activity | Multiple group membership enumeration events |

---

# 🛡️ Detection Opportunities

| Activity | Detection Opportunity |
|---|---|
| Group membership enumeration | Event ID 4799 |
| Privilege discovery | Enumeration of Administrators group |
| Remote access discovery | Enumeration of RDP and WinRM groups |
| Command-line reconnaissance | net.exe / net1.exe process activity |
| Lateral movement preparation | Enumeration of remote management capabilities |

---

# ⚠️ Potential False Positives

| Activity | Possible Legitimate Cause |
|---|---|
| Group enumeration | Legitimate administrative activity |
| net1.exe usage | Helpdesk or IT administration |
| Remote access group queries | System management or troubleshooting |

However, the correlation of:

- suspicious authentication activity,
- remote network logons,
- and privilege-oriented enumeration behavior

significantly increased the likelihood of malicious reconnaissance activity.

---

# 🧠 MITRE ATT&CK Mapping

| Technique | ATT&CK ID |
|---|---|
| Account Discovery | T1087 |
| Permission Groups Discovery | T1069 |
| Remote System Discovery | T1018 |
| System Owner/User Discovery | T1033 |
