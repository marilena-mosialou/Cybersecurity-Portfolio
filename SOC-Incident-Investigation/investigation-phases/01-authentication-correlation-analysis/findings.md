# Authentication Investigation Findings

## 🚨 Summary of Findings

The investigation identified suspicious remote authentication activity originating from:

```text
192.168.10.250
```

This system was later identified as the Kali Linux host used during the simulated adversary activity inside the lab environment.

Windows authentication telemetry revealed repeated successful Logon Type 3 network authentication events targeting multiple systems within the Active Directory environment.

The observed activity involved:

- User account authentication
- Administrative account authentication
- Service account authentication
- Cross-host remote network logons

---

# 🔍 Key Observations

## Remote Network Authentication Activity

The investigation identified repeated successful Logon Type 3 authentication events against:

- SOLARIS-DC-01
- SOLARIS-PC-01

The authentication activity originated from:

```text
192.168.10.250
```

Logon Type 3 events are commonly associated with:

- SMB authentication
- Remote administration
- Network-based access
- Lateral movement activity

---

# 👤 User and Privileged Account Usage

The investigation identified authentication activity involving:

- p.olson
- Administrator
- svc_backup

The presence of both privileged and service account authentication activity significantly increased the likelihood of credential compromise and unauthorized access within the environment.

---

# 🌐 Authentication Correlation Analysis

Authentication correlation analysis demonstrated:

- Multiple systems accessed from the same source IP
- Repeated remote network authentication activity
- Administrative account usage
- Service account authentication activity
- Authentication spread across the domain environment

The correlation of authentication telemetry across systems strongly suggested coordinated activity rather than isolated administrative behavior.

---

# 🧠 Analyst Assessment

At this stage of the investigation, the authentication telemetry provided strong indicators of suspicious remote access activity but was not independently sufficient to conclusively confirm malicious compromise.

However, several factors significantly elevated the investigation priority:

- Cross-host authentication activity
- Administrative account usage
- Service account authentication
- Repeated network logons from a single external system
- Authentication patterns inconsistent with normal workstation behavior

Later investigation phases involving:

- WMI-based remote execution
- Credential dumping activity
- Kerberoasting behavior
- Domain compromise indicators

ultimately confirmed the activity as part of a broader Active Directory compromise.

---

# ⚠️ Investigation Limitations

Several telemetry limitations were identified during the authentication investigation:

- Limited PowerShell visibility
- Incomplete process-to-authentication correlation
- Limited authentication baselining
- Inconsistent privilege event correlation for Event ID 4672

Despite these limitations, sufficient telemetry existed to identify suspicious remote authentication activity and establish investigative leads for later investigation phases.

---

# 🎯 Conclusion

The authentication investigation identified suspicious remote network authentication activity involving multiple accounts and systems within the Active Directory environment.

The combination of:

- Successful Logon Type 3 events
- Cross-host authentication correlation
- Administrative account usage
- Service account authentication activity

provided strong indicators of unauthorized access activity and established the foundation for subsequent investigation phases that later confirmed adversary compromise within the environment.
