# Phase 04 — Credential Access and LSASS Dumping

## 🎯 Objective

The objective of this phase was to investigate potential credential access activity performed after successful remote execution and lateral movement activity identified during earlier investigation phases.

The investigation focused on identifying:

- Credential dumping activity
- LSASS memory access
- ProcDump execution
- Mimikatz process activity
- PowerShell-assisted credential dumping
- Indicators of post-exploitation credential theft

---

# 🔍 Investigation Scope

The investigation analyzed Sysmon telemetry associated with suspicious credential dumping behavior targeting:

```text
SOLARIS-PC-01
```

Particular attention was given to activity involving:

- `procdump64.exe`
- `mimikatz.exe`
- `powershell.exe`
- `lsass.exe`

The investigation also focused on identifying suspicious process access rights and credential dumping artifacts associated with LSASS memory extraction activity.

---

# 📊 Telemetry Sources

| Source | Purpose |
|---|---|
| Sysmon Event ID 1 | Process creation telemetry |
| Sysmon Event ID 10 | Process access telemetry |
| Splunk SIEM | Event aggregation, parsing, and correlation |

---

# 🔐 Relevant Windows Event IDs

| Event ID | Description |
|---|---|
| Sysmon Event ID 1 | Process creation |
| Sysmon Event ID 10 | Process access |

---

# 🧠 Investigation Methodology

The investigation followed a structured credential access analysis workflow:

1. Identify suspicious credential dumping utilities
2. Investigate LSASS memory access activity
3. Correlate process execution telemetry
4. Analyze command-line execution artifacts
5. Investigate PowerShell-assisted execution
6. Assess indicators of credential theft activity

---

# 🌐 Credential Access Focus Areas

The investigation focused on identifying behaviors commonly associated with:

- LSASS memory dumping
- ProcDump credential dumping
- Mimikatz execution
- PowerShell-assisted post-exploitation activity
- Administrative credential theft

Particular attention was given to:

- `lsass.exe`
- `procdump64.exe`
- `mimikatz.exe`
- suspicious access rights
- dump file creation activity

These artifacts frequently appear during post-exploitation credential theft operations.

---

# ⚠️ Investigation Notes

The investigation identified high-confidence evidence of credential dumping activity involving:

```text
C:\Users\Public\procdump64.exe
```

and:

```text
C:\Users\Public\mimikatz.exe
```

The investigation also identified direct access attempts targeting:

```text
C:\WINDOWS\system32\lsass.exe
```

using suspicious access rights including:

```text
0x1010
0x1fffff
```

The observed telemetry strongly aligned with known credential dumping techniques commonly associated with adversary post-exploitation activity.

---

# 🔗 Investigation Progression

The credential access activity identified during this phase represented a significant escalation from earlier reconnaissance and lateral movement activity.

The findings established a clear progression toward later investigation phases involving:

- Kerberos abuse
- service account targeting
- privileged domain compromise
- potential domain-wide credential extraction
