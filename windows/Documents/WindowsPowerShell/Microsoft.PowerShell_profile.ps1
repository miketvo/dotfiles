# Predictive IntelliSense (auto-suggestions)
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
$options = Get-PSReadlineOption
$options.InlinePredictionColor = 'DarkGray'
Set-PSReadLineKeyHandler -Chord 'Shift+Spacebar' -Function AcceptNextSuggestionWord
Set-PSReadLineKeyHandler -Chord 'Ctrl+Spacebar' -Function AcceptSuggestion

# Load oh-my-posh config
oh-my-posh init pwsh --config ~\.oh-my-posh.omp.json | Invoke-Expression

# Aliases
Set-Alias -Name 'dr' -Value 'eza'
Set-Alias -Name 'br' -Value 'broot'
del alias:sl -Force

winfetch -image ${HOME}/.fetch.png
