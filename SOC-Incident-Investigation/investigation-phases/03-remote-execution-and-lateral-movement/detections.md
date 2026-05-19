# Remote Execution and Lateral Movement Detection Logic

## 🎯 Detection Goal

Identify remote execution activity and lateral movement behavior associated with unauthorized remote administration and attacker-controlled command execution within the Active Directory environment.

---

# 🔎 Detection 1 — WMI Remote Execution Evidence

## Purpose

Identify suspicious remote command execution activity involving WMI process spawning and ADMIN$ artifacts.

## Splunk Search

```spl
index=endpoint sourcetype="XmlWinEventLog:Microsoft-Windows-Sysmon/Operational" ("WmiPrvSE.exe" AND "cmd.exe" AND "ADMIN$")
| rex field=_raw "<Data Name='Image'>(?<Image>[^<]+)</Data>"
| rex field=_raw "<Data Name='ParentImage'>(?<ParentImage>[^<]+)</Data>"
| rex field=_raw "<Data Name='CommandLine'>(?<CommandLine>[^<]+)</Data>"
| rex field=_raw "<Data Name='User'>(?<User>[^<]+)</Data>"
| table _time host Image ParentImage CommandLine User
| sort _time
```

## Detection Logic

This detection focuses on identifying:

- WMI provider execution activity
- command shell spawning
- ADMIN$ share references
- remote shell artifacts
- privileged remote execution behavior

The investigation identified:

```text
WmiPrvSE.exe
```

spawning:

```text
cmd.exe
```

with command-line artifacts referencing:

```text
ADMIN$
```

This behavior strongly aligns with remote execution tooling frequently used during adversary lateral movement operations.

---

# 📌 Key Indicators Observed

| Indicator | Observation |
|---|---|
| Parent Process | WmiPrvSE.exe |
| Child Process | cmd.exe |
| Administrative Share | ADMIN$ |
| User Context | SOLARIS\Administrator |
| Execution Pattern | Remote command shell activity |

---

# 🧠 Analyst Notes

The observed command-line artifact:

```text
cmd.exe /Q /c
```

combined with:

- WMI execution
- ADMIN$ references
- privileged user context

provided high-confidence evidence of remote command execution behavior.

The telemetry strongly aligned with behavioral patterns associated with:

- Impacket wmiexec.py
- WMI-based lateral movement
- remote administrative shell execution

---

# 🔎 Detection 2 — WMI Execution Correlation Analysis

## Purpose

Correlate remote execution telemetry to reconstruct remote administration behavior and execution scope.

## Splunk Search

```spl
index=endpoint sourcetype="XmlWinEventLog:Microsoft-Windows-Sysmon/Operational" ("WmiPrvSE.exe" AND "cmd.exe")
| rex field=_raw "<Data Name='ParentImage'>(?<ParentImage>[^<]+)</Data>"
| rex field=_raw "<Data Name='CommandLine'>(?<CommandLine>[^<]+)</Data>"
| rex field=_raw "<Data Name='User'>(?<User>[^<]+)</Data>"
| stats values(CommandLine) as Commands values(ParentImage) as ParentProcesses count by host User
```

## Detection Logic

This correlation search aggregates:

- parent-child execution relationships
- remote execution commands
- associated user context
- execution frequency

to reconstruct suspicious remote administration activity within the environment.

---

# 📌 Correlated Findings

| Category | Findings |
|---|---|
| Execution Host | SOLARIS-DC-01 |
| User Context | SOLARIS\Administrator |
| Parent Process | WmiPrvSE.exe |
| Command Activity | cmd.exe /Q /c |
| Execution Pattern | Remote administrative shell activity |

---

# 🔎 Detection 3 — Administrative Authentication Correlation

## Purpose

Correlate privileged network authentication activity associated with remote execution behavior.

## Splunk Search

```spl
index=endpoint sourcetype="WinEventLog:Security"
EventCode=4624
Logon_Type=3
Account_Name="Administrator"
Source_Network_Address="192.168.10.250"
| mvexpand Account_Name
| search Account_Name != "-"
| table _time ComputerName Account_Name Source_Network_Address Logon_Type
| sort _time
```

## Detection Logic

This detection identifies successful remote network authentication activity involving privileged administrative accounts originating from the suspicious external system.

The investigation correlated:

- privileged Logon Type 3 events
- remote execution telemetry
- WMI process execution
- administrative share artifacts

to reconstruct lateral movement behavior.

---

# 🛡️ Detection Opportunities

| Activity | Detection Opportunity |
|---|---|
| WMI remote execution | WmiPrvSE.exe spawning cmd.exe |
| Administrative share usage | ADMIN$ references |
| Remote shell activity | cmd.exe /Q /c artifacts |
| Privileged remote authentication | Event ID 4624 Logon Type 3 |
| Lateral movement | Cross-host privileged execution |

---

# ⚠️ Potential False Positives

| Activity | Possible Legitimate Cause |
|---|---|
| WMI execution | Enterprise management tooling |
| ADMIN$ usage | Legitimate remote administration |
| Remote cmd.exe execution | IT support activity |
| Privileged authentication | Authorized administration |

However, the combination of:

- suspicious authentication activity,
- reconnaissance behavior,
- WMI-based execution,
- and remote administrative shell artifacts

significantly increased confidence in adversary-controlled lateral movement activity.

---

# 🧠 MITRE ATT&CK Mapping

| Technique | ATT&CK ID |
|---|---|
| Windows Management Instrumentation | T1047 |
| Remote Services | T1021 |
| SMB/Windows Admin Shares | T1021.002 |
| Command and Scripting Interpreter | T1059 |
| Lateral Tool Transfer | T1570 |
