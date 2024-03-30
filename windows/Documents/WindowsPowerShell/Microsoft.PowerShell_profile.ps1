# Predictive IntelliSense (auto-suggestions)
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
$options = Get-PSReadlineOption
$options.InlinePredictionColor = 'DarkGray'
Set-PSReadLineKeyHandler -Chord 'Shift+Spacebar' -Function AcceptNextSuggestionWord
Set-PSReadLineKeyHandler -Chord 'Ctrl+Spacebar' -Function AcceptSuggestion

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
Set-Alias -Name 'br' -Value 'broot'
del alias:sl -Force

winfetch -image ${HOME}/.fetch.png
