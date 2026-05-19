# Phase 6 — Domain Compromise Assessment

## 🎯 Objective

The objective of this phase was to assess whether the observed adversary activity resulted in likely privileged domain compromise within the Active Directory environment.

The investigation focused on correlating evidence collected across previous investigation phases, including:

- Suspicious authentication activity
- Administrative account usage
- Service account authentication
- WMI-based lateral movement
- Credential dumping activity
- Kerberoasting behavior
- Cross-system adversary activity

The goal was not to definitively prove complete domain takeover, but rather to determine whether sufficient evidence existed to support a high-confidence assessment of domain compromise activity.

---

# 🔍 Investigation Scope

The investigation focused on suspicious activity originating from:

```text
192.168.10.250
```

This system had previously been identified as the Kali Linux host used during the simulated adversary operations inside the lab environment.

Primary systems investigated:

- SOLARIS-DC-01
- SOLARIS-PC-01

Privileged accounts investigated:

- Administrator
- svc_backup

---

# 📊 Telemetry Sources

| Source | Purpose |
|---|---|
| Windows Security Logs | Authentication, privilege assignment, and Kerberos activity |
| Sysmon Operational Logs | Process creation and credential access visibility |
| Splunk SIEM | Event aggregation, correlation, and investigation |

---

# 🔐 Relevant Windows Event IDs

| Event ID | Description |
|---|---|
| 4624 | Successful logon |
| 4672 | Special privileges assigned to new logon |
| 4769 | Kerberos service ticket request |

---

# 🧠 Investigation Methodology

The domain compromise assessment followed a structured correlation-based workflow:

1. Identify privileged authentication activity
2. Correlate suspicious source infrastructure
3. Analyze administrative and service account usage
4. Correlate Kerberos abuse activity
5. Review credential dumping evidence
6. Assess cross-phase attack progression
7. Determine confidence level of domain compromise indicators

---

# 🌐 Cross-Phase Correlation Areas

The investigation correlated telemetry associated with:

- Administrative authentication activity
- Service account usage
- Kerberos ticket requests
- RC4-encrypted service ticket activity
- WMI-based remote execution
- LSASS credential dumping behavior
- Suspicious source infrastructure

The observed behaviors aligned with attack patterns commonly associated with:

- Privilege escalation
- Credential access
- Lateral movement
- Kerberoasting
- Domain compromise preparation

---

# ⚠️ Investigation Notes

The investigation identified multiple indicators strongly consistent with privileged adversary activity within the Solaris domain environment.

However, the assessment intentionally avoided overstating the level of compromise due to several telemetry limitations, including:

- No direct NTDS.dit extraction evidence
- No confirmed DCSync telemetry
- No direct Domain Admin group modification events
- Limited PowerShell logging visibility
- Limited endpoint telemetry retention

Despite these limitations, the combined evidence across all investigation phases provided high-confidence indicators consistent with likely domain compromise activity.

---

# 🔗 Investigation Conclusion

The investigation established a strong correlation between:

- privileged account usage,
- credential dumping activity,
- Kerberos abuse,
- remote execution behavior,
- and suspicious authentication activity

originating from previously identified adversary-controlled infrastructure.

The combined telemetry strongly suggested that the attacker successfully obtained and utilized privileged domain credentials during the intrusion lifecycle.

While complete domain takeover could not be definitively confirmed from available telemetry, the investigation identified high-confidence evidence consistent with privileged domain compromise activity within the environment.
