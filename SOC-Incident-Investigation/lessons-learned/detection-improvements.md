# Detection Engineering Improvements

## 🎯 Overview

This document outlines detection engineering improvement opportunities identified during the Solaris Active Directory compromise investigation.

The recommendations focus on improving:

- SOC monitoring capabilities
- behavioral detection quality
- telemetry correlation
- alert prioritization
- attack visibility
- detection engineering maturity

The recommendations were developed directly from adversary behaviors observed throughout the investigation lifecycle.

---

# 🔍 Improve Correlation-Based Detection Logic

## Current Limitation

Several attack phases required manual analyst correlation between:

- authentication activity
- endpoint telemetry
- Kerberos events
- privilege assignment activity
- remote execution behavior

The environment lacked automated multi-source correlation capabilities.

---

## Recommended Improvements

Develop correlation analytics combining:

- Event ID 4624 authentication activity
- Sysmon process creation events
- Kerberos ticket requests
- privilege assignment events
- service account usage

---

## Security Benefit

Improves detection of:

- coordinated adversary activity
- attack progression behavior
- privilege escalation sequences
- multi-stage compromise activity

---

# 🔍 Improve Behavioral Authentication Analytics

## Current Limitation

Authentication monitoring primarily relied on individual event analysis rather than behavioral baselining.

---

## Recommended Improvements

Implement detections for:

- abnormal Logon Type 3 volume
- cross-host authentication behavior
- service account anomalies
- unusual administrative activity
- abnormal authentication timing

---

## Security Benefit

Improves detection of:

- lateral movement
- credential abuse
- unauthorized remote access
- compromised privileged accounts

---

# 🔍 Expand Credential Dumping Detections

## Current Limitation

Credential dumping detection relied heavily on direct LSASS access telemetry.

Additional credential theft techniques may not generate equivalent visibility.

---

## Recommended Improvements

Expand monitoring for:

- suspicious handle access
- unsigned credential tooling
- process injection behavior
- suspicious PowerShell execution
- memory dumping activity

---

## Security Benefit

Improves detection of:

- Mimikatz execution
- ProcDump activity
- in-memory credential theft
- post-exploitation credential harvesting

---

# 🔍 Improve Kerberos Abuse Monitoring

## Current Limitation

Kerberos abuse visibility focused primarily on Event ID 4769 analysis.

The environment lacked broader Kerberos anomaly detection capabilities.

---

## Recommended Improvements

Develop detections for:

- RC4 ticket anomalies
- abnormal TGS request volume
- service account targeting
- unusual Kerberos client behavior
- privileged service account abuse

---

## Security Benefit

Improves detection of:

- Kerberoasting
- credential access activity
- service account abuse
- privilege escalation preparation

---

# 🔍 Improve Lateral Movement Detection Coverage

## Current Limitation

The investigation successfully identified WMI-based remote execution activity but lacked broader lateral movement monitoring.

---

## Recommended Improvements

Expand detection coverage for:

- PsExec execution
- WinRM activity
- SMB administrative shares
- remote service creation
- scheduled task abuse

---

## Security Benefit

Improves detection of:

- remote execution activity
- lateral movement behavior
- cross-host compromise
- remote payload staging

---

# 🔍 Implement Risk-Based Alerting

## Current Limitation

The environment lacked centralized risk-based alert prioritization.

Individual alerts generated limited context without behavioral correlation.

---

## Recommended Improvements

Implement weighted alert scoring for:

- credential dumping activity
- Kerberos abuse
- suspicious authentication behavior
- remote execution activity
- privileged account usage

---

## Security Benefit

Improves:

- SOC triage efficiency
- alert prioritization
- incident confidence scoring
- analyst investigation workflow

---

# 🧠 Strategic Detection Engineering Lessons

The investigation demonstrated several important defensive engineering principles:

- Behavioral analytics are more resilient than IOC-only detections
- Threshold tuning is environment-dependent
- Cross-source telemetry correlation significantly improves confidence
- Detection engineering is iterative
- Small environments require different tuning strategies than enterprise environments

The investigation also reinforced the importance of:

- layered monitoring
- telemetry normalization
- reusable analytics
- ATT&CK-aligned detection engineering

---

# 🎯 Final Assessment

The Solaris Active Directory compromise investigation highlighted multiple opportunities to improve SOC monitoring and detection engineering maturity.

The investigation demonstrated how:

- authentication telemetry,
- endpoint visibility,
- Kerberos monitoring,
- and behavioral analytics

can be combined to significantly improve enterprise detection capabilities and attack visibility.

The lessons learned throughout the investigation provide a strong foundation for future defensive engineering improvements and SOC operational maturity.
