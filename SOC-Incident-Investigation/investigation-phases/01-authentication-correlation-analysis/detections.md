# Authentication Detection Logic

## 🎯 Detection Goal

Identify suspicious remote authentication activity indicative of unauthorized access, credential abuse, and potential lateral movement preparation within the Active Directory environment.

---

# 🔎 Detection 1 — Suspicious Remote Network Logons

## Purpose

Identify successful remote network authentication events originating from a suspicious external system.

## Splunk Search

```spl
index=endpoint sourcetype="WinEventLog:Security"
EventCode=4624
Logon_Type=3
Source_Network_Address="192.168.10.250"
| search NOT Account_Name IN ("ANONYMOUS LOGON", "SYSTEM")
| stats count by _time ComputerName Account_Name Source_Network_Address Logon_Type
| where Account_Name != "-"
| sort _time
```

## Detection Logic

- Monitor successful Logon Type 3 authentication events
- Identify remote network authentication originating from suspicious systems
- Correlate authentication activity across multiple hosts
- Identify administrative and service account authentication behavior

---

# 📌 Key Indicators Observed

| Indicator | Observation |
|---|---|
| Source IP | 192.168.10.250 |
| Logon Type | 3 (Network Logon) |
| Affected Systems | SOLARIS-DC-01, SOLARIS-PC-01 |
| Accounts Observed | Administrator, p.olson, svc_backup |

---

# 🧠 Analyst Notes

Logon Type 3 events indicate remote network authentication activity commonly associated with:

- SMB authentication
- Remote administration
- Administrative share access
- Impacket tooling
- Lateral movement preparation

The repeated authentication activity observed across multiple systems from a single source IP significantly increased the likelihood of unauthorized access activity.

At this stage, the activity was treated as suspicious pending additional correlation and investigation.

---

# 🔎 Detection 2 — Authentication Correlation Analysis

## Purpose

Correlate authentication telemetry across systems and accounts to reconstruct the authentication scope of the suspicious activity.

## Splunk Search

```spl
index=endpoint sourcetype="WinEventLog:Security"
EventCode=4624
Source_Network_Address="192.168.10.250"
| search NOT Account_Name IN ("ANONYMOUS LOGON", "SYSTEM")
| stats values(Account_Name) as Accounts values(ComputerName) as TargetSystems count by Source_Network_Address
| eval Accounts = mvfilter(Accounts != "-")
| rename Source_Network_Address as AttackerIP
```

## Detection Logic

- Aggregate authentication telemetry by source IP
- Identify impacted systems
- Correlate authentication activity across accounts
- Reconstruct authentication spread across the environment

---

# 🧠 Analyst Notes

The authentication correlation analysis demonstrated:

- Remote authentication activity against multiple systems
- Authentication involving user, administrative, and service accounts
- Repeated authentication behavior originating from a single source system
- Indicators consistent with credential reuse and lateral authentication activity

This type of authentication correlation is valuable during SOC investigations because it enables analysts to quickly assess:

- attack scope
- impacted systems
- potentially compromised identities
- lateral movement progression

---

# 🛡️ Detection Opportunities

| Activity | Detection Opportunity |
|---|---|
| Remote SMB authentication | Event ID 4624 Logon Type 3 |
| Cross-host authentication activity | Source IP correlation |
| Administrative account authentication | Privileged account monitoring |
| Service account authentication | Service account usage baselining |
| Lateral movement preparation | Repeated authentication across systems |

---

# ⚠️ Potential False Positives

| Activity | Possible Legitimate Cause |
|---|---|
| Logon Type 3 events | Legitimate SMB access |
| Administrative authentication | Authorized administration |
| Service account authentication | Scheduled services or enterprise tooling |
| Cross-host authentication | Management or automation systems |

---

# 🧠 MITRE ATT&CK Mapping

| Technique | ATT&CK ID |
|---|---|
| Valid Accounts | T1078 |
| Remote Services | T1021 |
| SMB/Windows Admin Shares | T1021.002 |
| Lateral Tool Transfer | T1570 |
