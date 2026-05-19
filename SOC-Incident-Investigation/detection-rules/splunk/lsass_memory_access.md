# LSASS Memory Access Detection

## 🎯 Purpose

Detect suspicious access attempts against the LSASS process commonly associated with credential dumping activity.

This detection is designed to identify:

- Credential dumping activity
- LSASS memory access
- Mimikatz behavior
- ProcDump execution
- Post-exploitation credential theft

---

# 📊 Data Source

| Source | Details |
|---|---|
| Sysmon Operational Logs | Process access telemetry |
| Sysmon Event IDs | 10 |

---

# 🧠 ATT&CK Mapping

| Technique | ATT&CK ID |
|---|---|
| OS Credential Dumping: LSASS Memory | T1003.001 |

---

# 🔍 Detection Logic

This detection identifies processes requesting access to `lsass.exe` using suspicious access rights commonly associated with credential dumping activity.

The detection correlates:

- source processes
- access rights
- user context
- LSASS access activity

to identify credential theft behavior associated with post-exploitation operations.

---

# ⚠️ False Positives

Potential legitimate sources of activity include:

- EDR solutions
- Antivirus platforms
- Authorized debugging tools
- Security monitoring products

Investigation should focus on:
- unusual source processes
- suspicious access rights
- administrative user context
- repeated LSASS access behavior

---

# 🛡️ SOC Detection Query

```spl
index=endpoint sourcetype="XmlWinEventLog:Microsoft-Windows-Sysmon/Operational"
"<EventID>10</EventID>"
"lsass.exe"
NOT "Sysmon64.exe"
NOT "csrss.exe"
NOT "wininit.exe"
NOT "WindowsPackageManagerServer.exe"
| rex field=_raw "<Data Name='SourceImage'>(?<SourceImage>[^<]+)</Data>"
| rex field=_raw "<Data Name='TargetImage'>(?<TargetImage>[^<]+)</Data>"
| rex field=_raw "<Data Name='GrantedAccess'>(?<GrantedAccess>[^<]+)</Data>"
| rex field=_raw "<Data Name='SourceUser'>(?<SourceUser>[^<]+)</Data>"
| stats count values(GrantedAccess) as AccessRights by SourceImage SourceUser
| where count > 0
| sort - count
```

---

# 🧠 Analyst Notes

This detection was developed from LSASS credential dumping behavior observed during the Solaris Active Directory compromise investigation involving Mimikatz and ProcDump activity.
