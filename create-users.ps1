# Import Active Directory module
Import-Module ActiveDirectory

# Path to your CSV file
$csvPath = "C:\Automation\users.csv"

# Import users from CSV
$users = Import-Csv -Path $csvPath

function New-RandomPassword {
    param([int]$length = 12)

    $chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()'
    $rand = New-Object System.Random
    -join (1..$length | ForEach-Object { $chars[$rand.Next(0, $chars.Length)] })
}

foreach ($user in $users) {
    $firstName   = $user.FirstName
    $lastName    = $user.LastName
    $department  = $user.Department
    $jobTitle    = $user.JobTitle

    # Generate SamAccountName (first initial + last name, lowercase)
    $samAccountName = ($firstName.Substring(0,1) + $lastName).ToLower()

    # Construct UPN
    $upn = "$samAccountName@corp.local"

    # Generate a random password
    $password = New-RandomPassword 12

    # OU path based on Department (must match your AD exactly)
    $ou = "OU=$department,DC=corp,DC=local"

    try {
        New-ADUser `
            -GivenName $firstName `
            -Surname $lastName `
            -SamAccountName $samAccountName `
            -UserPrincipalName $upn `
            -Name "$firstName $lastName" `
            -DisplayName "$firstName $lastName" `
            -Department $department `
            -Title $jobTitle `
            -Path $ou `
            -AccountPassword (ConvertTo-SecureString $password -AsPlainText -Force) `
            -Enabled $true `
            -ChangePasswordAtLogon $true

        Write-Host "Created user: $firstName $lastName ($samAccountName) in $department OU"
    }
    catch {
        Write-Warning "Failed to create $firstName $lastName ($samAccountName). OU $ou not found."
    }
}
