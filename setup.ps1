Add-Type -AssemblyName System.Windows.Forms
function Show-MsgBox ($Text, $Title = "", [Windows.Forms.MessageBoxButtons]$Button = "OK", [Windows.Forms.MessageBoxIcon]$Icon = "Information") {
    [Windows.Forms.MessageBox]::Show("$Text", "$Title", [Windows.Forms.MessageBoxButtons]::$Button, $Icon) | ? { (!($_ -eq "OK")) }
}

function checkFiles() {
    if ((Test-Path "index.html") -and (Test-Path "assets/css/style.css")) {
        readvalues
    }
    else {
        Clear-Host
        Write-Host 'Please make sure, that "index.html" and "assets/style.css" are in place'
    }
}

function readvalues() {
    Clear-Host
    $companyname = Read-Host "Comapny companyname: "
    $email = Read-Host "E-Mai: "
    if (Test-Path yourproduct/) {
        If ((Show-MsgBox -Title 'Project already exists!' -Text 'Would you like to continue anyway? Your current project will be overwritten' -Button YesNo -Icon Warning) -eq 'No') { Exit }
        makeproduct -companyname $companyname -email $email
    }
    else {
        makeproduct -companyname $companyname -email $email
    }
}

function makeproduct ($companyname, $email) {
    New-Item -Path yourproduct/assets/icons/ -Force -ItemType "directory"
    New-Item -Path yourproduct/assets/css/ -Force -ItemType "directory"
    Copy-Item -Path index.html -Destination yourproduct/maintenance.html -Force
    Copy-Item -Path assets/ -Destination yourproduct/ -Recurse -Force
    ((Get-Content -path yourproduct/maintenance.html -Raw) -replace '\[email\]', $email) | Set-Content -Path yourproduct/maintenance.html
    ((Get-Content -path yourproduct/maintenance.html -Raw) -replace '\[Company\]', $companyname) | Set-Content -Path yourproduct/maintenance.html
}

checkFiles