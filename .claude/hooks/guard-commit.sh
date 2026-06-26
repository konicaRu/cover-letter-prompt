#!/usr/bin/env bash
# PreToolUse (Bash): no-op для всего, что не содержит "git commit".
# При git commit — блокирует, если в staged приватные файлы (репо публичный).
input=$(cat)
case "$input" in
  *"git commit"*) ;;
  *) exit 0 ;;
esac
staged=$(git diff --cached --name-only 2>/dev/null)
bad=$(printf '%s\n' "$staged" | grep -E 'inputs/jira|inputs/b2bcenter|inputs/resume/variants|(^|/)archive/|cases.*\.md|facts-digest\.md')
if [ -n "$bad" ]; then
  echo "BLOCKED: в staged приватные файлы — репозиторий ПУБЛИЧНЫЙ, коммитить нельзя:" >&2
  printf '  %s\n' $bad >&2
  echo "Убери их из индекса: git restore --staged <path> (или git reset <path>) и повтори." >&2
  exit 2
fi
exit 0
