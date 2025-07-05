# serenity

**serenity** is a minimalist, visually calm Zsh theme for [Oh My Zsh](https://ohmyz.sh), ideal for servers, SSH sessions, and terminal users who prefer clarity over clutter.

It displays essential context info in soft-colored boxes above the command line, using Unicode separators to stay clean yet expressive.

## ✨ Features

- Top-aligned info display
- Clean, boxy Unicode lines
- Only shows data that exists
- Includes:
  - Username
  - Hostname
  - IP with interface (default route)
  - Time
  - Last command's exit code (only if non-zero)
  - Git branch

## 📸 Preview

```zsh
┌─[username]@[hostname][127.0.0.1@eth0][13:01:15][git:main]
├─ ~
└─ $ 
```
## ⚙️ Installation

### 1. Install Oh My Zsh

If you haven't already:

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### 2. Install `serenity`

run the following command to download and install the theme
```bash
curl -sSL https://raw.githubusercontent.com/ars2062/serenity-zsh-theme/master/serenity.zsh-theme -o ~/.oh-my-zsh/custom/themes/serenity.zsh-theme
```

### 3. Enable the theme

Edit `~/.zshrc`:

```zsh
ZSH_THEME="serenity"
```

Reload your shell:

```bash
source ~/.zshrc
```

---

## 🎨 Customisation

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