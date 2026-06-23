#!/usr/bin/env bash
# PreToolUse (Edit|Write): блокирует правку заблокированного ядра prompt/core.md.
# Изменение ядра — только командой «изменить core / повысить C-NNN до core».
input=$(cat)
fp=$(printf '%s' "$input" | grep -oE '"file_path"[[:space:]]*:[[:space:]]*"[^"]*"' | head -1 | sed -E 's/.*:[[:space:]]*"([^"]*)"/\1/')
norm=$(printf '%s' "$fp" | tr '\\' '/' | tr -s '/')
case "$norm" in
  */prompt/core.md|prompt/core.md)
    echo "BLOCKED: prompt/core.md — заблокированное ядро. Правки только командой «изменить core / повысить C-NNN до core», не напрямую." >&2
    exit 2
    ;;
esac
exit 0
