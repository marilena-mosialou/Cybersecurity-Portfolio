# 💻 Phase 3 Commands — Active Directory Enumeration

## Configure DNS Resolution

```bash
sudo nano /etc/resolv.conf
```

### Purpose

Configures the attacker system to use the Domain Controller for internal Active Directory DNS resolution.

---

## Set Domain Controller DNS Server

```text
nameserver 192.168.10.7
```

### Purpose

Ensures proper resolution of internal Active Directory domain resources.

---

## Verify Domain Resolution

```bash
nslookup solaris.local
```

### Purpose

Confirms successful DNS resolution against the Active Directory environment.

---

## BloodHound Data Collection

```bash
bloodhound-python -d solaris.local -u p.olson -p 'Solaris2026!' -dc SOLARIS-DC-01.solaris.local -ns 192.168.10.7 -c all --zip
```

### Purpose

Collects Active Directory object data including users, groups, computers, ACLs, sessions, and trust relationships for BloodHound analysis.

---

## Start Neo4j Database

```bash
sudo neo4j start
```

### Purpose

Starts the Neo4j database backend required for BloodHound.

---

## Launch BloodHound

```bash
bloodhound
```

### Purpose

Launches the BloodHound graphical interface for Active Directory relationship analysis.
