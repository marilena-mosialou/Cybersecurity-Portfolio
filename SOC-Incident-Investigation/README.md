# SOC Investigation: Active Directory Compromise Analysis using Splunk

## 📌 Overview

This project documents a full Security Operations Center (SOC) investigation of a simulated Active Directory compromise conducted inside a controlled lab environment.

The objective of the investigation was to reconstruct attacker activity through Windows Security Logs and Sysmon telemetry using Splunk SIEM.

## Related Project

This investigation is based on a separate Active Directory attack simulation lab:

[Active Directory Attack Lab](../Active-Directory-Attack-Lab)

The investigation focused on identifying evidence of:

- Initial credential abuse
- Domain enumeration activity
- Lateral movement attempts
- Credential dumping behavior
- Kerberos abuse
- Remote administration activity
- Indicators of domain compromise

The environment consisted of:

- Windows Domain Controller
- Windows client workstation
- Kali Linux attacker machine
- Splunk SIEM
- Sysmon with Olaf Hartong configuration

---

# ⚙️ Environment

| Component | Description |
|---|---|
| SIEM | Splunk Enterprise |
| Endpoint Telemetry | Windows Security Logs + Sysmon |
| Sysmon Configuration | Olaf Hartong Sysmon Modular |
| Domain Controller | SOLARIS-DC-01 |
| Workstation | SOLARIS-PC-01 |
| Attacker Host | Kali Linux |
| Domain | SOLARIS.LOCAL |

---

# 🔍 Investigation Methodology

The investigation followed a SOC-oriented workflow:

1. Identify suspicious authentication activity
2. Correlate authentication across hosts
3. Investigate privilege escalation attempts
4. Identify lateral movement behavior
5. Detect credential dumping activity
6. Analyze Kerberos abuse
7. Investigate evidence of domain compromise
8. Map findings to MITRE ATT&CK techniques

The investigation focused on correlating endpoint and authentication telemetry to reconstruct attacker behavior across the environment.

---

# 🧾 Data Sources

## 📊 Windows Security Logs

Primary Event IDs investigated:

| Event ID | Description |
|---|---|
| 4624 | Successful logon |
| 4625 | Failed logon |
| 4648 | Explicit credential logon |
| 4672 | Special privileges assigned |
| 4688 | Process creation |
| 4769 | Kerberos service ticket request |
| 4799 | Local group enumeration |
| 5145 | SMB share access |

---

## Sysmon Telemetry

Primary Sysmon Event IDs investigated:

| Event ID | Description |
|---|---|
| 1 | Process creation |
| 2 | File creation time changed |
| 3 | Network connection |
| 7 | Image loaded |
| 10 | Process access |
| 11 | File creation |
| 13 | Registry modification |

Sysmon telemetry became critical during later investigation phases, particularly for detecting LSASS memory access and WMI-based remote execution activity that was not fully visible through standard Windows Security logs alone.

---

# 🧠 MITRE ATT&CK Mapping

| Phase | Technique | ATT&CK ID |
|---|---|---|
| Credential Access | OS Credential Dumping | T1003 |
| Discovery | Account Discovery | T1087 |
| Discovery | Permission Group Discovery | T1069 |
| Discovery | Domain Trust Discovery | T1482 |
| Lateral Movement | SMB/Windows Admin Shares | T1021.002 |
| Lateral Movement | Windows Management Instrumentation | T1047 |
| Credential Access | Kerberoasting | T1558.003 |
| Credential Access | Steal or Forge Kerberos Tickets | T1558 |
| Credential Access | NTDS | T1003.003 |

---

# 🚨 Phase 1 — Suspicious Authentication Activity

## 🎯 Objective

Identify suspicious authentication behavior associated with compromised credentials.

## 🔍 Findings

Multiple successful and failed authentication attempts were identified originating from the attacker IP:

```spl
index=endpoint sourcetype="WinEventLog:Security"
(EventCode=4624 OR EventCode=4625)
Source_Network_Address="192.168.10.250"
| table _time ComputerName Account_Name EventCode Logon_Type Source_Network_Address
```

## 🚨 Observations

- Multiple Logon Type 3 events identified
- Authentication activity observed against:
  - SOLARIS-DC-01
  - SOLARIS-PC-01
- Failed authentication attempts preceded successful access

## 💡 Security Insight

This behavior is consistent with remote SMB authentication attempts and credential validation activity.

---

# 🕵️ Phase 2 — Domain Enumeration

## 🎯 Objective

Determine whether the compromised account performed Active Directory reconnaissance.

## 🔍 Findings

Group enumeration activity was identified for user p.olson.

```spl
index=endpoint EventCode=4799 "p.olson"
| table _time Group_Name Process_Name Message
```

## 🚨 Observations

The compromised account enumerated:

- Administrators
- Remote Desktop Users
- Remote Management Users
- Distributed COM Users

Additional enumeration activity involved:

- `net1.exe`
- `RuntimeBroker.exe`

## 💡 Security Insight

This behavior is consistent with attacker reconnaissance and privilege assessment within Active Directory environments.

---

# 🌐 Phase 3 — Lateral Movement Attempts

## 🎯 Objective

Identify evidence of remote execution and lateral movement behavior.

## 🔍 Findings

Windows Security logs revealed repeated remote network logons originating from the attacker system.

```spl
index=endpoint sourcetype="WinEventLog:Security"
EventCode=4624
Account_Name="Administrator"
Source_Network_Address="192.168.10.250"
| table _time ComputerName Logon_Type Source_Network_Address
```

## 🚨 Observations

- Repeated Logon Type 3 events observed
- Remote network logons originated from:
  - `192.168.10.250`
- Activity targeted:
  - `SOLARIS-DC-01`

## WMI-Based Remote Execution Evidence

Sysmon telemetry revealed remote WMI execution behavior.

```spl
index=endpoint sourcetype="XmlWinEventLog:Microsoft-Windows-Sysmon/Operational"
"ADMIN$"
"cmd.exe"
"WmiPrvSE.exe"
| table _time host _raw
```

## Critical Evidence

Observed command:

```cmd
cmd.exe /Q /c cd \ 1> \\127.0.0.1\ADMIN$\__1776842917.6134377 2>&1
```
Parent Process:

```
C:\Windows\System32\wbem\WmiPrvSE.exe
```

## 💡 Security Insight

This behavior strongly aligns with Impacket `wmiexec.py` remote command execution techniques.

The presence of:

- `WmiPrvSE.exe`
- `ADMIN$`
- remote command execution
- network authentication events

provides strong evidence of lateral movement activity.

---

# 🔑 Phase 4 — Credential Dumping (LSASS Access)

## 🎯 Objective

Identify evidence of credential dumping and LSASS memory access.

## 🔍 Findings

Sysmon ProcessAccess telemetry revealed suspicious access to LSASS memory from ProcDump.

```spl
index=endpoint sourcetype="XmlWinEventLog:Microsoft-Windows-Sysmon/Operational"
("lsass.exe" OR "procdump64.exe")
| rex "EventID>(?<EventID>\d+)"
| rex "Image'>(?<Image>[^<]+)"
| rex "CommandLine'>(?<CommandLine>[^<]+)"
| rex "ParentImage'>(?<ParentImage>[^<]+)"
| rex "User'>(?<User>[^<]+)"
| rex "SourceImage'>(?<SourceImage>[^<]+)"
| rex "TargetImage'>(?<TargetImage>[^<]+)"
| rex "GrantedAccess'>(?<GrantedAccess>[^<]+)"
| rex "SourceUser'>(?<SourceUser>[^<]+)"
| eval Process=coalesce(Image,SourceImage)
| eval Account=coalesce(User,SourceUser)
| table _time host EventID Process TargetImage GrantedAccess CommandLine ParentImage Account
| sort _time
```

## Critical Evidence

ProcDump Execution

```
"C:\Users\Public\procdump64.exe" -accepteula -ma lsass.exe C:\Users\Public\lsass.dmp
```

LSASS Memory Access

```
TargetImage: C:\WINDOWS\system32\lsass.exe
GrantedAccess: 0x1fffff
```

Parent Process

```
ParentImage:
C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe
```

## 💡 Security Insight

The investigation confirmed:

- Execution of ProcDump
- Direct access to LSASS memory
- High privilege access rights
- Creation of LSASS dump artifacts

This behavior is strongly associated with credential dumping operations.

---

# 🎟️ Phase 5 — Kerberoasting Activity

## 🎯 Objective

Identify suspicious Kerberos service ticket requests.

## 🔍 Findings

Windows Security Event ID 4769 revealed Kerberos service ticket requests targeting the svc_backup service account.

```spl
index=endpoint sourcetype="WinEventLog:Security"
EventCode=4769
| table _time ComputerName Account_Name Service_Name Ticket_Encryption_Type Client_Address
```

## 🚨 Observations

```
Service_Name: svc_backup
Client_Address: ::ffff:192.168.10.250
Ticket_Encryption_Type: 0x17
```

## 💡 Security Insight

This behavior aligns with Kerberoasting activity involving service accounts configured with SPNs.

The activity indicates:

- Service ticket extraction
- Potential offline password cracking attempts
- Exposure of privileged service accounts

---

# 👑 Phase 6 — Suspected Domain Compromise Activity

## 🎯 Objective

Determine whether attacker activity escalated to domain-wide compromise.

## 🔍 Findings

Repeated successful remote administrative authentications were observed using:

- Administrator
- svc_backup

originating from:

```
192.168.10.250
```

## 🚨 Observations

- Repeated remote network logons
- Administrative account usage
- Lateral movement into Domain Controller
- Service account authentication activity

## 💡 Security Insight

The combination of:

- credential dumping,
- Kerberoasting,
- remote administration activity,
- and repeated privileged logons

indicates a high likelihood of successful privileged domain access and potential domain-wide credential compromise.

While direct execution telemetry for `secretsdump.py` or explicit NTDS extraction commands was not fully captured, the investigation identified strong behavioral indicators consistent with domain credential extraction activity.

---

# 🎯 Key Detection Opportunities

| Activity | Detection Opportunity |
|---|---|
| Remote WMI execution | WmiPrvSE.exe spawning cmd.exe |
| Credential dumping | Sysmon Event ID 10 |
| Kerberoasting | Event ID 4769 |
| Suspicious SMB authentication | Event ID 4624 Type 3 |
| Administrative share usage | ADMIN$ references |
| PowerShell spawning ProcDump | Sysmon Event ID 1 |

---

# ⚠️ Visibility Gaps Identified

The investigation also highlighted important telemetry limitations.

## Missing or Limited Visibility

- Direct secretsdump.py telemetry
- Explicit NTDS.dit extraction commands
- SMB file extraction artifacts
- Full command-line visibility in some Security Events
- Lack of PowerShell Script Block Logging limited visibility into attacker PowerShell activity

## Lessons Learned

The project demonstrated why:

- Sysmon ProcessAccess events are critical
- Advanced endpoint telemetry significantly improves investigations
- Correlation across multiple log sources is essential in SOC operations

---

# ✅ Conclusion

This investigation reconstructed a multi-stage Active Directory compromise through Splunk-based telemetry analysis.

The investigation successfully identified:

- Suspicious authentication activity
- Domain enumeration behavior
- Lateral movement attempts
- Remote WMI execution
- LSASS credential dumping
- Kerberoasting activity
- Indicators of domain compromise

The project demonstrates practical SOC investigation methodology, detection engineering, and telemetry correlation skills relevant to real-world enterprise environments.
