# Get Packages
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
irm get.scoop.sh | iex
scoop bucket add extras
scoop bucket add anderlli0053_DEV-tools https://github.com/anderlli0053/DEV-tools.git
scoop install main/git main/gh main/curl main/coreutils main/unxutils main/which main/touch main/bottom main/bat main/mdcat main/broot main/fd main/fzf main/winfetch extras/wezterm extras/windows-terminal main/oh-my-posh extras/onefetch extras/lazygit extras/cookiecutter anderlli0053_DEV-tools/exa
scoop install main/neovim
iwr -useb "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" |`
    ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force
scoop bucket add nerd-fonts
scoop install nerd-fonts/JetBrains-Mono

# Install Configuration Files
Copy-Item -Path "$PSScriptRoot/*" -Destination "$env:USERPROFILE" -Exclude "setup.ps1" -Recurse -Force -Container
