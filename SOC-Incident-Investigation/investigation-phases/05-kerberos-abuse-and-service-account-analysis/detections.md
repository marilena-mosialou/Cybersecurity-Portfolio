# Kerberos Abuse and Service Account Analysis Detection Logic

## 🎯 Detection Goal

Identify suspicious Kerberos service ticket activity, RC4-encrypted ticket usage, and service account targeting behavior associated with potential Kerberoasting activity.

---

# 🔎 Detection 1 — Kerberos Service Ticket Requests

## Purpose

Identify Kerberos Ticket Granting Service (TGS) requests and associated service accounts, encryption types, and client source addresses.

## Splunk Search

```spl
index=endpoint sourcetype="WinEventLog:Security"
EventCode=4769
| table _time ComputerName Account_Name Service_Name Ticket_Encryption_Type Client_Address
| sort _time
```

## Detection Logic

This detection focuses on identifying:

- Kerberos service ticket requests
- Targeted service accounts
- Kerberos encryption types
- Suspicious client source addresses
- Administrative account activity

The investigation identified Kerberos ticket requests associated with:

- `Administrator@SOLARIS.LOCAL`
- `svc_backup`
- `::ffff:192.168.10.250`

---

# 📌 Key Indicators Observed

| Indicator | Observation |
|---|---|
| Event ID | 4769 |
| Service Account | svc_backup |
| Encryption Type | 0x17 |
| Client Address | ::ffff:192.168.10.250 |
| Activity Type | Kerberos TGS Requests |

---

# 🧠 Analyst Notes

The investigation identified RC4-encrypted (`0x17`) Kerberos ticket activity associated with the `svc_backup` service account.

RC4-encrypted Kerberos tickets are commonly targeted during Kerberoasting operations due to their susceptibility to offline password cracking.

The observed behavior strongly aligned with Kerberoasting-related activity.

---

# 🔎 Detection 2 — Service Account Analysis

## Purpose

Investigate Kerberos ticket requests targeting the `svc_backup` service account.

## Splunk Search

```spl
index=endpoint sourcetype="WinEventLog:Security"
EventCode=4769
Service_Name="svc_backup"
| table _time ComputerName Account_Name Service_Name Ticket_Encryption_Type Client_Address
| sort _time
```

## Detection Logic

This detection isolates Kerberos ticket activity involving the `svc_backup` service account to identify:

- Suspicious service account targeting
- Potential credential access activity
- Kerberoasting-related behavior
- Correlation with attacker infrastructure

---

# 📌 Correlated Findings

| Category | Findings |
|---|---|
| Service Account | svc_backup |
| Encryption Type | 0x17 |
| Source Address | ::ffff:192.168.10.250 |
| Account Context | Administrator@SOLARIS.LOCAL |

---

# 🔎 Detection 3 — Kerberos Encryption Correlation

## Purpose

Analyze Kerberos encryption usage associated with service ticket activity.

## Splunk Search

```spl
index=endpoint sourcetype="WinEventLog:Security"
EventCode=4769
| stats count by Service_Name Ticket_Encryption_Type
| sort - count
```

## Detection Logic

This correlation search analyzes Kerberos encryption types to identify:

- RC4-encrypted Kerberos tickets
- Weak Kerberos encryption usage
- Service accounts vulnerable to Kerberoasting
- Suspicious authentication patterns

The investigation identified both:

- `0x12` AES-based activity
- `0x17` RC4-based activity

associated with Kerberos ticket requests.

---

# 🔎 Detection 4 — Suspicious Client Kerberos Correlation

## Purpose

Correlate Kerberos ticket requests originating from previously identified suspicious infrastructure.

## Splunk Search

```spl
index=endpoint sourcetype="WinEventLog:Security"
EventCode=4769
Client_Address="::ffff:192.168.10.250"
| table _time Account_Name Service_Name Ticket_Encryption_Type Client_Address
| sort _time
```

## Detection Logic

This detection focuses on identifying Kerberos ticket activity originating from infrastructure previously associated with:

- Suspicious authentication activity
- Remote administrative execution
- Credential dumping activity
- Adversary-controlled behavior

The correlation significantly increased confidence in malicious Kerberos abuse activity occurring within the environment.

---

# 🛡️ Detection Opportunities

| Activity | Detection Opportunity |
|---|---|
| Kerberoasting | Event ID 4769 monitoring |
| RC4 Kerberos usage | Encryption type analysis |
| Service account targeting | Service_Name correlation |
| Suspicious Kerberos requests | Client address monitoring |
| Credential access activity | Cross-phase telemetry correlation |

---

# ⚠️ Potential False Positives

| Activity | Possible Legitimate Cause |
|---|---|
| Service ticket requests | Normal Kerberos authentication |
| RC4 encryption usage | Legacy application compatibility |
| Service account activity | Legitimate administrative operations |

However, the combination of:

- RC4-encrypted ticket activity,
- service account targeting,
- suspicious client infrastructure,
- and prior adversary activity

significantly increased confidence in Kerberoasting-related behavior occurring within the environment.

---

# 🧠 MITRE ATT&CK Mapping

| Technique | ATT&CK ID |
|---|---|
| Kerberoasting | T1558.003 |
| Valid Accounts | T1078 |
| Remote Services | T1021 |
| OS Credential Dumping | T1003 |
