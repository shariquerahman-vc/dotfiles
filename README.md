# dotfiles

![Platform](https://img.shields.io/badge/platform-macOS-000000?logo=apple&logoColor=white)
![Shell](https://img.shields.io/badge/shell-zsh-1f425f?logo=gnu-bash&logoColor=white)
![Editor](https://img.shields.io/badge/editor-Neovim-57A143?logo=neovim&logoColor=white)
![Homebrew](https://img.shields.io/badge/pkgs-Homebrew-FBB040?logo=homebrew&logoColor=white)
![Maintained](https://img.shields.io/badge/maintained-yes-brightgreen)

Personal macOS configuration, version-controlled and reproducible on a fresh machine.

## What's tracked

| Area        | Files                                                        |
|-------------|--------------------------------------------------------------|
| Zsh         | `home/.zshrc`, `home/.zprofile`, `home/.p10k.zsh`            |
| Git         | `home/.gitconfig`, `config/git/ignore`                       |
| Neovim      | `config/nvim/` (lazy.nvim setup; `UPSTREAM.txt` notes origin)|
| tmux        | `config/tmux/tmux.conf`                                      |
| htop        | `config/htop/htoprc`                                         |
| Zed         | `config/zed/settings.json`                                  |
| GitHub CLI  | `config/gh/config.yml` (auth in `hosts.yml` is **not** tracked) |
| oh-my-posh  | `config/oh-my-posh/claude-code.omp.json`                    |
| neofetch    | `config/neofetch/config.conf`                               |
| Homebrew    | `Brewfile`                                                   |

### Deliberately excluded (secrets / machine state)

`~/.ssh`, `~/.aws`, `~/.config/gh/hosts.yml`, `~/.config/github-copilot/`,
`~/.docker`, `~/.gradle`, `~/.npm`, `~/.nvm`, shell history files, and anything
matching the patterns in `.gitignore`. **Never commit tokens or keys.**

## Install on a new machine

```bash
git clone <repo-url> ~/dotfiles
cd ~/dotfiles

# Preview first — changes nothing:
./install.sh --dry-run

# Symlink everything (existing files are backed up to ~/.dotfiles-backup/):
./install.sh

# Restore Homebrew packages:
brew bundle --file=Brewfile
```

### Prerequisites not in the Brewfile

- **Oh My Zsh** — `sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`
- **Powerlevel10k** theme + `zsh-autosuggestions` plugin
- **zsh-syntax-highlighting** — `.zshrc` sources it from `~/zsh-syntax-highlighting/`
- **nvm** (Node), **Python 3.13** framework build (paths referenced in `.zprofile`/`.zshrc`)

## How install.sh works

- `home/*` → symlinked to `~/` (e.g. `home/.zshrc` → `~/.zshrc`)
- `config/*` → symlinked **file-by-file** into `~/.config/` so tracked files
  coexist with app-managed state.
- Existing files are moved to `~/.dotfiles-backup/<timestamp>/` unless `--force`.

## Updating

Edit the real files in place (they're symlinks back to this repo), then:

```bash
cd ~/dotfiles && git add -A && git commit -m "update config" && git push
```

To refresh the Homebrew list: `brew bundle dump --file=Brewfile --force`.
