# Credential Access and LSASS Dumping Detection Logic

## 🎯 Detection Goal

Identify credential dumping activity and suspicious LSASS memory access behavior associated with post-exploitation credential theft operations.

---

# 🔎 Detection 1 — ProcDump Execution Evidence

## Purpose

Identify execution of ProcDump and LSASS dump creation activity.

## Splunk Search

```spl
index=endpoint sourcetype="XmlWinEventLog:Microsoft-Windows-Sysmon/Operational"
("procdump64.exe" OR "lsass.dmp")
| rex field=_raw "<Data Name='Image'>(?<Image>[^<]+)</Data>"
| rex field=_raw "<Data Name='CommandLine'>(?<CommandLine>[^<]+)</Data>"
| rex field=_raw "<Data Name='ParentImage'>(?<ParentImage>[^<]+)</Data>"
| rex field=_raw "<Data Name='User'>(?<User>[^<]+)</Data>"
| table _time host Image CommandLine ParentImage User
| sort _time
```

## Detection Logic

This detection focuses on identifying:

- ProcDump execution
- LSASS dump command-line arguments
- suspicious dump file creation
- PowerShell-assisted execution
- credential dumping tooling staged within user-accessible directories

The investigation identified execution of:

```text
procdump64.exe -accepteula -ma lsass.exe
```

which strongly aligned with credential dumping activity targeting LSASS memory.

---

# 📌 Key Indicators Observed

| Indicator | Observation |
|---|---|
| Dumping Utility | procdump64.exe |
| Target Process | lsass.exe |
| Dump Artifact | lsass.dmp |
| Parent Process | powershell.exe |
| Execution Context | Administrative user context |

---

# 🧠 Analyst Notes

The observed command-line arguments strongly indicated deliberate LSASS memory dumping behavior rather than legitimate administrative troubleshooting activity.

The staging of tooling within:

```text
C:\Users\Public\
```

also aligned with common attacker operational behavior.

---

# 🔎 Detection 2 — LSASS Process Access Detection

## Purpose

Identify suspicious process access attempts targeting LSASS memory.

## Splunk Search

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
| table _time host SourceImage TargetImage GrantedAccess SourceUser
| sort _time
```

## Detection Logic

This detection focuses on identifying:

- suspicious LSASS process access
- credential dumping behavior
- memory access rights associated with credential theft
- suspicious post-exploitation tooling interaction with LSASS

The investigation identified direct LSASS access attempts involving:

- `mimikatz.exe`
- `procdump64.exe`

with suspicious access rights including:

```text
0x1010
0x1fffff
```

---

# 📌 Correlated Findings

| Category | Findings |
|---|---|
| Target Process | lsass.exe |
| Suspicious Processes | procdump64.exe, mimikatz.exe |
| Access Rights | 0x1010, 0x1fffff |
| Activity Type | Credential dumping |

---

# 🔎 Detection 3 — Credential Dumping Correlation Analysis

## Purpose

Correlate credential dumping process execution, LSASS access activity, and account context into a unified investigation timeline.

## Splunk Search

```spl
index=endpoint sourcetype="XmlWinEventLog:Microsoft-Windows-Sysmon/Operational"
| rex field=_raw "<Data Name='Image'>(?<Image>[^<]+)</Data>"
| rex field=_raw "<Data Name='SourceImage'>(?<SourceImage>[^<]+)</Data>"
| rex field=_raw "<Data Name='TargetImage'>(?<TargetImage>[^<]+)</Data>"
| rex field=_raw "<Data Name='CommandLine'>(?<CommandLine>[^<]+)</Data>"
| rex field=_raw "<Data Name='User'>(?<User>[^<]+)</Data>"
| rex field=_raw "<Data Name='SourceUser'>(?<SourceUser>[^<]+)</Data>"
| eval Process=coalesce(Image,SourceImage)
| eval Account=coalesce(User,SourceUser)
| search Process="*procdump64.exe" OR Process="*mimikatz.exe"
| table _time host EventID Process TargetImage GrantedAccess CommandLine Account
| sort _time
```

## Detection Logic

This correlation search aggregates:

- credential dumping process execution
- LSASS access telemetry
- command-line execution artifacts
- administrative account context
- process access activity

to reconstruct credential theft operations occurring on the compromised endpoint.

---

# 🔎 Detection 4 — PowerShell Parent Process Correlation

## Purpose

Identify PowerShell spawning credential dumping tooling.

## Splunk Search

```spl
index=endpoint sourcetype="XmlWinEventLog:Microsoft-Windows-Sysmon/Operational"
("powershell.exe" AND "procdump64.exe")
| rex field=_raw "<Data Name='Image'>(?<Image>[^<]+)</Data>"
| rex field=_raw "<Data Name='ParentImage'>(?<ParentImage>[^<]+)</Data>"
| rex field=_raw "<Data Name='CommandLine'>(?<CommandLine>[^<]+)</Data>"
| table _time host Image ParentImage CommandLine
| sort _time
```

## Detection Logic

This detection identifies PowerShell-assisted execution of credential dumping tooling.

The investigation identified PowerShell spawning ProcDump execution associated with LSASS dumping activity, indicating scripted or attacker-assisted post-exploitation execution behavior.

---

# 🛡️ Detection Opportunities

| Activity | Detection Opportunity |
|---|---|
| ProcDump execution | Suspicious process creation |
| LSASS memory access | Sysmon Event ID 10 |
| Credential dumping | Access rights monitoring |
| Mimikatz execution | Suspicious process activity |
| PowerShell-assisted dumping | Parent-child process analysis |

---

# ⚠️ Potential False Positives

| Activity | Possible Legitimate Cause |
|---|---|
| ProcDump execution | Debugging or troubleshooting |
| PowerShell execution | Administrative scripting |
| LSASS access | Security tooling or EDR activity |

However, the combination of:

- credential dumping utilities,
- suspicious LSASS access,
- PowerShell-assisted execution,
- and prior adversary activity

significantly increased confidence in credential theft operations occurring within the environment.

---

# 🧠 MITRE ATT&CK Mapping

| Technique | ATT&CK ID |
|---|---|
| OS Credential Dumping: LSASS Memory | T1003.001 |
| PowerShell | T1059.001 |
| Process Injection / Process Access | T1055 |
| Ingress Tool Transfer | T1105 |
| Valid Accounts | T1078 |
