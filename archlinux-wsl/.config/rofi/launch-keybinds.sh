#!/usr/bin/env bash

exec rofi -show keybinds -window-format "Workspace {w}  {c} {t}" -theme-str "listview { columns: 1; }" -sidebar-mode -modes keybinds,keys -display-keys "launcher_keybinds"
