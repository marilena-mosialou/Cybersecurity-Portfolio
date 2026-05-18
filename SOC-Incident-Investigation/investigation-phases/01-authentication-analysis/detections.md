# Authentication Detection Logic

## 🎯 Detection Goal

Identify suspicious authentication activity indicative of credential abuse, remote access attempts, or lateral movement preparation.

---

# 🔎 Detection 1 — Failed Authentication Attempts

## Purpose

Identify repeated failed authentication attempts originating from the attacker system.

## Splunk Search

```spl
index=endpoint sourcetype="WinEventLog:Security"
EventCode=4625
Source_Network_Address="192.168.10.250"
| table _time ComputerName Account_Name Logon_Type Source_Network_Address Failure_Reason
| sort _time
```

## Detection Logic

- Monitor failed logons originating from external or suspicious systems
- Identify repeated authentication failures across multiple hosts
- Correlate failed attempts followed by successful authentication events

## Analyst Notes

Repeated failed authentication attempts may indicate:

- Password spraying
- Credential guessing
- Authentication validation attempts
- Misconfigured remote access tooling

---

# 🔎 Detection 2 — Successful Remote Network Logons

## Purpose

Identify successful remote authentication events associated with potential lateral movement activity.

## Splunk Search

```spl
index=endpoint sourcetype="WinEventLog:Security"
EventCode=4624
Logon_Type=3
Source_Network_Address="192.168.10.250"
| table _time ComputerName Account_Name Logon_Type Source_Network_Address
| sort _time
```

## Detection Logic

- Monitor successful Logon Type 3 events
- Correlate authentication activity across systems
- Identify administrative account usage from remote systems

## Analyst Notes

Logon Type 3 events indicate remote network authentication activity commonly associated with:

- SMB access
- Remote administration
- Lateral movement
- Impacket tooling

---

# 🔎 Detection 3 — Explicit Credential Usage

## Purpose

Identify explicit credential usage events associated with remote authentication attempts.

## Splunk Search

```spl
index=endpoint sourcetype="WinEventLog:Security"
EventCode=4648
| table _time ComputerName Account_Name Process_Name Network_Account_Name
| sort _time
```

## Detection Logic

- Monitor explicit credential usage
- Correlate with remote authentication activity
- Identify suspicious administrative logons

## Analyst Notes

Event ID 4648 may indicate:

- RunAs usage
- Remote authentication tooling
- Administrative authentication activity
- Credential abuse

---

# 🔎 Detection 4 — Privileged Logon Correlation

## Purpose

Identify privileged authentication events associated with suspicious remote access.

## Splunk Search

```spl
index=endpoint sourcetype="WinEventLog:Security"
EventCode=4672
| table _time ComputerName Account_Name PrivilegeList
| sort _time
```

## Detection Logic

- Monitor privileged logons
- Correlate with successful remote authentication events
- Identify administrative account activity following authentication attempts

## Analyst Notes

Privileged logons immediately following remote authentication events may indicate:

- Administrative access
- Privilege escalation
- Lateral movement preparation
- Compromised administrative credentials

---

# 🛡️ Detection Opportunities

| Activity | Detection Opportunity |
|---|---|
| Failed logons | Excessive 4625 events |
| Successful remote authentication | 4624 Logon Type 3 |
| Explicit credential usage | Event ID 4648 |
| Administrative authentication | Event ID 4672 |
| Cross-host authentication correlation | Shared source IP analysis |

---

# ⚠️ Potential False Positives

| Activity | Possible Legitimate Cause |
|---|---|
| Failed authentication attempts | Incorrect passwords |
| Logon Type 3 events | Legitimate SMB access |
| Explicit credential usage | Administrative tooling |
| Privileged logons | Authorized administration |

---

# 🧠 MITRE ATT&CK Mapping

| Technique | ATT&CK ID |
|---|---|
| Valid Accounts | T1078 |
| SMB/Windows Admin Shares | T1021.002 |
| Remote Services | T1021 |
| Brute Force | T1110 |
