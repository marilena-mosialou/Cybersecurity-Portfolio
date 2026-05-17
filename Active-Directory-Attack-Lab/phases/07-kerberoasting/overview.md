# 🟧 Phase 7 — Kerberoasting & Service Account Credential Extraction

## 📌 Objective

Identify Kerberos service accounts with exposed Service Principal Names (SPNs) and perform offline password cracking against extracted Kerberos service tickets.

---

# 🎯 Attack Goal

The objective of this phase was to identify Kerberoastable service accounts within the Active Directory environment and determine whether weak service account credentials could be recovered through offline cracking.

This phase focused on:

- SPN enumeration
- Kerberos ticket extraction
- Offline password cracking
- Service account compromise
- Attack surface expansion

---

# 🧠 Attack Logic

After achieving privileged access to the environment, the attack strategy expanded toward identifying additional credential exposure opportunities within Active Directory.

Kerberoasting is a common Active Directory attack technique that targets service accounts configured with Service Principal Names (SPNs).

These accounts can be abused because attackers may request Kerberos service tickets (TGS tickets) associated with the service account.

The encrypted portion of the ticket can then be extracted and cracked offline without requiring further interaction with the target system.

This attack becomes especially dangerous when:

- service accounts use weak passwords
- passwords are predictable
- service accounts possess elevated privileges

During this phase:

- SPNs were enumerated successfully
- a Kerberoastable service account was identified
- a TGS hash was extracted
- offline cracking successfully recovered the service account password

This phase demonstrates how weak service account credential practices significantly increase enterprise attack surface exposure.

---

# ⚙️ Actions Performed

The following actions were performed during this phase:

1. Enumerated Service Principal Names (SPNs)
2. Identified Kerberoastable service accounts
3. Requested Kerberos TGS tickets
4. Extracted Kerberos service ticket hashes
5. Performed offline password cracking using John the Ripper
6. Recovered cleartext service account credentials
7. Analyzed service account privileges and group memberships

---

# ✅ Outcome

Kerberoasting successfully exposed credentials associated with a privileged service account.

The compromised account:

```text
svc_backup
```

was identified as a member of:

```text
Backup Operators
```

The recovered password was:

```text
Backu<REDACTED>
```

This phase demonstrated successful abuse of weak Kerberos service account credentials through offline cracking techniques.

---

# 💥 Security Impact

Successful Kerberoasting can allow attackers to:

- Recover service account credentials
- Expand attack surface visibility
- Escalate privileges
- Access backup-related privileges
- Perform lateral movement
- Establish additional persistence paths

This phase demonstrates the significant enterprise risk associated with weak service account passwords and exposed SPNs.

---

# 🔗 Relationship to Later Attack Phases

Although Backup Operators privileges alone did not provide unrestricted remote exploitation capability in this environment, the recovered credentials expanded attacker visibility and operational flexibility.

This phase further reinforced the effectiveness of chaining multiple techniques during Active Directory compromise operations.
