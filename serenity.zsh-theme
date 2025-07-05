###############################################################################
# serenity.zsh-theme  –  palette-aware prompt with root “danger” mode
###############################################################################

autoload -U colors && colors
autoload -Uz add-zsh-hook        # we’ll attach our own precmd safely

# ─── 1. Palettes ─────────────────────────────────────────────────────────────
typeset -gA PROMPT_COLORS=(
  USER   '%F{green}'   HOST   '%F{blue}'    IP   '%F{cyan}'
  TIME   '%F{yellow}'  GIT    '%F{magenta}' PATH '%F{cyan}'
  BORDER '%F{white}'   PROMPT '%F{cyan}'    EXIT '%F{red}'
)

typeset -gA PROMPT_COLORS_ROOT=(
  USER   '%F{red}'     HOST   '%F{blue}'     IP   '%F{cyan}'
  TIME   '%F{yellow}'  GIT    '%F{magenta}'  PATH '%F{cyan}'
  BORDER '%F{yellow}'  PROMPT '%F{cyan}'     EXIT '%F{red}'
)

# user overrides – declare MY_PROMPT_COLORS in ~/.zshrc **before** sourcing
if typeset -p MY_PROMPT_COLORS >/dev/null 2>&1; then
  for k v in "${(@kv)MY_PROMPT_COLORS}"; do
    PROMPT_COLORS[$k]=$v
  done
fi

# ─── 2. Helper functions ─────────────────────────────────────────────────────
SKULL_ICON='💀'

get_ip_info() {              # $1 = chosen palette's IP colour
  local iface=$(ip route | awk '/default/{print $5; exit}')
  local ip=$(ip -4 -o addr show dev "$iface" | \
             awk '{split($4,a,"/"); print a[1]; exit}')
  [[ -n $ip ]] && echo "[${1}${ip}@${iface}%f]"
}

get_git_info() {             # $1 = chosen palette's GIT colour
  local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  [[ -n $branch ]] && echo "[${1}git:${branch}%f]"
}

# ─── 3. Prompt builder ───────────────────────────────────────────────────────
build_prompt() {
  local -A P                 # active palette
  if (( EUID == 0 )); then
    P=("${(@kv)PROMPT_COLORS_ROOT}")
  else
    P=("${(@kv)PROMPT_COLORS}")
  fi

  local user_disp=$USER
  (( EUID == 0 )) && user_disp="${SKULL_ICON}$user_disp"

  local info="${P[BORDER]}┌─%f[${P[USER]}$user_disp%f"\
"@${P[HOST]}${HOST}%f]"

  info+="$(get_ip_info ${P[IP]})"
  info+="[${P[TIME]}$(date +%H:%M:%S)%f]"
  (( LASTEXITCODE )) && info+="[${P[EXIT]}exit:${LASTEXITCODE}%f]"
  info+="$(get_git_info ${P[GIT]})"

  local path="${P[BORDER]}├─%f ${P[PATH]}%~%f"
  local prompt="${P[BORDER]}└─%f ${P[PROMPT]}\\$%f "

  print -P "$info\n$path\n$prompt"
}

# ─── 4. Hook it up ───────────────────────────────────────────────────────────
serenity_precmd() {
  LASTEXITCODE=$?
  PROMPT=$(build_prompt)
}
add-zsh-hook precmd serenity_precmd

###############################################################################
# Customisation:
#   typeset -gA MY_PROMPT_COLORS=( USER '%F{brightcyan}' GIT '%F{yellow}' )
# Keys you can override: USER HOST IP TIME GIT PATH BORDER PROMPT EXIT
###############################################################################
