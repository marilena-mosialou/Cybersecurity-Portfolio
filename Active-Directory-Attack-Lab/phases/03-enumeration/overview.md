# 🟨 Phase 3 — Active Directory Enumeration & Attack Path Analysis

## 📌 Objective

Enumerate the Active Directory environment to identify domain structure, privilege relationships, group memberships, and potential attack paths toward elevated privileges.

---

# 🎯 Attack Goal

The objective of this phase was to determine:

- What privileges the compromised account possessed
- Whether direct privilege escalation paths existed
- Which domain objects could potentially be abused
- How the Active Directory environment was structured

This phase focused heavily on reconnaissance and attack path validation before attempting additional exploitation activity.

---

# 🧠 Attack Logic

After obtaining valid domain credentials, the next logical step was understanding the internal Active Directory environment.

Modern enterprise attacks frequently rely on enumeration before privilege escalation attempts occur.

BloodHound was used to:

- Collect Active Directory object relationships
- Map users, groups, computers, and ACLs
- Analyze privilege boundaries
- Identify potential escalation opportunities

Enumeration results revealed that the compromised account operated with standard domain user privileges and did not possess a direct path to Domain Admin access.

Although several inbound object control relationships were identified, no immediately exploitable privilege escalation path was confirmed during this phase.

This forced reassessment and reinforced the need for additional credential access and post-exploitation activity.

---

# ⚙️ Actions Performed

The following actions were performed during this phase:

1. Configured DNS resolution against the Domain Controller
2. Executed BloodHound data collection using compromised credentials
3. Enumerated domain users, groups, computers, OUs, and ACLs
4. Imported collected data into BloodHound
5. Analyzed compromised user group memberships
6. Investigated inbound object control relationships
7. Performed pathfinding analysis toward Domain Admins
8. Validated privilege boundaries within the environment

---

# ✅ Outcome

Enumeration successfully mapped the internal Active Directory environment and identified several important security observations.

The compromised account:

```text
SOLARIS\p.olson
```

operated with standard domain user privileges and did not possess a direct privilege escalation path to Domain Admin access.

The analysis identified:

- Standard domain group memberships
- Inbound ACL relationships
- Potential object control paths
- Lack of direct escalation opportunities

This phase confirmed that additional post-exploitation techniques would be required to continue progressing toward domain compromise.

---

# 💥 Security Impact

Successful Active Directory enumeration allowed the attacker to:

- Understand enterprise privilege structure
- Identify privilege boundaries
- Analyze ACL relationships
- Validate attack paths
- Prioritize future attack strategies
- Reduce operational uncertainty

This phase demonstrates how reconnaissance and attack path analysis are critical components of realistic enterprise compromise workflows.

---

# 🔗 Relationship to Later Attack Phases

The enumeration results directly influenced later attack decisions including:

- Lateral movement attempts
- Credential dumping operations
- Privilege escalation strategy
- Service account targeting

The absence of a direct escalation path forced the attacker to pivot toward credential access and post-exploitation techniques in later phases.
