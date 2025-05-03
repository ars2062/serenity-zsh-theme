autoload -U colors && colors

get_ip_info() {
  local iface=$(ip route | awk '/default/ {print $5}' | head -n1)
  local ip=$(ip -4 -o addr show dev "$iface" | awk '{split($4, a, "/"); print a[1]}' | head -n1)
  [[ -n "$ip" ]] && echo "[%F{cyan}${ip}@${iface}%f]"
}

get_git_info() {
  local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  [[ -n "$branch" ]] && echo "[%F{magenta}git:${branch}%f]"
}

build_prompt() {
  local info="%F{white}┌─%f"
  [[ -n "$USER" ]] && info+="[%F{green}$USER%f]"
  [[ -n "$HOST" ]] && info+="@[%F{blue}$HOST%f]"
  local ip_info=$(get_ip_info)
  [[ -n "$ip_info" ]] && info+="$ip_info"
  info+="[%F{yellow}$(date +%H:%M:%S)%f]"
  [[ "$LASTEXITCODE" -ne 0 ]] && info+="[%F{red}exit:$LASTEXITCODE%f]"
  local git_info=$(get_git_info)
  [[ -n "$git_info" ]] && info+="$git_info"

  local path="%F{white}├─%f %F{cyan}%~%f"
  local prompt="%F{white}└─%f %F{cyan}\\$%f "

  echo -e "$info\n$path\n$prompt"
}

precmd() {
  export LASTEXITCODE=$?
  PROMPT="$(build_prompt)"
}
