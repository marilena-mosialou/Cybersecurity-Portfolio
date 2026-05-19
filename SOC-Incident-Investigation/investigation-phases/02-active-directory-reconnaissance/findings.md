# Active Directory Reconnaissance Findings

## 🚨 Summary of Findings

The investigation identified Active Directory reconnaissance activity associated with the account:

```text
p.olson
```

The observed activity involved enumeration of privileged and remote access-related groups within the environment.

Windows Security telemetry revealed multiple Event ID 4799 events associated with group membership enumeration activity.

---

# 🔍 Key Observations

## Privilege-Oriented Group Enumeration

The investigation identified enumeration involving the following groups:

- Administrators
- Remote Desktop Users
- Remote Management Users
- Distributed COM Users

These groups are frequently targeted during attacker reconnaissance because they provide visibility into:

- privileged access
- remote administration capabilities
- lateral movement opportunities
- remote execution paths

---

# 🖥️ Enumeration Process Activity

The investigation identified execution of:

```text
C:\Windows\System32\net1.exe
```

during the enumeration activity.

This process is commonly associated with Windows command-line reconnaissance and administrative enumeration activity.

Additional RuntimeBroker.exe process activity was also observed during the investigation, although the exact relationship to attacker-controlled activity could not be conclusively verified.

---

# 🌐 Reconnaissance Correlation Analysis

Correlation analysis demonstrated that the account:

```text
p.olson
```

performed repeated enumeration activity involving privileged and remote administration-related groups.

The observed reconnaissance behavior strongly aligned with attacker objectives commonly associated with:

- privilege discovery
- remote access discovery
- lateral movement preparation
- administrative access assessment

---

# 🧠 Analyst Assessment

The reconnaissance activity identified during this phase significantly increased confidence that the authentication activity observed during Phase 1 was associated with malicious behavior rather than legitimate administrative activity.

Several factors elevated the investigation severity:

- enumeration of privileged groups
- discovery of remote access capabilities
- repeated enumeration activity
- command-line based reconnaissance behavior
- correlation with prior suspicious authentication activity

The use of:

```text
net1.exe
```

provided particularly strong evidence of deliberate enumeration activity within the environment.

---

# ⚠️ Investigation Limitations

Several telemetry limitations were identified during the investigation:

- incomplete process correlation telemetry
- limited command-line visibility
- inconsistent Sysmon field parsing
- incomplete attribution for RuntimeBroker.exe activity

Despite these limitations, sufficient telemetry existed to identify high-confidence Active Directory reconnaissance activity associated with the investigated account.

---

# 🎯 Conclusion

The investigation identified high-confidence Active Directory reconnaissance activity associated with the account:

```text
p.olson
```

The combination of:

- privileged group enumeration,
- remote access discovery,
- command-line enumeration activity,
- and correlation with earlier suspicious authentication events

provided strong evidence of adversary reconnaissance behavior and lateral movement preparation within the Active Directory environment.
