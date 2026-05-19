# Phase 3 — Remote Execution and Lateral Movement

## 🎯 Objective

The objective of this phase was to investigate potential remote execution activity and lateral movement behavior occurring after the reconnaissance activity identified during earlier investigation phases.

The investigation focused on identifying:

- Remote command execution
- WMI-based execution activity
- Administrative share usage
- Privileged remote authentication
- Indicators of lateral movement
- Evidence of attacker-controlled remote administration activity

---

# 🔍 Investigation Scope

The investigation analyzed Sysmon and Windows Security telemetry associated with suspicious remote administration behavior targeting:

- SOLARIS-DC-01

Particular attention was given to activity involving:

```text
192.168.10.250
```

which was previously identified as the attacker-controlled Kali Linux system used during the simulated adversary activity.

---

# 📊 Telemetry Sources

| Source | Purpose |
|---|---|
| Sysmon Event ID 1 | Process creation and execution telemetry |
| Windows Security Logs | Authentication and logon correlation |
| Splunk SIEM | Event aggregation, parsing, and correlation |

---

# 🔐 Relevant Windows Event IDs

| Event ID | Description |
|---|---|
| Sysmon Event ID 1 | Process creation |
| 4624 | Successful logon |

---

# 🧠 Investigation Methodology

The investigation followed a structured lateral movement analysis workflow:

1. Identify suspicious remote authentication activity
2. Investigate privileged network logons
3. Analyze remote process execution telemetry
4. Correlate WMI parent-child process relationships
5. Investigate ADMIN$ share usage
6. Assess indicators of remote administration tooling

---

# 🌐 Remote Execution Focus Areas

The investigation focused on identifying behaviors commonly associated with:

- Impacket wmiexec.py
- WMI-based remote execution
- SMB administrative share access
- Remote shell activity
- Administrative remote command execution

Particular attention was given to:

- `WmiPrvSE.exe`
- `cmd.exe`
- `ADMIN$`
- privileged authentication activity

These artifacts frequently appear during Windows-based lateral movement operations.

---

# ⚠️ Investigation Notes

The investigation identified high-confidence evidence of remote execution activity involving:

```text
C:\Windows\System32\wbem\WmiPrvSE.exe
```

spawning:

```text
C:\Windows\System32\cmd.exe
```

with associated:

```text
ADMIN$
```

artifacts and remote shell execution behavior.

The observed telemetry strongly aligned with known Impacket wmiexec.py behavioral patterns frequently observed during adversary lateral movement operations.

---

# 🔗 Investigation Progression

The remote execution activity identified during this phase significantly increased confidence that the earlier authentication and reconnaissance activity represented active adversary behavior within the environment.

The findings established a clear progression toward later investigation phases involving:

- credential access
- LSASS memory dumping
- Kerberoasting
- privileged domain compromise
