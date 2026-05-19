# Telemetry Gaps Identified During Investigation

## 🎯 Overview

This document outlines telemetry limitations and visibility gaps identified during the Solaris Active Directory compromise investigation.

The investigation demonstrated how incomplete logging and limited endpoint visibility can significantly impact:

- attack reconstruction
- adversary tracking
- incident response confidence
- detection engineering effectiveness
- SOC investigative capabilities

The gaps identified throughout the investigation represent realistic challenges commonly encountered in enterprise environments.

---

# ⚠️ PowerShell Visibility Limitations

## Observed Gap

PowerShell visibility was limited during portions of the investigation lifecycle.

This reduced visibility into:

- script-based execution
- encoded PowerShell commands
- in-memory execution activity
- post-exploitation automation
- credential tooling execution

The absence of detailed PowerShell telemetry limited the ability to fully reconstruct attacker behavior.

---

## Impact on Investigation

The limited visibility reduced confidence in:

- command execution reconstruction
- attacker tooling identification
- script execution analysis
- persistence-related activity

Potential attacker actions may have occurred without generating sufficient telemetry for full forensic reconstruction.

---

## Recommended Improvements

Enable:

- PowerShell Script Block Logging
- PowerShell Module Logging
- PowerShell Transcription Logging

Additional recommendations:

- centralize PowerShell logs into SIEM
- increase retention periods
- monitor encoded PowerShell execution

---

# ⚠️ Incomplete Credential Access Visibility

## Observed Gap

Credential dumping activity was identified primarily through Sysmon Event ID 10 telemetry.

However, direct memory extraction visibility remained limited.

The investigation lacked:

- complete memory access context
- full process execution visibility
- detailed forensic telemetry for credential dumping operations

---

## Impact on Investigation

The limited visibility reduced confidence in:

- complete credential theft scope
- tooling attribution
- full attacker credential harvesting activity

The investigation relied heavily on behavioral indicators rather than direct extraction telemetry.

---

## Recommended Improvements

Expand monitoring for:

- Sysmon Event ID 10
- suspicious handle access rights
- unsigned process execution
- suspicious process injection activity
- memory dumping behavior

Additional recommendations:

- integrate EDR telemetry
- expand endpoint forensic visibility
- improve credential access alerting

---

# ⚠️ Limited Kerberos Visibility

## Observed Gap

Kerberos monitoring was primarily limited to Event ID 4769 service ticket requests.

The environment lacked:

- broader Kerberos telemetry correlation
- detailed ticket lifecycle monitoring
- advanced authentication analytics

---

## Impact on Investigation

The investigation identified Kerberoasting-related indicators but lacked complete visibility into:

- ticket extraction activity
- offline cracking behavior
- broader Kerberos abuse scope

---

## Recommended Improvements

Increase monitoring for:

- RC4-encrypted Kerberos tickets
- abnormal ticket request volume
- service account targeting
- unusual client authentication behavior
- privileged service account activity

Additional recommendations:

- baseline Kerberos authentication behavior
- monitor legacy encryption usage
- reduce RC4 Kerberos dependencies

---

# ⚠️ Limited Lateral Movement Visibility

## Observed Gap

The investigation successfully identified WMI-based remote execution activity, but broader lateral movement visibility remained limited.

The environment lacked sufficient telemetry for:

- PsExec execution
- WinRM activity
- scheduled task abuse
- remote service creation
- SMB file transfer visibility

---

## Impact on Investigation

Additional lateral movement techniques may have occurred without generating sufficient telemetry.

The investigation primarily relied on:

- WMI telemetry
- authentication logs
- Sysmon process creation events

---

## Recommended Improvements

Expand monitoring for:

- remote service creation
- scheduled task execution
- WinRM activity
- PsExec execution
- SMB administrative share activity

Additional recommendations:

- increase endpoint telemetry retention
- centralize endpoint event collection
- improve network telemetry visibility

---

# ⚠️ Limited Endpoint Telemetry Retention

## Observed Gap

Certain endpoint telemetry sources contained incomplete historical visibility during portions of the investigation.

This reduced the ability to:

- reconstruct full attack timelines
- correlate older attacker activity
- validate long-term persistence behavior

---

## Impact on Investigation

The investigation required increased reliance on:

- surviving authentication telemetry
- partial Sysmon visibility
- behavioral correlation techniques

rather than complete forensic reconstruction.

---

## Recommended Improvements

Improve:

- SIEM retention policies
- endpoint log retention
- centralized log archival
- telemetry backup procedures

Additional recommendations:

- increase historical search capabilities
- implement long-term endpoint retention
- improve incident reconstruction workflows

---

# 🧠 Strategic Lessons Learned

The investigation demonstrated several important operational realities:

- Visibility gaps directly impact SOC effectiveness
- Endpoint telemetry is critical for attack reconstruction
- Authentication logs alone are insufficient
- Behavioral detections are essential in incomplete environments
- Cross-source telemetry correlation significantly improves investigative confidence

The project also highlighted the importance of:

- layered defensive visibility
- telemetry redundancy
- centralized log collection
- endpoint-focused monitoring strategies

---

# 🎯 Final Assessment

The Solaris Active Directory compromise investigation demonstrated how incomplete telemetry can reduce investigation certainty even when significant adversary activity is successfully identified.

Despite these limitations, effective correlation between:

- authentication telemetry
- Sysmon visibility
- Kerberos activity
- process execution telemetry

allowed reconstruction of a high-confidence adversary intrusion lifecycle within the environment.

The telemetry gaps identified throughout the investigation provide valuable defensive improvement opportunities for future SOC monitoring and incident response maturity.
