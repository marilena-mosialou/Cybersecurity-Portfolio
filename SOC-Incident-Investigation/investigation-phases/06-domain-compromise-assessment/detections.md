# Domain Compromise Assessment Detection Logic

## 🎯 Detection Goal

Correlate privileged authentication activity, Kerberos abuse, and credential access behavior to assess indicators of likely domain compromise activity.

---

# 🔎 Detection 1 — Privileged Authentication Correlation

## Purpose

Identify suspicious privileged authentication activity originating from previously identified adversary infrastructure.

## Splunk Search

```spl
index=endpoint sourcetype="WinEventLog:Security"
EventCode=4624
(Account_Name="Administrator" OR Account_Name="svc_backup")
Source_Network_Address="192.168.10.250"
| mvexpand Account_Name
| search Account_Name != "-"
| table _time ComputerName Account_Name Logon_Type Source_Network_Address
| sort _time
```

## Detection Logic

This detection focuses on identifying:

- Administrative account usage
- Service account authentication
- Network logon activity
- Cross-system privileged access
- Authentication originating from suspicious infrastructure

The investigation identified repeated Logon Type 3 network authentication events involving:

- `Administrator`
- `svc_backup`

originating from:

```text
192.168.10.250
```

---

# 🔎 Detection 2 — Privileged Account Correlation Summary

## Purpose

Summarize privileged account usage across affected systems.

## Splunk Search

```spl
index=endpoint sourcetype="WinEventLog:Security"
EventCode=4624
(Account_Name="Administrator" OR Account_Name="svc_backup")
Source_Network_Address="192.168.10.250"
| mvexpand Account_Name
| search Account_Name != "-"
| stats values(ComputerName) as TargetSystems count by Account_Name
```

## Detection Logic

This detection provides an executive-style correlation view of:

- privileged authentication activity
- affected systems
- service account usage
- repeated access behavior

The investigation identified repeated authentication activity against:

- SOLARIS-DC-01

using both:

- Administrator
- svc_backup

accounts.

---

# 🔎 Detection 3 — Multi-Phase Adversary Correlation

## Purpose

Correlate authentication, privilege assignment, and Kerberos activity associated with suspicious infrastructure.

## Splunk Search

```spl
index=endpoint (EventCode=4624 OR EventCode=4769 OR EventCode=4672) Source_Network_Address="192.168.10.250"
| eval Account_Name = mvfilter(Account_Name != "-")
| table _time ComputerName EventCode Account_Name Source_Network_Address
| sort _time
```

## Detection Logic

This correlation search combines telemetry across multiple attack phases, including:

- Successful authentication events
- Privilege assignment activity
- Kerberos ticket requests
- Service account usage
- Suspicious source infrastructure correlation

The combined telemetry demonstrated clear attack progression behavior associated with privileged domain access activity.

---

# 🛡️ Detection Opportunities

| Activity | Detection Opportunity |
|---|---|
| Privileged authentication | Event ID 4624 monitoring |
| Special privilege assignment | Event ID 4672 monitoring |
| Kerberos abuse | Event ID 4769 correlation |
| Service account targeting | Authentication behavior analysis |
| Multi-phase intrusion correlation | Cross-source telemetry analysis |

---

# ⚠️ Potential False Positives

| Activity | Possible Legitimate Cause |
|---|---|
| Administrative logons | Legitimate administrator activity |
| Service account usage | Automated operational tasks |
| Kerberos ticket requests | Standard domain authentication |

However, the combination of:

- credential dumping activity,
- Kerberoasting behavior,
- WMI-based lateral movement,
- privileged authentication,
- and suspicious infrastructure correlation

significantly increased confidence in malicious adversary activity occurring within the environment.

---

# 🧠 MITRE ATT&CK Mapping

| Technique | ATT&CK ID |
|---|---|
| Valid Accounts | T1078 |
| Remote Services | T1021 |
| WMI | T1047 |
| OS Credential Dumping | T1003 |
| Kerberoasting | T1558.003 |
| Lateral Movement | TA0008 |
| Credential Access | TA0006 |
