# 🟥 Phase 1 — Initial Foothold via LLMNR/NBT-NS Poisoning

## 📌 Objective

Obtain initial authentication material from the internal enterprise network without requiring malware execution or privileged access.

---

# 🎯 Attack Goal

The goal of this phase was to intercept authentication traffic and capture reusable NTLMv2 authentication material from a domain-connected system.

This attack targeted legacy Windows name resolution protocols commonly enabled within enterprise environments.

---

# 🧠 Attack Logic

When DNS resolution fails, Windows systems may fall back to:

- LLMNR (Link-Local Multicast Name Resolution)
- NBT-NS (NetBIOS Name Service)

Attackers can abuse this behavior by responding to broadcast name resolution requests using rogue SMB services.

If a victim system attempts authentication against the attacker-controlled host, NTLMv2 challenge-response hashes may be exposed.

This technique is commonly performed using Responder.

---

# ⚙️ Actions Performed

The following actions were performed during this phase:

1. Verified that LLMNR and NBT-NS were enabled within the environment
2. Configured Responder on the attacker system
3. Monitored broadcast name resolution traffic
4. Triggered SMB authentication behavior from the victim workstation
5. Intercepted NTLMv2 authentication material

---

# ✅ Outcome

A valid NTLMv2 authentication hash associated with a domain user account was successfully captured.

The compromised account identified during this phase was:

```text
SOLARIS\p.olson
```

This established the initial foothold within the enterprise environment.

---

# 💥 Security Impact

Successful LLMNR/NBT-NS poisoning can allow attackers to:

- Capture reusable authentication material
- Perform offline password attacks
- Validate credentials against internal systems
- Initiate lateral movement operations
- Establish an initial foothold without malware execution

---

# 🔗 Relationship to Later Attack Phases

The authentication material captured during this phase directly enabled:

- Credential validation
- Active Directory enumeration
- Lateral movement attempts
- Subsequent privilege escalation activity

This phase served as the initial entry point for the broader attack chain.
