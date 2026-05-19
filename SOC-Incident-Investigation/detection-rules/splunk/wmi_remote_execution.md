# WMI Remote Execution Detection

## 🎯 Purpose

Detect suspicious remote command execution activity performed through Windows Management Instrumentation (WMI).

This detection is designed to identify:

- WMI-based lateral movement
- Remote command execution
- Administrative remote execution abuse
- Post-exploitation activity

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
| Windows Management Instrumentation | T1047 |
| Remote Services | T1021 |

---

# 🔍 Detection Logic

This detection identifies command execution activity spawned through WMI provider processes.

The detection correlates:

- WmiPrvSE.exe activity
- cmd.exe execution
- command-line arguments
- user context
- affected systems

to identify suspicious remote execution behavior associated with lateral movement activity.

---

# ⚠️ False Positives

Potential legitimate sources of activity include:

- SCCM deployments
- Enterprise administration tools
- Remote IT support activity
- Automated management frameworks

Investigation should focus on:
- suspicious command execution
- uncommon user accounts
- unusual execution volume
- administrative command activity

---

# 🛡️ SOC Detection Query

```spl
index=endpoint sourcetype="XmlWinEventLog:Microsoft-Windows-Sysmon/Operational"
("WmiPrvSE.exe" AND "cmd.exe")
| rex field=_raw "<Data Name='Image'>(?<Image>[^<]+)</Data>"
| rex field=_raw "<Data Name='ParentImage'>(?<ParentImage>[^<]+)</Data>"
| rex field=_raw "<Data Name='CommandLine'>(?<CommandLine>[^<]+)</Data>"
| stats count values(CommandLine) as Commands by host ParentImage User
| sort - count
```

---

# 🧠 Analyst Notes

This detection was developed based on WMI-based remote execution behavior observed during the Solaris Active Directory compromise investigation.
