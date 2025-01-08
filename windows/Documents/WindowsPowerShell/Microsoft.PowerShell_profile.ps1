# Terminal Icons
Import-Module Terminal-Icons

# Load oh-my-posh config
oh-my-posh init pwsh --config ~\.oh-my-posh.omp.json | Invoke-Expression

# Aliases and Functions
function dr { eza --icons $args }
function dra { eza --icons --all $args }
function drla { eza --icons --long --all $args }
function drl { eza --icons --long $args }
function drg { eza --icons --long --all --git --git-ignore $args }
function imgcat { wezterm imgcat $args }
del alias:sl -Force

Clear-Host
winfetch
