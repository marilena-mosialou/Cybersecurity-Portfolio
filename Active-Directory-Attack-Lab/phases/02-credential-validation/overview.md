# 🟧 Phase 2 — Credential Validation & Access Verification

## 📌 Objective

Determine whether the captured NTLMv2 authentication material could be leveraged to gain authenticated access within the Active Directory environment.

---

# 🎯 Attack Goal

The objective of this phase was to validate whether compromised authentication material could provide usable domain access and support further attack progression.

This phase focused on:

- Offline password cracking attempts
- Credential validation
- Internal authentication testing
- Verification of domain access

---

# 🧠 Attack Logic

After capturing NTLMv2 authentication material during the initial foothold phase, the next logical step was determining whether the credentials could be converted into usable access.

The attack path intentionally followed two separate approaches:

1. Offline password cracking
2. Direct credential validation against internal systems

The initial cracking attempt was unsuccessful, indicating the password was not present within common public wordlists.

Rather than relying exclusively on password cracking, the attack pivoted toward credential validation techniques using known password patterns observed within the environment.

This reflects realistic attacker behavior where operators frequently adapt based on environmental constraints and attack outcomes.

---

# ⚙️ Actions Performed

The following actions were performed during this phase:

1. Extracted NTLMv2 authentication material from Responder logs
2. Attempted offline password cracking using Hashcat
3. Used the rockyou.txt wordlist for initial cracking attempts
4. Validated credentials against internal systems using CrackMapExec
5. Tested SMB authentication across the domain environment
6. Confirmed successful authentication using weak credential patterns

---

# ✅ Outcome

Offline cracking attempts did not successfully recover the target password from standard public wordlists.

However, credential validation techniques successfully identified valid domain credentials associated with the compromised account.

The following credentials were confirmed operational within the environment:

```text
SOLARIS\p.olson
```

The identified password pattern used during validation was:

```text
Solaris2026!
```

This phase established authenticated access within the domain environment and enabled further attack progression.

---

# 💥 Security Impact

Successful credential validation allowed the attacker to:

- Authenticate against internal systems
- Establish trusted domain access
- Begin Active Directory enumeration
- Attempt lateral movement operations
- Progress toward privilege escalation

This phase demonstrates how weak credential hygiene and predictable password patterns can significantly increase enterprise attack surface exposure.

---

# 🔗 Relationship to Later Attack Phases

The authenticated access established during this phase directly enabled:

- BloodHound enumeration
- LDAP reconnaissance
- Remote execution attempts
- Additional credential access activity

Without successful credential validation, subsequent attack phases would not have been possible.
