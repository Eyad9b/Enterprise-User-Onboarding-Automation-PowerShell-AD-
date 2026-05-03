Import-Module ActiveDirectory

$users = Import-Csv ".\data\users.csv"

foreach ($user in $users) {

    $securePassword = ConvertTo-SecureString $user.Password -AsPlainText -Force

    New-ADUser `
        -Name "$($user.FirstName) $($user.LastName)" `
        -GivenName $user.FirstName `
        -Surname $user.LastName `
        -SamAccountName $user.Username `
        -UserPrincipalName "$($user.Username)@lab.local" `
        -AccountPassword $securePassword `
        -Enabled $true `
        -Path "OU=$($user.Department),DC=lab,DC=local"

    # Add user to department group
    Add-ADGroupMember -Identity $user.Department -Members $user.Username
}
