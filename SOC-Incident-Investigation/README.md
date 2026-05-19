# SOC Investigation: Active Directory Compromise Analysis using Splunk

## 📌 Overview

This project documents a full Security Operations Center (SOC) investigation of a simulated Active Directory compromise conducted within a controlled lab environment.

The investigation focused on reconstructing adversary activity through:

- Windows Security Logs
- Sysmon telemetry
- Splunk SIEM correlation
- authentication analysis
- endpoint telemetry investigation
- MITRE ATT&CK mapping

The project demonstrates practical blue-team methodology involving:

- authentication correlation
- threat hunting
- lateral movement analysis
- credential access detection
- Kerberos abuse investigation
- detection engineering
- SOC-oriented incident analysis

The investigation reconstructed a multi-stage compromise involving:

- suspicious remote authentication activity
- domain enumeration behavior
- WMI-based remote execution
- administrative share abuse
- LSASS credential dumping
- Kerberoasting activity
- indicators of privileged domain compromise

---

# 🎯 Project Objectives

The primary goals of this project were to:

- simulate realistic Active Directory attack behavior
- investigate adversary activity using Splunk SIEM
- correlate authentication and endpoint telemetry
- reconstruct attacker behavior across multiple systems
- develop reusable SOC detection analytics
- map observed activity to MITRE ATT&CK techniques
- demonstrate defensive investigation methodology

The project intentionally emphasizes:

- blue-team investigation workflows
- detection engineering
- telemetry correlation
- behavioral analysis
- SOC operational methodology

rather than offensive exploitation.

---

# 🔗 Related Project

This investigation is based on a separate Active Directory attack simulation lab focused on offensive attack execution:

[Active Directory Attack Lab](../Active-Directory-Attack-Lab)

The related project documents:

- attack execution workflows
- adversary tooling usage
- privilege escalation techniques
- Active Directory attack paths
- offensive security methodology

This repository focuses exclusively on the defensive SOC investigation and detection engineering perspective.

---

# 🏗️ Environment Architecture

## Lab Environment

| Component | Description |
|---|---|
| SIEM | Splunk Enterprise |
| Endpoint Telemetry | Windows Security Logs + Sysmon |
| Sysmon Configuration | Olaf Hartong Sysmon Modular |
| Domain Controller | SOLARIS-DC-01 |
| Workstation | SOLARIS-PC-01 |
| Attacker System | Kali Linux |
| Domain | SOLARIS.LOCAL |

---

# 📂 Project Structure

```text
SOC-Incident-Investigation/
│
├── architecture/
│   ├── soc-lab-topology.png
│   ├── attack-path-flow.png
│   └── telemetry-flow.png
│
├── investigation-phases/
│   ├── 01-authentication-correlation-analysis/
│   ├── 02-domain-enumeration-analysis/
│   ├── 03-wmi-lateral-movement-analysis/
│   ├── 04-credential-dumping-analysis/
│   ├── 05-kerberos-abuse-analysis/
│   └── 06-domain-compromise-assessment/
│
├── detection-rules/
│   ├── README.md
│   ├── splunk/
│   └── sigma/
│
├── lessons-learned/
│   ├── telemetry-gaps.md
│   ├── detection-improvements.md
│   └── hardening-recommendations.md
│
├── mitre-attack-mapping.md
│
└── README.md
```

---

# 🔍 Investigation Workflow

The investigation followed a structured SOC-oriented methodology:

1. Identify suspicious authentication activity
2. Correlate authentication events across systems
3. Investigate domain reconnaissance behavior
4. Detect lateral movement activity
5. Identify credential dumping behavior
6. Analyze Kerberos abuse activity
7. Assess indicators of domain compromise
8. Map findings to MITRE ATT&CK techniques
9. Develop reusable detection analytics
10. Document defensive improvement opportunities

---

# 🧠 Investigation Phases

| Phase | Focus Area |
|---|---|
| Phase 1 | Authentication Correlation Analysis |
| Phase 2 | Domain Enumeration Analysis |
| Phase 3 | WMI Lateral Movement Analysis |
| Phase 4 | Credential Dumping Analysis |
| Phase 5 | Kerberos Abuse Analysis |
| Phase 6 | Domain Compromise Assessment |

Each investigation phase contains:

- overview documentation
- detection queries
- findings analysis
- supporting screenshots
- telemetry correlation evidence

---

# 🛡️ Detection Engineering

The project includes a dedicated detection engineering section containing:

## Splunk Detection Analytics

Reusable SOC detection content for:

- suspicious authentication activity
- privileged group enumeration
- WMI remote execution
- ADMIN$ share abuse
- LSASS memory access
- Kerberoasting activity

## Sigma Rules

Vendor-agnostic detection rules aligned to:

- MITRE ATT&CK techniques
- behavioral analytics
- credential access monitoring
- lateral movement detection
- Active Directory attack activity

The detection engineering content was developed directly from adversary behaviors identified during the investigation lifecycle.

---

# 📊 MITRE ATT&CK Mapping

The investigation maps observed adversary behaviors to multiple MITRE ATT&CK techniques including:

| ATT&CK ID | Technique |
|---|---|
| T1078 | Valid Accounts |
| T1069 | Permission Groups Discovery |
| T1047 | Windows Management Instrumentation |
| T1021.002 | SMB/Windows Admin Shares |
| T1003.001 | OS Credential Dumping: LSASS Memory |
| T1558.003 | Kerberoasting |
| T1558 | Steal or Forge Kerberos Tickets |

Detailed ATT&CK mappings are documented in:

```text
mitre-attack-mapping.md
```

---

# ⚠️ Lessons Learned

The project also documents defensive improvement opportunities identified throughout the investigation, including:

- telemetry visibility gaps
- detection engineering improvements
- authentication monitoring enhancements
- Kerberos monitoring recommendations
- Active Directory hardening guidance
- SOC operational lessons learned

These findings are documented within:

```text
lessons-learned/
```

---

# 🛠️ Tools and Technologies Used

| Technology | Purpose |
|---|---|
| Splunk Enterprise | SIEM and log analysis |
| Sysmon | Endpoint telemetry collection |
| Windows Security Logs | Authentication and security monitoring |
| Kali Linux | Adversary simulation |
| MITRE ATT&CK | Adversary behavior mapping |
| Sigma | Vendor-agnostic detection engineering |
| Sysmon Modular | Advanced Sysmon configuration |
| Active Directory | Enterprise identity infrastructure |

---

# 📚 References

- MITRE ATT&CK Framework
- SigmaHQ Detection Rules
- Olaf Hartong Sysmon Modular Configuration
- Splunk Documentation
- Microsoft Security Auditing Documentation

---

# 🎯 Key Skills Demonstrated

This project demonstrates practical experience with:

- SOC investigations
- Splunk SIEM analysis
- threat hunting
- authentication correlation
- endpoint telemetry analysis
- detection engineering
- Sigma rule development
- MITRE ATT&CK mapping
- Kerberos abuse analysis
- Active Directory security investigations
- incident documentation
- defensive security analysis

---

# ✅ Final Assessment

This project demonstrates a practical blue-team investigation workflow for analyzing and reconstructing a multi-stage Active Directory compromise using Splunk SIEM and endpoint telemetry correlation.

The investigation emphasizes:

- defensive security methodology
- behavioral analytics
- detection engineering
- SOC operational workflows
- ATT&CK-aligned analysis
- telemetry-driven investigations

The project was designed to reflect realistic SOC investigation practices and defensive security engineering methodologies commonly used within enterprise environments.
