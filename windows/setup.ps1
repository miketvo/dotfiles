#
# Syntax: setup.ps1 [Options]
# Options:
#   -b -Bare (Optional) Barebone installation. Skips frameworks and build toolchains.
#   -h -Help (Optional) Display help and exit.
#

[CmdletBinding()] param(
    [Alias("b")][switch]$Bare,
    [Alias("h")][switch]$Help
)

if ($Help.IsPresent) {
    Write-Output "Syntax: setup.ps1 [Options]"
    Write-Output "Options:"
    Write-Output "  -b -Bare (Optional) Barebone installation. Skips frameworks and build toolchains."
    Write-Output "  -h -Help (Optional) Display help and exit."
    exit 0
}


# Scoop Setup
Write-Output "Setting up Scoop package manager..."
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
irm get.scoop.sh | iex

Write-Output "Setting up Git..."
scoop install git
git config --global credential.helper manager

Write-Output "Setting up Scoop Buckets..."
scoop bucket add extras
scoop bucket add versions
scoop bucket add java
scoop bucket add anderlli0053_DEV-tools "https://github.com/anderlli0053/DEV-tools.git"

# Essential Packages
Write-Output "Installing essential packages..."
scoop install main/aria2
scoop install main/git
scoop install main/gh
scoop install main/curl
scoop install main/make
scoop install main/coreutils
scoop install main/unxutils
scoop install main/openssl
scoop install main/grep
scoop install main/sed
scoop install main/touch
scoop install main/which
scoop install main/bottom
scoop install main/eza
scoop install main/bat
scoop install main/mdcat
scoop install main/broot
scoop install main/fd
scoop install main/fzf
scoop install main/ripgrep
scoop install main/winfetch
scoop install main/sudo
scoop install extras/onefetch
scoop install extras/lazygit
scoop install main/python
scoop install main/perl
scoop install main/miktex
scoop install extras/calibre
scoop install anderlli0053_DEV-tools/du
scoop install anderlli0053_DEV-tools/sl

# Neovim
Write-Output "Installing NeoVim..."
scoop install main/neovim
iwr -useb "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" |`
    ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force

# Visual Studio Code
Write-Output "Installing Visual Studio Code..."
scoop install extras/vscode

if (-Not ($Bare.IsPresent)) {
    # Cygwin
    scoop install main/cygwin

    # NodeJS Ecosystem
    Write-Output "Setting up NodeJS ecosystem..."
    scoop install main/nvm
    nvm install lts
    nvm use lts

    # Python Ecosystem
    Write-Output "Setting up Python ecosystem..."
    python -m pip install pipx
    python -m pipx install pipenv
    python -m pipx install poetry
    python -m pipx install tox
    python -m pipx install cookiecutter
    python -m pipx ensurepath

    # C/C++
    Write-Output "Setting up C/C++ ecosystem..."
    scoop install main/gcc
    scoop install main/gdb
    scoop install main/llvm

    # Java
    Write-Output "Setting up Java ecosystem..."
    scoop install java/openjdk
    scoop install main/jdtls
}

# Nerd Fonts
Write-Output "Installing Nerd Fonts..."
git clone --filter=blob:none --sparse "https://github.com/ryanoasis/nerd-fonts.git"
git -C nerd-fonts sparse-checkout add patched-fonts/JetBrainsMono
nerd-fonts/install.ps1 JetBrainsMono -WhatIf
rm -r -Force nerd-fonts

# Eye Candy
Write-Output "Setting up Eye Candy"
scoop install main/oh-my-posh
scoop install extras/terminal-icons
Import-Module -Name Terminal-Icons

# Terminal Emulators
Write-Output "Installing Terminal Emulators..."
scoop install extras/wezterm
scoop install extras/windows-terminal
reg import "$env:USERPROFILE\scoop\apps\windows-terminal\current\install-context.reg"

# Path clean-up
Write-Output "Post-Install Cleaning..."
scoop reset make
scoop reset which

# Install Configuration Files
Write-Output "Installing configurations..."
Copy-Item -Path "$PSScriptRoot/*" -Destination "$env:USERPROFILE" -Exclude "setup.ps1" -Recurse -Force -Container

Write-Output "[ DONE ]"
