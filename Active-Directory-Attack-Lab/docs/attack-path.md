# ⚔️ Attack Path Analysis

## 📌 Purpose

This document provides a detailed analysis of the attack path used throughout the Active Directory compromise simulation.

The objective of the attack chain was to simulate realistic adversary behavior within a Windows enterprise environment, demonstrating how multiple weaknesses and misconfigurations can be chained together to achieve full domain compromise.

Rather than relying on a single vulnerability, the attack progression emphasizes:

- Credential abuse
- Misconfiguration exploitation
- Privilege boundary analysis
- Adaptive attacker decision-making
- Multi-stage compromise workflows

---

# 🧭 Attack Flow Overview

![Attack Flow Diagram](../diagrams/attack-flow-diagram.png)

---

# 🎯 Attack Objectives

The attack simulation was designed to achieve the following objectives:

- Obtain initial domain credentials
- Enumerate Active Directory relationships
- Identify privilege escalation opportunities
- Attempt lateral movement across domain systems
- Extract reusable credentials from memory
- Abuse service account exposure
- Achieve Domain Controller access
- Extract Active Directory credential database (NTDS.dit)

---

# 🔗 Attack Chain Summary

| Phase | Objective | Technique | Primary Tool | Result |
|---|---|---|---|---|
| 1 | Initial Access | LLMNR/NBT-NS Poisoning | Responder | NTLMv2 Hash Captured |
| 2 | Credential Validation | Password Spraying / Validation | CrackMapExec | Valid Credentials Identified |
| 3 | Domain Enumeration | AD Relationship Mapping | BloodHound | No Direct PrivEsc Path |
| 4 | Lateral Movement Attempt | Remote Execution | Impacket | Access Denied |
| 5 | Credential Access | LSASS Memory Dumping | ProcDump + pypykatz | Administrator Credentials Recovered |
| 6 | Administrative Access | SMB Administrative Share Access | smbclient | Domain Controller Access |
| 7 | Service Account Abuse | Kerberoasting | Impacket + John | Service Account Password Recovered |
| 8 | Domain Compromise | NTDS.dit Extraction | secretsdump | Full Domain Compromise |

---

# ⚠️ Initial Conditions & Assumptions

The attack simulation assumes the adversary has:

- Network-level access to the internal environment
- Ability to observe local network traffic
- No initial privileged credentials
- No malware or persistence mechanisms deployed initially
- No endpoint detection and response (EDR) solution active

The environment intentionally contains realistic enterprise weaknesses including:

- LLMNR/NBT-NS enabled
- Weak password practices
- SMB administrative exposure
- Service accounts with SPNs configured
- Incomplete endpoint hardening

---

# 🟥 Phase 1 — Initial Foothold via LLMNR/NBT-NS Poisoning

## Objective

Obtain valid authentication material from the internal network.

## Attack Logic

The environment contained systems with LLMNR and NetBIOS Name Service enabled. These protocols allow systems to perform local network name resolution when DNS queries fail.

Attackers commonly abuse this behavior using tools such as Responder to intercept authentication attempts and coerce systems into authenticating against rogue SMB services.

## Actions Performed

- Verified LLMNR/NBT-NS exposure
- Configured Responder on the attacker system
- Intercepted broadcast name resolution traffic
- Captured NTLMv2 authentication material

## Result

A valid NTLMv2 hash for domain user:

```text
SOLARIS\p.olson
```

was successfully captured.

## Operational Significance

This phase demonstrates how insecure legacy name resolution protocols can expose authentication material without requiring malware execution or direct exploitation.

## Outcome

- Initial credential material obtained
- Valid domain user identified
- Foothold established within the environment

---

# 🟧 Phase 2 — Credential Validation & Access Verification

## Objective

Determine whether captured authentication material could be leveraged for domain access.

## Attack Logic

Initial offline password cracking attempts were unsuccessful, indicating the password was not present within common public wordlists.

Rather than relying solely on cracking, the attack path pivoted toward credential validation and authentication testing against internal systems.

This reflects realistic attacker behavior where operators frequently transition between credential attack strategies based on environmental conditions.

## Actions Performed

- Attempted offline cracking using Hashcat and rockyou.txt
- Tested credential validity across internal systems using CrackMapExec
- Identified successful authentication using weak password patterns

## Result

Valid domain credentials were confirmed for the compromised account.

## Operational Significance

This phase demonstrates how weak password practices and credential reuse can allow attackers to progress even when offline cracking is unsuccessful.

## Outcome

- Valid domain authentication achieved
- Internal access confirmed
- Attack progression enabled

---

# 🟨 Phase 3 — Active Directory Enumeration

## Objective

Map domain relationships and identify privilege escalation opportunities.

## Attack Logic

After obtaining valid credentials, the next priority was understanding the domain structure, group memberships, permissions, and potential attack paths.

BloodHound was used to enumerate Active Directory relationships and visualize privilege boundaries.

Importantly, no direct path to Domain Admin privileges was identified.

This reflects realistic enterprise conditions where attackers often require additional credential access or post-exploitation activity to continue progressing.

## Actions Performed

- Configured attacker DNS for domain resolution
- Executed BloodHound data collection
- Enumerated users, groups, computers, and ACL relationships
- Analyzed inbound object control permissions
- Performed pathfinding analysis toward Domain Admins

## Result

The compromised account possessed standard user privileges only.

No direct privilege escalation path was identified.

## Operational Significance

This phase demonstrates the importance of enumeration and attack path validation before exploitation attempts.

## Outcome

- Domain structure mapped
- ACL relationships identified
- Privilege boundaries confirmed
- Need for additional credential access established

---

# 🟦 Phase 4 — Lateral Movement Attempt

## Objective

Attempt remote command execution using compromised credentials.

## Attack Logic

With valid credentials available, remote execution attempts were performed against internal systems using Impacket tooling.

However, authentication success alone did not provide sufficient privileges for remote administrative execution.

This phase intentionally demonstrates the distinction between:

- Valid authentication
- Administrative authorization

## Actions Performed

- Attempted SMB-based remote execution using psexec
- Attempted WMI-based execution using wmiexec
- Tested access to administrative shares

## Result

Authentication succeeded, but remote administrative execution was denied.

## Operational Significance

This phase highlights how properly enforced privilege boundaries can limit attacker progression even after credential compromise.

## Outcome

- Remote authentication confirmed
- Administrative execution denied
- Additional privilege escalation required

---

# 🟪 Phase 5 — Credential Access via LSASS Memory Dumping

## Objective

Extract reusable high-privileged credentials from memory.

## Attack Logic

Following failed privilege escalation attempts, focus shifted toward credential access techniques.

LSASS memory dumping was performed to identify reusable authentication material stored within memory on the compromised system.

The initial dump did not reveal usable credentials.

To generate additional credential material, authentication activity was intentionally triggered to create a new logon session.

A second memory dump successfully exposed privileged credentials.

This attack path demonstrates realistic attacker adaptation following failed post-exploitation attempts.

## Actions Performed

- Created LSASS memory dump using ProcDump
- Parsed dump using pypykatz
- Triggered authentication activity
- Repeated LSASS dumping process
- Extracted privileged credential material

## Result

Administrator credentials were successfully recovered from memory.

## Operational Significance

This phase demonstrates the significant security impact of credential material residing within LSASS memory.

## Outcome

- High-privileged credentials obtained
- Privilege escalation achieved
- Administrative authentication enabled

---

# 🟫 Phase 6 — Administrative SMB Access

## Objective

Validate administrative access against the Domain Controller.

## Attack Logic

Recovered Administrator credentials were used to authenticate against administrative SMB shares on the Domain Controller.

Successful access confirmed administrative control over the target system.

## Actions Performed

- Authenticated to the Domain Controller via SMB
- Accessed administrative shares
- Navigated protected system directories
- Verified access to credential storage locations

## Result

Administrative-level access to the Domain Controller was confirmed.

## Operational Significance

Administrative SMB share access is commonly leveraged by attackers for:

- Remote administration abuse
- Credential extraction
- Tool deployment
- Persistence
- Ransomware operations

## Outcome

- Administrative access validated
- Sensitive system locations accessible
- Domain compromise progression enabled

---

# 🟩 Phase 7 — Kerberoasting & Service Account Abuse

## Objective

Identify and abuse exposed service accounts with Service Principal Names (SPNs).

## Attack Logic

Kerberoasting targets service accounts associated with SPNs by requesting Kerberos service tickets that can later be cracked offline.

This attack technique is particularly effective against weak service account passwords.

## Actions Performed

- Enumerated SPNs using Impacket
- Identified exposed service account
- Requested Kerberos service ticket (TGS)
- Extracted Kerberos hash
- Performed offline cracking using custom wordlists

## Result

Credentials for service account:

```text
svc_backup
```

were successfully recovered.

## Operational Significance

This phase demonstrates how weak service account hygiene significantly increases Active Directory attack surface exposure.

## Outcome

- Additional credentials obtained
- Backup Operators exposure identified
- Additional privilege abuse path explored

---

# 🟨 Backup Operators Privilege Abuse Attempt

## Objective

Attempt credential database extraction using Backup Operators privileges.

## Attack Logic

Members of the Backup Operators group possess elevated privileges capable of interacting with sensitive system files including NTDS.dit.

The attack attempted to leverage these privileges for remote domain extraction.

## Actions Performed

- Attempted DRSUAPI extraction
- Attempted VSS-based extraction
- Tested remote privilege capabilities

## Result

Backup Operators privileges alone were insufficient for successful remote extraction within the configured environment.

## Operational Significance

This phase intentionally demonstrates that elevated group membership does not always guarantee successful exploitation.

## Outcome

- Remote abuse attempt failed
- Privilege limitations confirmed
- Pivot back to Administrator credentials required

---

# 🟥 Phase 8 — Full Domain Compromise

## Objective

Extract the Active Directory credential database from the Domain Controller.

## Attack Logic

Previously recovered Administrator credentials were leveraged to perform NTDS.dit extraction using Impacket secretsdump.

Extraction of the NTDS database enabled recovery of:

- Domain user NTLM hashes
- Kerberos encryption keys
- krbtgt account credentials

Compromise of the krbtgt account enables potential Golden Ticket attacks and persistent domain-level access.

## Actions Performed

- Authenticated to Domain Controller remotely
- Executed secretsdump
- Extracted NTDS.dit credential data
- Retrieved domain-wide credential material

## Result

Full Active Directory compromise was achieved.

## Operational Significance

This phase represents complete compromise of enterprise identity infrastructure.

## Outcome

- Domain credential database extracted
- Domain-wide credential exposure achieved
- Persistent attack capability established

---

# 🔄 Operational Pivot Analysis

A key objective of this lab was demonstrating realistic attacker adaptation throughout the compromise lifecycle.

Several attack paths intentionally failed, requiring reassessment and alternative approaches.

## Examples of Operational Pivots

| Failed Path | Pivot |
|---|---|
| Password cracking unsuccessful | Credential validation via CrackMapExec |
| No direct BloodHound privilege escalation path | Post-exploitation credential access |
| Remote execution denied | LSASS dumping |
| Backup Operators abuse unsuccessful | Administrator credential abuse |

This reflects realistic attacker methodology where compromise progression often depends on persistence and adaptive decision-making rather than a single successful exploit.

---

# 📊 Detection Considerations

The attack chain generated multiple observable security events across the environment.

## Observable Activity Included

- LLMNR/NBT-NS poisoning traffic
- Authentication anomalies
- Kerberos service ticket requests
- LSASS memory access
- SMB administrative authentication
- Remote execution attempts
- Credential dumping activity

## Relevant Event Sources

| Event Source | Purpose |
|---|---|
| Sysmon Event ID 1 | Process creation |
| Sysmon Event ID 10 | LSASS access monitoring |
| Windows Event ID 4624 | Successful logons |
| Windows Event ID 4625 | Failed logons |
| Windows Event ID 4769 | Kerberos TGS requests |

Detailed investigation and detection engineering workflows are documented in the associated SOC investigation project.

---

# 🛡️ Defensive Lessons

The attack chain demonstrates how multiple low-to-medium severity weaknesses can combine to create critical enterprise risk.

Key defensive takeaways include:

- Disable LLMNR/NBT-NS
- Enforce strong password policies
- Harden LSASS protections
- Restrict administrative SMB access
- Monitor abnormal Kerberos activity
- Apply least privilege principles
- Monitor credential access behaviors
- Implement endpoint detection and response (EDR)

---

# 🚀 Key Takeaways

This attack path demonstrates:

- Realistic multi-stage Active Directory compromise workflows
- Credential-based attack progression
- Adaptive attacker methodology
- Enterprise attack path analysis
- Practical use of offensive tooling
- Privilege boundary enforcement behavior
- Relationship between offensive operations and defensive visibility
