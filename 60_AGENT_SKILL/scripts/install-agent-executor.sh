#!/usr/bin/env sh
set -eu

usage() {
  cat <<'EOF'
Usage:
  install-agent-executor.sh --platform <codex|claude-code|cursor|copilot|gemini>
  install-agent-executor.sh --target <skill-root>

Install the agent-executor Skill into one user-level Agent Skill root.
The destination must not already contain an agent-executor directory.
EOF
}

platform=''
target=''

while [ "$#" -gt 0 ]; do
  case "$1" in
    --platform)
      [ "$#" -ge 2 ] || { usage >&2; exit 2; }
      platform="$2"
      shift 2
      ;;
    --target)
      [ "$#" -ge 2 ] || { usage >&2; exit 2; }
      target="$2"
      shift 2
      ;;
    --help|-h)
      usage
      exit 0
      ;;
    *)
      usage >&2
      exit 2
      ;;
  esac
done

if [ -n "$platform" ] && [ -n "$target" ]; then
  printf '%s\n' 'INSTALL_BLOCKED: choose --platform or --target, not both.' >&2
  exit 2
fi

if [ -z "$platform" ] && [ -z "$target" ]; then
  usage >&2
  exit 2
fi

if [ -n "$platform" ]; then
  case "$platform" in
    codex|cursor|copilot|gemini)
      target="$HOME/.agents/skills"
      ;;
    claude-code)
      target="$HOME/.claude/skills"
      ;;
    *)
      printf '%s\n' "INSTALL_BLOCKED: unsupported platform: $platform" >&2
      usage >&2
      exit 2
      ;;
  esac
fi

script_dir=$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)
source_dir=$(CDPATH='' cd -- "$script_dir/../agent-executor" && pwd)
destination="$target/agent-executor"

if [ -e "$destination" ]; then
  printf '%s\n' "INSTALL_BLOCKED: destination already exists: $destination" >&2
  printf '%s\n' 'No files were replaced, removed, backed up, or mirrored.' >&2
  exit 3
fi

mkdir -p -- "$target"
cp -R -- "$source_dir" "$destination"
printf '%s\n' "INSTALLED: $destination"
printf '%s\n' 'Next: start a new Agent execution session and provide an exact numbered task contract.'
