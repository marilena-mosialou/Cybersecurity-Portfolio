# Detection Rules

## 🎯 Overview

This directory contains detection engineering content developed during the Solaris Active Directory SOC investigation project.

The purpose of these detections is to operationalize adversary behaviors identified throughout the investigation into reusable defensive analytics suitable for Security Operations Center (SOC) environments.

The detection content focuses on identifying:

- Suspicious authentication activity
- Domain enumeration behavior
- WMI-based remote execution
- Administrative share abuse
- Credential dumping activity
- Kerberos abuse and Kerberoasting behavior

The detections were developed using telemetry observed during the investigation phases documented throughout this project.

---

# 🛡️ Detection Engineering Goals

The primary goals of this section are to demonstrate:

- SOC detection engineering methodology
- Defensive analytics development
- ATT&CK-aligned detection logic
- Telemetry correlation techniques
- Threat-informed monitoring strategies
- Reusable blue-team detection content

The detection logic was intentionally generalized to support reusable SOC monitoring rather than investigation-specific IOC matching.

---

# 📂 Directory Structure

```text
detection-rules/
├── README.md
├── splunk/
│   ├── suspicious_authentication.md
│   ├── domain_enumeration.md
│   ├── wmi_remote_execution.md
│   ├── admin_share_activity.md
│   ├── lsass_memory_access.md
│   └── kerberoasting_activity.md
│
└── sigma/
    ├── suspicious_authentication.yml
    ├── domain_enumeration.yml
    ├── wmi_remote_execution.yml
    ├── admin_share_activity.yml
    ├── lsass_memory_access.yml
    └── kerberoasting_activity.yml
```

---

# 🔎 Splunk Detection Analytics

The `splunk/` directory contains generalized Splunk detection analytics developed from behaviors identified during the investigation.

These detections include:

- SPL queries
- ATT&CK mappings
- detection logic explanations
- false positive considerations
- SOC investigation guidance

The detections were designed to emphasize:

- behavioral detection
- telemetry correlation
- scalable monitoring logic
- reusable SOC analytics

rather than hardcoded investigation-specific indicators.

---

# 🌐 Sigma Rules

The `sigma/` directory contains vendor-agnostic Sigma detection rules derived from the investigation findings.

The Sigma rules provide:

- portable detection logic
- ATT&CK-aligned analytics
- cross-platform defensive content
- reusable threat detection methodology

The rules focus on adversary behaviors including:

- remote authentication abuse
- reconnaissance activity
- WMI-based execution
- credential dumping
- Kerberoasting activity

---

# 🧠 Detection Engineering Methodology

The detection content throughout this directory follows several defensive engineering principles:

- Behavior-based detection over IOC-only matching
- Cross-source telemetry correlation
- ATT&CK-aligned monitoring
- False positive awareness
- Scalable SOC analytics
- Reusable detection logic

The project intentionally separates:

- investigation-specific queries
from:
- generalized production-oriented detections

to better reflect realistic SOC workflows and defensive engineering practices.

---

# ⚠️ Detection Tuning Considerations

Several detections include threshold-based logic intended for generalized SOC environments.

Thresholds may require adjustment depending on:

- organization size
- authentication volume
- administrative tooling
- baseline operational activity
- telemetry retention policies

Smaller lab environments may generate significantly lower telemetry volume compared to enterprise environments.

---

# 🔗 Relationship to Investigation Phases

The detections within this directory were developed based on adversary behaviors identified throughout the investigation phases, including:

| Investigation Phase | Detection Focus |
|---|---|
| Authentication Correlation Analysis | Suspicious authentication activity |
| Domain Enumeration Analysis | Privileged group discovery |
| WMI Lateral Movement Analysis | Remote execution detection |
| Credential Dumping Analysis | LSASS access monitoring |
| Kerberos Abuse Analysis | Kerberoasting detection |
| Domain Compromise Assessment | Cross-phase correlation logic |

The detection content represents the operationalization of investigative findings into reusable SOC monitoring analytics.

---

# 🎯 Final Notes

This directory demonstrates how adversary behaviors identified during incident investigations can be translated into reusable defensive analytics suitable for real-world SOC operations.

The detection engineering content emphasizes:

- practical blue-team methodology
- telemetry-driven detection development
- SOC operational realism
- behavioral monitoring strategies
- defensive investigation maturity
