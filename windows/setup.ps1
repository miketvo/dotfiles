# Get Packages
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
irm get.scoop.sh | iex
scoop bucket add anderlli0053_DEV-tools https://github.com/anderlli0053/DEV-tools.git
scoop install main/git main/gh main/curl main/coreutils main/which main/touch main/bottom main/bat main/mdcat main/broot main/fd main/fzf main/winfetch main/wezterm main/oh-my-posh extras/onefetch extras/lazygit anderlli0053_DEV-tools/exa
scoop install main/neovim
iwr -useb "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" |`
    ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force

# Install Nerd Font
iwr "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip" -Outfile "$env:USERPROFILE/JetBrainsMono.zip"
New-Item -ItemType Directory -Path "$env:USERPROFILE/JetBrainsMono"
Expand-Archive "$env:USERPROFILE/JetBrainsMono.zip" -DestinationPath "$env:USERPROFILE/JetBrainsMono" -Force
Get-ChildItem -Path "$env:USERPROFILE/JetBrainsMono/*" -Include *.ttf *.otf -Recurse | Copy-Item -Destination "$env:LOCALAPPDATA/Microsoft/Windows/Fonts"
Remove-Item -Force "$env:USERPROFILE/JetBrainsMono.zip"
Remove-Item -Force "$env:USERPROFILE/JetBrainsMono"

# Install Configuration Files
Copy-Item -Path "$PSScriptRoot/*" -Destination "$env:USERPROFILE" -Recurse -Force -Container
