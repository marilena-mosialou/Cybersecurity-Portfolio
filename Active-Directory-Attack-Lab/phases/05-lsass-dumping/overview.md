# 🟥 Phase 5 — LSASS Memory Dumping & Credential Extraction

## 📌 Objective

Obtain elevated credentials by extracting authentication material from LSASS memory on a compromised Windows system.

---

# 🎯 Attack Goal

The objective of this phase was to escalate privileges after failed lateral movement attempts by targeting credential material stored in Windows memory.

This phase focused on:

- LSASS memory acquisition
- Offline credential extraction
- Authentication session abuse
- Recovery of reusable privileged credentials

---

# 🧠 Attack Logic

After lateral movement attempts failed due to insufficient privileges, the attack strategy pivoted toward credential access and post-exploitation techniques.

Windows systems frequently store authentication material within the Local Security Authority Subsystem Service (LSASS) process.

Attackers commonly target LSASS because it may contain:

- NTLM hashes
- Kerberos tickets
- cached credentials
- cleartext passwords
- DPAPI material

An initial LSASS dump did not reveal reusable privileged credentials.

This indicated that no active or recently authenticated high-privileged sessions were present in memory at the time of acquisition.

To address this limitation, an additional authentication event was intentionally triggered using SMB authentication.

This generated a new logon session and caused privileged authentication material to become resident within LSASS memory.

A second memory dump was then performed and analyzed successfully.

This phase demonstrates realistic attacker adaptation and operational reassessment during post-exploitation activity.

---

# ⚙️ Actions Performed

The following actions were performed during this phase:

1. Executed LSASS memory dump using ProcDump
2. Transferred dump file to attacker system
3. Parsed memory dump using pypykatz
4. Analyzed extracted authentication sessions
5. Identified absence of reusable privileged credentials in the initial dump
6. Triggered SMB authentication using privileged credentials
7. Generated a new authentication session within LSASS
8. Performed a second LSASS dump
9. Re-analyzed updated dump using pypykatz
10. Extracted high-privileged credentials from memory

---

# ✅ Outcome

Credential extraction from LSASS memory successfully exposed high-privileged authentication material.

Recovered credentials included:

- NTLM hash
- cleartext password
- administrative authentication sessions

The extracted credentials belonged to:

```text
SOLARIS\Administrator
```

This phase established privileged access within the environment and enabled successful lateral movement and domain compromise in later attack stages.

---

# 💥 Security Impact

Successful LSASS credential dumping can allow attackers to:

- Recover privileged credentials
- Escalate privileges rapidly
- Perform pass-the-hash attacks
- Conduct lateral movement
- Establish administrative persistence
- Compromise Active Directory environments

This phase demonstrates the significant security risk associated with credential exposure within memory on active Windows systems.

---

# 🔗 Relationship to Later Attack Phases

The privileged credentials recovered during this phase directly enabled:

- Administrative SMB access
- Remote system interaction
- NTDS.dit extraction
- Full domain compromise

This phase served as the primary privilege escalation point within the attack chain.
