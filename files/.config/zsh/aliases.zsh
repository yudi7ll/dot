alias artisan="php artisan"
[[ -f `which bat` ]] && alias cat=bat 
[[ -f `which batcat` ]] && alias cat=batcat
alias copy=clipcopy
alias cx=codex
alias df="dysk"
alias icat="kitty +kitten icat"
alias mocp="mocp -T green_theme"
alias nivm="nvim"
alias v="nvim"
alias o='xdg-open &>/dev/null'
alias occ='./bin/occ'
alias open='xdg-open &>/dev/null'
alias p="sudo pacman"
alias paru="paru --removemake --sudoloop --bottomup --skipreview"
alias pnd="pnpm dev"
alias s="pacman -Ss"
alias sail="./vendor/bin/sail"
alias sc="systemctl"
alias sd="sudo systemctl"
alias saul=sail
alias sial=sail
alias serve="php artisan serve --host 0.0.0.0 &>/dev/null"
alias si="sudo pacman -S"
alias sudo="sudo "
alias sup="sail up -d"

# npm
alias np="npm"
alias npr="npm run"
alias npd="npm run dev"
alias npb="npm run build"
alias nps="npm start"
alias npsl="npm run start:local"

# directories
[[ -f `which eza` ]] && alias exa=eza
alias lsa="exa -lagH --group-directories-first --icons auto"
alias l="exa -lagH --group-directories-first --icons auto"
alias ll="exa -lgH --group-directories-first --icons auto"
alias la="exa -lAgH --group-directories-first --icons auto"
alias ldir="exa -lgDH --git --icons auto"

# claude
alias cl=claude
alias cll="claude --settings ~/.claude/settings.local-llm.json"

# docker 
alias drun='docker run -ti --rm -v $PWD:/app -w /app'
alias d="docker compose"
alias dps="docker ps --format \"table {{.Names}}\t{{.Status}}\t{{.Ports}}\""
alias dup="docker compose up -d"
alias du="ncdu --color off"
alias dx="docker compose exec"
alias tinker="docker compose exec app php artisan tinker"

alias t=tmux

# git
alias ghash='git rev-parse HEAD'
