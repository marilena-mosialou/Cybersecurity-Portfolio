# Kerberoasting Activity Detection

## 🎯 Purpose

Detect suspicious Kerberos service ticket activity associated with potential Kerberoasting attacks targeting service accounts.

This detection is designed to identify:

- RC4-encrypted Kerberos tickets
- Service account targeting
- Kerberoasting behavior
- Credential access activity

---

# 📊 Data Source

| Source | Details |
|---|---|
| Windows Security Logs | Kerberos authentication telemetry |
| Event IDs | 4769 |

---

# 🧠 ATT&CK Mapping

| Technique | ATT&CK ID |
|---|---|
| Kerberoasting | T1558.003 |

---

# 🔍 Detection Logic

This detection identifies RC4-encrypted (`0x17`) Kerberos service ticket requests commonly associated with Kerberoasting activity.

The detection correlates:

- targeted service accounts
- requesting accounts
- client addresses
- Kerberos encryption types

to identify suspicious Kerberos authentication behavior associated with credential access operations.

---

# ⚠️ False Positives

Potential legitimate sources of activity include:

- Legacy Kerberos configurations
- Older applications requiring RC4 encryption
- Misconfigured service accounts

Investigation should focus on:
- unusual service account targeting
- repeated RC4 ticket activity
- suspicious client systems
- abnormal authentication volume

---

# 🛡️ SOC Detection Query

```spl
index=endpoint sourcetype="WinEventLog:Security"
EventCode=4769
Ticket_Encryption_Type="0x17"
| stats count values(Service_Name) as TargetedServices by Account_Name Client_Address
| where count > 3
| sort - count
```

---

# 🧠 Analyst Notes

This detection was developed from Kerberos abuse activity observed during the Solaris Active Directory compromise investigation involving RC4-encrypted Kerberos service ticket requests and service account targeting behavior.
