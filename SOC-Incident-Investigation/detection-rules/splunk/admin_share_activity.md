# ADMIN$ Remote Share Activity Detection

## 🎯 Purpose

Detect suspicious usage of Windows administrative shares commonly associated with remote execution and lateral movement activity.

This detection is designed to identify:

- ADMIN$ share usage
- Remote payload staging
- Lateral movement activity
- Administrative share abuse

---

# 📊 Data Source

| Source | Details |
|---|---|
| Sysmon Operational Logs | Process creation telemetry |
| Sysmon Event IDs | 1 |

---

# 🧠 ATT&CK Mapping

| Technique | ATT&CK ID |
|---|---|
| SMB/Windows Admin Shares | T1021.002 |

---

# 🔍 Detection Logic

This detection identifies command execution activity referencing the ADMIN$ administrative share.

The detection correlates:

- ADMIN$ references
- command-line activity
- user context
- affected systems

to identify suspicious remote administrative share usage associated with adversary lateral movement behavior.

---

# ⚠️ False Positives

Potential legitimate sources of activity include:

- Remote administration activity
- Software deployment systems
- Patch management platforms
- Enterprise automation tools

Investigation should focus on:
- unusual command execution
- suspicious administrative activity
- uncommon account usage
- abnormal remote share behavior

---

# 🛡️ SOC Detection Query

```spl
index=endpoint sourcetype="XmlWinEventLog:Microsoft-Windows-Sysmon/Operational"
"ADMIN$"
| rex field=_raw "<Data Name='Image'>(?<Image>[^<]+)</Data>"
| rex field=_raw "<Data Name='CommandLine'>(?<CommandLine>[^<]+)</Data>"
| rex field=_raw "<Data Name='User'>(?<User>[^<]+)</Data>"
| stats count values(CommandLine) as Commands by host User
| where count > 2
| sort - count
```

---

# 🧠 Analyst Notes

This detection was developed from ADMIN$ share activity observed during WMI-based remote execution behavior within the Solaris Active Directory compromise investigation.
