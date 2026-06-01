#!/usr/bin/env bash
#
# install.sh — symlink dotfiles into place.
#
# Usage:
#   ./install.sh            # symlink everything, backing up existing files
#   ./install.sh --dry-run  # print what would happen, change nothing
#   ./install.sh --force    # overwrite existing files/links without backup
#
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOME_SRC="$DOTFILES_DIR/home"
CONFIG_SRC="$DOTFILES_DIR/config"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

DRY_RUN=0
FORCE=0
for arg in "$@"; do
  case "$arg" in
    --dry-run) DRY_RUN=1 ;;
    --force)   FORCE=1 ;;
    -h|--help) grep '^#' "$0" | sed 's/^# \{0,1\}//' | head -10; exit 0 ;;
    *) echo "Unknown option: $arg" >&2; exit 1 ;;
  esac
done

log()  { printf '%s\n' "$*"; }
run()  { if [ "$DRY_RUN" -eq 1 ]; then log "  [dry-run] $*"; else eval "$*"; fi; }

# link_file <source> <target>
link_file() {
  local src="$1" dst="$2"

  # Already correctly linked → skip.
  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    log "✓ $dst (already linked)"
    return
  fi

  # Existing file/dir/link in the way.
  if [ -e "$dst" ] || [ -L "$dst" ]; then
    if [ "$FORCE" -eq 1 ]; then
      run "rm -rf '$dst'"
    else
      run "mkdir -p '$BACKUP_DIR/$(dirname "${dst#"$HOME"/}")'"
      run "mv '$dst' '$BACKUP_DIR/${dst#"$HOME"/}'"
      log "↪ backed up existing $dst"
    fi
  fi

  run "mkdir -p '$(dirname "$dst")'"
  run "ln -s '$src' '$dst'"
  log "→ linked $dst"
}

log "Dotfiles: $DOTFILES_DIR"
[ "$DRY_RUN" -eq 1 ] && log "(dry run — no changes will be made)"

# 1) Home-level dotfiles: home/.zshrc → ~/.zshrc
if [ -d "$HOME_SRC" ]; then
  log "\n== home dotfiles =="
  while IFS= read -r -d '' f; do
    link_file "$f" "$HOME/$(basename "$f")"
  done < <(find "$HOME_SRC" -mindepth 1 -maxdepth 1 -print0)
fi

# 2) ~/.config: link each tracked FILE individually, mirroring the tree.
#    File-level linking lets tracked files coexist with app-managed state
#    (e.g. gh keeps hosts.yml local; zed keeps its themes; nvim keeps plugins).
if [ -d "$CONFIG_SRC" ]; then
  log "\n== ~/.config =="
  while IFS= read -r -d '' f; do
    rel="${f#"$CONFIG_SRC"/}"
    link_file "$f" "$HOME/.config/$rel"
  done < <(find "$CONFIG_SRC" -type f -print0)
fi

log "\nDone."
if [ "$FORCE" -eq 0 ] && [ -d "$BACKUP_DIR" ]; then
  log "Backups: $BACKUP_DIR"
fi
