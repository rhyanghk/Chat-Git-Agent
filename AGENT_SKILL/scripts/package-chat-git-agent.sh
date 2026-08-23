#!/usr/bin/env sh
set -eu

usage() {
  cat <<'EOF'
Usage: package-chat-git-agent.sh <output-directory-without-Chat-Git-Agent.skill>

Create Chat-Git-Agent.skill, a ZIP-format Agent Skill package, in the named
directory. The command stops if that package name already exists.
EOF
}

if [ "$#" -eq 1 ] && { [ "$1" = "--help" ] || [ "$1" = "-h" ]; }; then
  usage
  exit 0
fi

[ "$#" -eq 1 ] || { usage >&2; exit 2; }
output_dir="$1"

case "$output_dir" in
  /*) ;;
  *) output_dir="$(pwd)/$output_dir" ;;
esac

command -v zip >/dev/null 2>&1 || {
  printf '%s\n' 'PACKAGE_BLOCKED_ZIP_UNAVAILABLE: install a ZIP utility first.' >&2
  exit 4
}

script_dir=$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)
skill_root=$(CDPATH='' cd -- "$script_dir/../chat-git-agent" && pwd)
parent_dir=$(dirname -- "$skill_root")
output="$output_dir/Chat-Git-Agent.skill"

if [ -e "$output" ]; then
  printf '%s\n' "PACKAGE_BLOCKED: destination already exists: $output" >&2
  printf '%s\n' 'No package was replaced, removed, backed up, or mirrored.' >&2
  exit 3
fi

mkdir -p -- "$output_dir"
(
  cd -- "$parent_dir"
  zip -q -r "$output" chat-git-agent
)
printf '%s\n' "PACKAGED: $output"
