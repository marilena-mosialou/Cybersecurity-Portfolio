<#
.SYNOPSIS
Automated Active Directory provisioning script for the Solaris Creative lab environment.

.DESCRIPTION
Creates Organizational Units (OUs), domain users, service accounts,
and intentionally vulnerable configurations used throughout the
Active Directory attack simulation project.

The script provisions:
- Department-based Organizational Units
- Enterprise user accounts
- Service accounts
- Kerberoasting attack paths
- Backup Operators privilege assignments

Environment:
- Domain: solaris.local
- Domain Controller: SOLARIS-DC-01

.NOTES
This script is intended for educational and lab simulation purposes only.
#>

Import-Module ActiveDirectory

# CSV file path
$CSVPath = "C:\users.csv"

# Domain path
$DomainDN = "DC=solaris,DC=local"

Write-Host ""
Write-Host "==============================================" -ForegroundColor Cyan
Write-Host " Solaris Creative AD Provisioning Started" -ForegroundColor Cyan
Write-Host "==============================================" -ForegroundColor Cyan
Write-Host ""

# --------------------------------------------------
# 1. Create Organizational Units
# --------------------------------------------------

$OUs = @(
    "01-Executives",
    "02-Creative",
    "03-Finance",
    "04-IT-Admin",
    "05-Service-Accounts"
)

foreach ($OU in $OUs) {

    if (!(Get-ADOrganizationalUnit -Filter "Name -eq '$OU'" -ErrorAction SilentlyContinue)) {

        New-ADOrganizationalUnit `
            -Name $OU `
            -Path $DomainDN

        Write-Host "[+] Created OU: $OU" -ForegroundColor Green
    }

    else {
        Write-Host "[!] OU already exists: $OU" -ForegroundColor Yellow
    }
}

# --------------------------------------------------
# 2. Import CSV User Database
# --------------------------------------------------

if (!(Test-Path $CSVPath)) {

    Write-Host "[ERROR] users.csv not found at $CSVPath" -ForegroundColor Red
    exit
}

$Users = Import-Csv $CSVPath

Write-Host ""
Write-Host "[*] Importing user database..." -ForegroundColor Cyan
Write-Host ""

# --------------------------------------------------
# 3. Create Active Directory Users
# --------------------------------------------------

foreach ($User in $Users) {

    $SecurePassword = ConvertTo-SecureString $User.Password -AsPlainText -Force

    $OUPath = "OU=$($User.Department),$DomainDN"

    try {

        New-ADUser `
            -Name "$($User.First) $($User.Last)" `
            -GivenName $User.First `
            -Surname $User.Last `
            -SamAccountName $User.Username `
            -UserPrincipalName "$($User.Username)@solaris.local" `
            -Path $OUPath `
            -Title $User.JobTitle `
            -AccountPassword $SecurePassword `
            -Enabled $true `
            -ChangePasswordAtLogon $false

        Write-Host "[+] Created user: $($User.Username)" -ForegroundColor Green
    }

    catch {

        Write-Host "[!] Failed to create user: $($User.Username)" -ForegroundColor Red
    }
}

# --------------------------------------------------
# 4. Configure Intentional Security Weaknesses
# --------------------------------------------------

Write-Host ""
Write-Host "[*] Configuring intentional security weaknesses..." -ForegroundColor Cyan
Write-Host ""

# Configure SPN for Kerberoasting simulation
Set-ADUser `
    -Identity svc_backup `
    -ServicePrincipalNames @{Add="backup/solaris-dc-01.solaris.local"}

Write-Host "[+] SPN configured for svc_backup" -ForegroundColor Yellow

# Add service account to Backup Operators
Add-ADGroupMember `
    -Identity "Backup Operators" `
    -Members svc_backup

Write-Host "[+] svc_backup added to Backup Operators" -ForegroundColor Yellow

# --------------------------------------------------
# 5. Provisioning Complete
# --------------------------------------------------

Write-Host ""
Write-Host "==============================================" -ForegroundColor Cyan
Write-Host " Solaris Creative AD Provisioning Complete" -ForegroundColor Cyan
Write-Host "==============================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "[+] Environment successfully provisioned." -ForegroundColor Green
Write-Host "[+] Intentional attack paths successfully configured." -ForegroundColor Green
Write-Host ""
