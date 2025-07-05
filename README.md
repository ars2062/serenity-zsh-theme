# serenity

**serenity** is a minimalist, visually calm Zsh theme for [Oh My Zsh](https://ohmyz.sh), ideal for servers, SSH sessions, and terminal users who prefer clarity over clutter.

It displays essential context info in soft-colored boxes above the command line, using Unicode separators to stay clean yet expressive.

## ✨ Features

| Area                   | Details                                                                                                      |
| ---------------------- | ------------------------------------------------------------------------------------------------------------ |
| **Context line**       | • Username • Hostname • IP + interface (default route) • Clock • *Exit-code* (only if non-zero) • Git branch |
| **Root “danger” mode** | Red/yellow palette + 💀 prefix when `EUID==0`                                                                |
| **Auto-updater**       | Checks GitHub once/day for a newer *semver*; asks before replacing itself                                    |
| **Palette overrides**  | One associative array lets you recolour any part of the prompt                                               |
| **Zero external deps** | Everything is pure Z-shell (`curl` only for the updater)                                                     |

## 📸 Preview

```zsh
┌─[arshia]@[pop-os][192.168.1.243@wlo1][22:17:18][git:main]
├─ ~/projects/serenity-zsh-theme
└─ $
```
Root shell:
```zsh
┌─[💀 root]@[pop-os][192.168.1.243@wlo1][22:17:32][git:main]
├─ /root
└─ $
```
## ⚙️ Installation
### 1 · Install Oh My Zsh (if you don’t have it)
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
### 2 · Fetch the theme **and** its version file
```bash
base=https://raw.githubusercontent.com/ars2062/serenity-zsh-theme/master
dest=$HOME/.oh-my-zsh/custom/themes
curl -fsSL $base/serenity.zsh-theme -o $dest/serenity.zsh-theme
curl -fsSL $base/VERSION -o $dest/serenity.version
```
*(Repeat with `sudo` for `/root` if you want root to use the theme as well.)*
### 3 · Activate
```zsh
# ~/.zshrc
ZSH_THEME="serenity"
```

Reload your shell:

```bash
source ~/.zshrc
```


---
## 🔄 Automatic updates
`serenity` reads its version from `serenity.version`, then **once per day** it fetches `VERSION` from GitHub:
```
serenity: New version 1.1.3 is available (current 1.0.2). Update now? (y/N)
```
*Answer **y** to pull the new theme and version file, or **n** to skip.*
Disable the check any time:
```zsh
export SERENITY_NO_UPDATE=1 # place in ~/.zshrc
```
---

## 🎨 Customization
The theme ships with sensible palettes for normal and root users, but you can override any colour:

```zsh
# examples – place BEFORE sourcing the theme
typeset -gA MY_PROMPT_COLORS=(
  USER '%F{brightcyan}'
  GIT  '%F{yellow}'
  BORDER '%F{magenta}'
)
```

Keys you can redefine: `USER HOST IP TIME GIT PATH BORDER PROMPT EXIT`.

---

## ✅ Works well on:

- Ubuntu/Debian-based servers
- Arch, Manjaro, Fedora
- macOS (Terminal, iTerm2)

---

**Enjoy your peaceful shell.**