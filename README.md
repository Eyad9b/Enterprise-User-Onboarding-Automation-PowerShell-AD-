# Enterprise-User-Onboarding-Automation-PowerShell-AD-
Automated domain user creation, permissions assignment, and onboarding workflows using PowerShell.
📌 Overview
This project automates enterprise user onboarding in Active Directory using PowerShell.
It eliminates manual account creation, reduces errors, and ensures consistent permission assignment.


🏗️ Architecture
- PowerShell script reads user data from CSV
- Creates users in Active Directory
- Assigns users to department-based groups

 📋 Prerequisites
- Windows Server with Active Directory
- PowerShell 5.1+
- Domain Admin privileges

⚙️ Technologies Used
- PowerShell
- Active Directory
- Windows Server

 🚀 Implementation Steps

### Step 1: Prepare User Data
Create a CSV file containing user information:
FirstName,LastName,Department,Username,Password
John     ,Doe,        IT,      jdoe   ,P@ss123
Jane,     Smith,      HR,      jsmith, P@ss123


### Step 2: Create PowerShell Script
The script imports users from CSV and creates accounts automatically.

Key actions:
- Creates user accounts
- Assigns users to Organizational Units
- Adds users to department groups

---

### Step 3: Execute Script

Run the script on a domain-joined machine: .\create-users.ps1


### Step 4: Verify Results
- Check Active Directory Users and Computers
- Confirm users exist in correct OUs
- Verify group membership

📊 Results
- Automated bulk user creation
- Reduced manual errors
- Faster onboarding process
