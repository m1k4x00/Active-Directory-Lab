
$names = Get-Content .\names.txt
$defaultPass = "Password1"

$password = ConvertTo-SecureString $defaultPass -AsPlainText -Force
New-ADOrganizationalUnit -Name USERS -ProtectedFromAccidentalDeletion $false

foreach ($i in $names) {
    $fistName = $i.split(" ")[0].ToLower()
    $lastName = $i.split(" ")[1].ToLower()
    $username = "$($fistName.substring(0,1))$($lastName)".ToLower()
    Write-Host "Creating user: $($username)"

    New-AdUser -AccountPassword $password `
               -GivenName $fistName `
               -Surname $lastName `
               -DisplayName $username `
               -Name $username `
               -PasswordNeverExpires $true `
               -Path "ou=USERS,$(([ADSI]`"").distinguishedName)"`
               -Eanabled $true
}