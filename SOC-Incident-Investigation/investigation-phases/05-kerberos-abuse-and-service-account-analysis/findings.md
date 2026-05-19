# Kerberos Abuse and Service Account Analysis Findings

## 🚨 Summary of Findings

The investigation identified suspicious Kerberos service ticket activity involving:

```text
svc_backup
```

originating from:

```text
192.168.10.250
```

The observed behavior involved:

- Kerberos Service Ticket Requests (TGS)
- RC4-encrypted Kerberos tickets
- Service account targeting
- Administrative account activity
- Correlation with previously identified attacker infrastructure

The telemetry strongly aligned with Kerberoasting-related behavior commonly associated with credential access operations.

---

# 🔍 Key Observations

## Suspicious Kerberos Service Ticket Requests

Windows Security Event ID 4769 telemetry revealed Kerberos ticket requests associated with:

```text
Administrator@SOLARIS.LOCAL
```

targeting:

```text
svc_backup
```

The requests originated from:

```text
::ffff:192.168.10.250
```

which had previously been associated with suspicious authentication and remote execution activity during earlier investigation phases.

---

# 🎟️ RC4 Kerberos Encryption Usage

The investigation identified Kerberos ticket activity using:

```text
0x17
```

which corresponds to:

```text
RC4-HMAC
```

RC4-encrypted Kerberos tickets are significant because they are commonly targeted during Kerberoasting operations due to their susceptibility to offline password cracking.

The environment also contained:

```text
0x12
```

AES-based Kerberos activity, allowing suspicious RC4 ticket usage to stand out during analysis.

---

# 👤 Service Account Targeting

The `svc_backup` service account was repeatedly targeted through Kerberos service ticket requests originating from suspicious infrastructure.

This behavior strongly aligned with:

- Service account enumeration
- Credential access operations
- Kerberoasting-related activity
- Privilege escalation preparation

The activity indicated attacker interest in privileged or operational service accounts within the domain environment.

---

# 🔗 Multi-Phase Correlation

The Kerberos activity directly correlated with:

- Suspicious authentication activity
- Administrative network logons
- WMI-based remote execution
- Credential dumping activity
- Previously identified attacker infrastructure

This cross-phase correlation significantly increased confidence that the Kerberos activity formed part of a coordinated intrusion sequence within the environment.

---

# 🧠 Analyst Assessment

The combination of:

- RC4-encrypted Kerberos tickets,
- service account targeting,
- suspicious client infrastructure,
- administrative account activity,
- and prior credential access behavior

provided high-confidence evidence of Kerberoasting-related activity occurring within the Solaris domain environment.

The observed telemetry strongly aligned with adversary tradecraft commonly associated with:

- Kerberoasting
- Service account abuse
- Credential access operations
- Privileged domain compromise preparation

At this stage of the investigation, confidence in active adversary credential targeting significantly increased.

---

# ⚠️ Investigation Limitations

Several telemetry limitations were identified during the investigation:

- Limited visibility into offline password cracking activity
- No direct ticket extraction telemetry
- Incomplete PowerShell logging
- Limited endpoint process visibility related to Kerberos tooling

Despite these limitations, sufficient telemetry existed to reconstruct high-confidence Kerberos abuse activity within the environment.

---

# 🎯 Conclusion

The investigation identified Kerberos authentication behavior consistent with Kerberoasting-related activity targeting the `svc_backup` service account.

The observed telemetry strongly aligned with adversary credential access techniques involving RC4-encrypted Kerberos tickets, service account targeting, and coordinated post-exploitation activity within the Active Directory environment.
