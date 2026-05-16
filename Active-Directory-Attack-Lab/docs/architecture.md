# 🏗️ Architecture Overview

## 📌 Purpose

This document provides a detailed overview of the Active Directory attack lab architecture, including network segmentation, system roles, monitoring infrastructure, domain configuration, and intentionally introduced weaknesses used throughout the attack simulation.

The environment was designed to simulate a realistic small-to-mid-sized enterprise network with centralized identity management, endpoint monitoring, and common Active Directory misconfigurations.

---

# 🌐 Lab Architecture Diagram

![Architecture Diagram](../diagrams/ad-attack-monitoring-lab-architecture.png)

---

# 🎯 Architecture Objectives

The lab was designed to achieve the following objectives:

- Simulate a realistic enterprise Active Directory environment
- Demonstrate offensive security attack paths within Windows domains
- Provide centralized logging and visibility through Splunk
- Replicate common enterprise misconfigurations
- Support both red-team and blue-team workflows
- Enable credential abuse, lateral movement, and privilege escalation scenarios

---

# 🖥️ Infrastructure Overview

The environment consists of four primary systems:

| Hostname | Role | Operating System | IP Address |
|---|---|---|---|
| SOLARIS-DC-01 | Domain Controller | Windows Server 2022 | 192.168.10.7 |
| SOLARIS-PC-01 | Domain Workstation | Windows 11 | 192.168.10.100 |
| Kali Linux | Attacker System | Kali Linux | 192.168.10.250 |
| Splunk Server | SIEM / Monitoring | Ubuntu Server | 192.168.10.10 |

---

# 🧱 Network Topology

## Internal Domain Network

The internal enterprise network operates within the following subnet:

```text
192.168.10.0/24
```

The Active Directory domain used throughout the environment is:

```text
solaris.local
```

The network was intentionally designed as a flat internal environment to replicate common small and mid-sized enterprise deployments where excessive trust relationships and limited segmentation increase attack surface exposure.

---

# 🏢 Active Directory Infrastructure

## Domain Controller — SOLARIS-DC-01

The Domain Controller serves as the core identity and authentication system for the environment.

### Core Services

- Active Directory Domain Services (AD DS)
- DNS
- Kerberos Authentication
- Windows Event Logging

### Security Monitoring

- Sysmon Installed
- Windows Security Event Logging Enabled
- Splunk Universal Forwarder Configured

### Purpose Within the Lab

The Domain Controller functions as:

- Central authentication authority
- Kerberos ticketing server
- Active Directory database host
- Primary lateral movement target
- Final domain compromise objective

---

# 💻 Domain Workstation — SOLARIS-PC-01

The Windows 11 workstation simulates a standard enterprise user endpoint joined to the domain.

### Installed Components

- Sysmon
- Windows PowerShell Logging
- Windows Event Logging
- Splunk Universal Forwarder

### Purpose Within the Lab

The workstation was used to simulate:

- User authentication activity
- Initial credential exposure
- Endpoint-based credential dumping
- Lateral movement attempts
- Post-compromise credential harvesting

---

# 🛠️ Attacker System — Kali Linux

The Kali Linux system represents the adversary simulation platform used throughout the attack chain.

### Offensive Tooling Used

- Responder
- CrackMapExec
- BloodHound
- Impacket
- Hashcat
- John the Ripper
- smbclient
- pypykatz

### Purpose Within the Lab

The attacker system was responsible for:

- Network reconnaissance
- Credential harvesting
- Password attacks
- Active Directory enumeration
- Remote authentication attempts
- Credential dumping analysis
- NTDS.dit extraction operations

---

# 📊 Security Monitoring Infrastructure

## Splunk Server

The Splunk server functions as the centralized monitoring and log analysis platform within the environment.

### Log Sources

- Sysmon Events
- Windows Security Logs
- Authentication Events
- PowerShell Logging
- Process Creation Activity

### Purpose Within the Lab

The Splunk environment enables:

- Detection visibility
- Authentication monitoring
- Process execution tracking
- Lateral movement analysis
- Credential access detection
- SOC investigation workflows

This monitoring infrastructure supports the associated SOC investigation project linked to this repository.

---

# 👥 Active Directory Organizational Structure

The environment includes multiple Organizational Units (OUs) to simulate enterprise user segmentation and privilege distribution.

## Organizational Units

- Executives
- Creative
- Finance
- IT-Admin
- Service Accounts

### Design Purpose

The OU structure was intentionally designed to:

- Simulate realistic enterprise departments
- Organize users and permissions
- Create privilege boundaries
- Support attack path enumeration
- Replicate common enterprise identity structures

---

# ⚙️ Automated Provisioning

The Active Directory environment was provisioned using PowerShell automation rather than manual configuration.

## Provisioning Components

- User creation
- Group assignment
- OU population
- Attribute assignment
- Password assignment

### Benefits of Automation

Using scripted provisioning improves:

- Scalability
- Repeatability
- Consistency
- Enterprise realism
- Infrastructure reproducibility

The provisioning script is available in:

```text
/scripts/provision.ps1
```

---

# ⚠️ Intentional Security Weaknesses

Several controlled misconfigurations were intentionally introduced to simulate realistic enterprise attack surface exposure.

| Weakness | Purpose |
|---|---|
| LLMNR & NetBIOS Enabled | Simulate broadcast poisoning exposure |
| Weak Password Practices | Enable credential attacks |
| SMBv1 Enabled | Simulate legacy protocol exposure |
| Overprivileged Accounts | Support privilege abuse scenarios |
| Service Accounts with SPNs | Enable Kerberoasting |
| Partial Defender Hardening Gaps | Simulate incomplete endpoint protection |
| SMB Administrative Exposure | Enable post-compromise lateral movement |

---

# 🔐 Authentication & Identity Flow

The environment relies primarily on Kerberos authentication within the domain.

Authentication workflows include:

- Interactive user logons
- SMB authentication
- Kerberos ticket requests
- NTLM fallback scenarios
- Service account authentication

These authentication mechanisms become central to several attack phases including:

- LLMNR/NBT-NS poisoning attacks
- Credential validation
- Kerberoasting
- SMB administrative access
- Pass-the-hash style authentication workflows

---

# 📈 Monitoring & Logging Design

The monitoring architecture was intentionally designed to provide visibility into attacker behavior during all major attack phases.

## Monitored Activity Includes

- Process creation
- Authentication attempts
- Kerberos ticket requests
- LSASS access
- SMB activity
- PowerShell execution
- Remote authentication events

## Relevant Event Sources

| Source | Purpose |
|---|---|
| Sysmon Event ID 1 | Process creation |
| Sysmon Event ID 10 | Process access (LSASS monitoring) |
| Windows Event ID 4624 | Successful logons |
| Windows Event ID 4625 | Failed logons |
| Windows Event ID 4769 | Kerberos service ticket requests |

---

# 🔗 Trust Boundary Considerations

The architecture intentionally includes limited segmentation between attacker-controlled systems and internal resources to replicate realistic enterprise weaknesses.

The lab demonstrates how insufficient segmentation and weak authentication practices can allow attackers to pivot from initial access toward full Active Directory compromise.

---

# 🧠 Architectural Design Philosophy

The environment was intentionally built to balance:

- Offensive realism
- Defensive visibility
- Enterprise simulation
- Operational simplicity
- Repeatable attack workflows

The architecture emphasizes realistic attacker methodology rather than isolated tool demonstrations.

This allows the lab to simulate:

- Multi-stage compromise chains
- Failed exploitation attempts
- Privilege boundary enforcement
- Adaptive attacker behavior
- Credential-based attack progression

---

# 🚀 Key Takeaways

This architecture demonstrates:

- Enterprise Active Directory deployment concepts
- Windows authentication workflows
- Centralized logging and monitoring integration
- Realistic enterprise misconfiguration exposure
- End-to-end attack path simulation
- Integration between offensive operations and defensive visibility
