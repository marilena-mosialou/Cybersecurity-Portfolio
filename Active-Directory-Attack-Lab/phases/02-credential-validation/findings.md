# 🔍 Phase 2 Findings — Credential Validation & Access Verification

## 📌 Summary

Captured NTLMv2 authentication material was leveraged to validate domain credentials within the internal enterprise environment.

Although offline password cracking attempts using common public wordlists were unsuccessful, direct credential validation revealed that the compromised account used a weak and predictable password pattern.

Successful authentication confirmed the attacker's ability to interact with domain systems using legitimate credentials.

---

# 🎯 Credential Validation Results

## Compromised Account

```text
SOLARIS\p.olson
```

## Validated Password

```text
Solaris2026!
```

## Authentication Status

```text
Successful
```

---

# 🔐 Privilege Observations

The compromised account continued to operate with standard domain user privileges.

## Account Context

- **User:** Peggy Olson (`p.olson`)
- **Title:** Copywriter
- **Organizational Unit (OU):** `02-Creative`

Observed privileges at this stage included:

- Domain authentication
- SMB authentication
- Access to standard domain resources

No administrative privileges were identified during this phase.

---

# 🧠 Attack Conclusions

Several important operational observations were identified during this phase:

- Offline cracking failure did not prevent attack progression
- Weak enterprise password patterns enabled credential validation
- Valid credentials significantly increased attacker capability
- Legitimate authentication mechanisms can be abused without malware execution

This phase demonstrates how predictable password schemes can undermine enterprise authentication security even when passwords are not publicly exposed within common wordlists.

---

# 📊 Detection Opportunities

Potentially observable activity generated during this phase included:

- Repeated SMB authentication attempts
- Authentication attempts across multiple hosts
- Password spraying behavior
- Network logon activity
- CrackMapExec SMB scanning behavior

Relevant monitoring sources include:

| Source | Visibility |
|---|---|
| Windows Security Logs | Authentication activity |
| Sysmon | Process execution |
| Network Monitoring | SMB authentication patterns |
| SIEM Correlation | Repeated authentication behavior |

Relevant Windows Event IDs include:

| Event ID | Description |
|---|---|
| 4624 | Successful logon |
| 4625 | Failed logon |
| 4648 | Explicit credential usage |

---

# ⚠️ Security Weaknesses Identified

The attack succeeded due to several environmental weaknesses:

- Weak password hygiene
- Predictable organizational password patterns
- Lack of password complexity enforcement
- Excessive trust in internal authentication traffic

---

# 🛡️ Defensive Considerations

Recommended defensive improvements include:

- Enforce strong password policies
- Implement account lockout protections
- Deploy MFA for privileged access
- Monitor repeated authentication attempts
- Detect abnormal SMB authentication behavior
- Restrict credential reuse across systems

---

# 📈 Risk Assessment

| Category | Rating |
|---|---|
| Severity | High |
| Likelihood | High |
| Impact | High |

## Business Risk

Successful credential validation provides attackers with legitimate access to enterprise systems and significantly increases the likelihood of lateral movement, reconnaissance, and privilege escalation activity.

Weak password practices remain one of the most common enterprise attack vectors and frequently enable broader Active Directory compromise.

---

# 📸 Evidence

## Offline Password Cracking Attempt

![Hashcat Failed Crack](screenshots/phase2-hashcat-failed-crack.png)

Hashcat was used to perform an offline dictionary attack against the captured NTLMv2 authentication material using the rockyou.txt wordlist.

The password was not recovered during the initial cracking attempt, indicating it was not present within common public password dictionaries.

---

## Successful SMB Credential Validation

![CME Authentication Success](screenshots/phase2-cme-authentication-success.png)

CrackMapExec successfully authenticated against internal SMB-enabled systems using the compromised domain credentials.

This confirmed valid domain access and established authenticated interaction with the Active Directory environment.
