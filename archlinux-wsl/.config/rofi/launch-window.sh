#!/usr/bin/env bash

exec rofi -show window -window-format "Workspace {w}  {c} {t}" -sidebar-mode -modes window,drun,run -display-drun "applications"
