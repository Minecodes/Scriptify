# Name: winget GUI installer
# Description: Install an package over winget with an GUI
# Usage: .\install.ps1
# Permission: mostly user, but some installers of packages are opening the administrator prompt
# OS: Windows 10


# Explenation:
# This script does basicly give winget the command to install with the package.
# The user had basicly to type in "winget install <package>".


# Winget Tips:
# 1. use "winget search <name>" to find packages or go to https://winget.run
# 2. use "winget upgrade --all" to upgrade all packages / programs
# 3. use "winget uninstall <package>" to uninstall a package
# 4. use "winget show <package>" to show the package's info (name, version, description, ...)



Add-Type -assembly System.Windows.Forms
$main_form = New-Object System.Windows.Forms.Form
$main_form.Text =''
$main_form.Width = 220
$main_form.Height = 120
$main_form.AutoSize = $false


# Package Label
$PackageLabel = New-Object System.Windows.Forms.Label
$PackageLabel.Text = "winget Package:"
$PackageLabel.Location  = New-Object System.Drawing.Point(2,10)
$PackageLabel.AutoSize = $true
$main_form.Controls.Add($PackageLabel)


# Package TextBox
$PackageName = New-Object System.Windows.Forms.TextBox
$PackageName.Location = New-Object System.Drawing.Point(2,30)
$PackageName.Width = 200
$PackageName.Height = 20
$PackageName.Text = ""
$main_form.Controls.Add($PackageName)

# Add button, that will install the package
$InstallButton = New-Object System.Windows.Forms.Button
$InstallButton.Text = "Install"
$InstallButton.Location = New-Object System.Drawing.Point(2,50)
$InstallButton.Width = 100
$InstallButton.Height = 25
$InstallButton.Add_Click({
    if($PackageName.Text -ne ""){
        $pkg = $PackageName.Text
        $main_form.Close()
        Start-Process winget -ArgumentList "install $pkg"
    }
})
$main_form.Controls.Add($InstallButton)


$main_form.ShowDialog()