# 🟥 Phase 8 — NTDS.dit Extraction & Full Active Directory Compromise

## 📌 Objective

Extract the Active Directory credential database from the Domain Controller and obtain domain-wide credential material using previously acquired privileged access.

---

# 🎯 Attack Goal

The objective of this phase was to achieve full Active Directory compromise by extracting:

- NTLM password hashes
- Kerberos encryption keys
- Domain credential material
- krbtgt account secrets

This phase focused on validating enterprise-wide identity compromise following successful privilege escalation.

---

# 🧠 Attack Logic

After validating privileged administrative access to the Domain Controller, the attack progressed toward extracting the Active Directory credential database.

Windows Domain Controllers store domain authentication data within:

```text
NTDS.dit
```

This database contains:

- domain user credential hashes
- Kerberos-related authentication material
- password history information
- machine account credentials

Using Impacket `secretsdump`, the attacker authenticated remotely with administrative privileges and initiated NTDS extraction operations against the Domain Controller.

Successful extraction exposed credential material associated with:

- Domain Administrator accounts
- standard domain users
- service accounts
- machine accounts
- the `krbtgt` account

Compromise of the `krbtgt` account is especially significant because it impacts the integrity of Kerberos trust relationships throughout the domain.

This phase demonstrates how administrative access to a Domain Controller can rapidly escalate into enterprise-wide identity compromise.

---

# ⚙️ Actions Performed

The following actions were performed during this phase:

1. Authenticated to the Domain Controller using recovered Administrator credentials
2. Executed Impacket `secretsdump`
3. Initiated NTDS.dit extraction operations
4. Extracted domain NTLM credential hashes
5. Recovered Kerberos encryption keys
6. Identified sensitive domain accounts including `krbtgt`
7. Validated full credential exposure across the Active Directory environment

---

# ✅ Outcome

NTDS extraction successfully exposed domain-wide authentication material.

Recovered credential data included:

- Domain user NTLM hashes
- Service account hashes
- Machine account hashes
- Kerberos AES/RC4 keys
- `krbtgt` account credentials

The attack achieved effective compromise of Active Directory identity infrastructure within the environment.

---

# 💥 Security Impact

Successful NTDS extraction can allow attackers to:

- Access all domain credential material
- Perform pass-the-hash attacks
- Escalate privileges across the environment
- Compromise Kerberos trust relationships
- Enable persistence mechanisms
- Maintain long-term enterprise access

This phase demonstrates the catastrophic impact associated with Domain Controller compromise and unrestricted access to Active Directory credential infrastructure.

---

# 🔗 Relationship to Entire Attack Chain

This phase represented the culmination of the full attack chain:

- Initial foothold
- Credential harvesting
- Active Directory enumeration
- Privilege escalation
- Administrative access validation
- Service account compromise
- Domain credential extraction

The project demonstrates how multiple smaller weaknesses can be chained together to achieve full Active Directory compromise.
