# Automated Active Directory Provisioning

## 📌 Overview

This directory contains the automated provisioning resources used to build the Solaris Creative Active Directory lab environment.

The provisioning workflow automates:

- Organizational Unit (OU) creation
- Domain user provisioning
- Service account creation
- SPN configuration
- Backup Operators privilege assignment
- Intentional security weakness deployment for attack simulation

The environment is designed to simulate a realistic mid-sized enterprise Active Directory infrastructure used throughout the attack chain documented in this repository.

---

# 📂 Files

| File | Purpose |
|---|---|
| `provision.ps1` | Main Active Directory provisioning script |
| `users.csv` | User database used during automated provisioning |

---

# 🏗️ Environment Requirements

The provisioning workflow was developed and tested within the following environment:

| Component | Details |
|---|---|
| Operating System | Windows Server 2022 |
| Domain | `solaris.local` |
| Domain Controller | `SOLARIS-DC-01` |
| PowerShell | Windows PowerShell 5.1 |
| Active Directory | Active Directory Domain Services installed |

---

# ⚙️ Provisioning Features

The provisioning script automatically creates:

- Department-based Organizational Units
- Enterprise user accounts
- Service accounts
- Kerberoasting attack paths
- Backup Operators privilege exposure

Provisioned departments include:

- 01-Executives
- 02-Creative
- 03-Finance
- 04-IT-Admin
- 05-Service-Accounts

---

# 🚀 Execution

## Step 1 — Place User Database

Copy `users.csv` to:

```text
C:\
```

---

## Step 2 — Run PowerShell as Administrator

Launch:

```text
PowerShell ISE
```

using:

```text
Run as Administrator
```

---

## Step 3 — Execute Provisioning Script

Run:

```powershell
.\provision.ps1
```

---

# ✅ Expected Outcome

Successful execution will:

- Create all Organizational Units
- Provision enterprise user accounts
- Configure service account attack paths
- Enable Kerberoasting simulation
- Configure Backup Operators privilege exposure

The environment will then be ready for the attack simulation phases documented throughout this repository.

---

# 🔍 Verification

After successful provisioning:

1. Open:
   ```text
   Active Directory Users and Computers
   ```

2. Verify:
   - Organizational Units exist
   - Users were created successfully
   - Service account configuration completed

---

# 📊 Splunk Verification

If Splunk ingestion is configured, the following query can be used to validate account creation visibility:

```spl
index="endpoint" EventCode=4720
```

Expected visibility includes Windows Security Event ID:

```text
4720 - A user account was created
```

---

# ⚠️ Security Notice

This lab intentionally deploys insecure configurations and weak credential practices for educational and attack simulation purposes only.

The environment should never be exposed to production or internet-accessible infrastructure.
