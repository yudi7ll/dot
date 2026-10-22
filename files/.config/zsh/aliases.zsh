alias artisan="php artisan"
alias c=cargo
[[ -f `which bat` ]] && alias cat=bat 
[[ -f `which batcat` ]] && alias cat=batcat
alias copy=clipcopy
alias drun='docker run -ti --rm -v $PWD:/app -w /app'
alias d="docker compose"
alias df="dysk"
alias dx="docker compose exec"
alias dup="docker compose up -d"
alias du="ncdu --color off"
alias icat="kitty +kitten icat"
alias mocp="mocp -T green_theme"
alias nivm="nvim"
alias nv="nvim"
alias v="nvim"
alias o='xdg-open &>/dev/null'
alias occ='./bin/occ'
alias open='xdg-open &>/dev/null'
alias rm="trash"
alias p="sudo pacman"
alias paru="paru --removemake --sudoloop --bottomup --skipreview"
alias s="pacman -Ss"
alias sail="./vendor/bin/sail"
alias sd="sudo systemctl"
alias saul=sail
alias sial=sail
alias serve="php artisan serve --host 0.0.0.0 &>/dev/null"
alias si="sudo pacman -S"
alias sudo="sudo "
alias sup="sail up -d"
alias tinker="docker compose exec app php artisan tinker"
alias wninja="cd ~/Wallex/wallex-ninja"

# npm
alias np="npm"
alias npr="npm run"
alias npd="npm run dev"
alias npb="npm run build"
alias nps="npm start"
alias npsl="npm run start:local"

# directories
[[ -f `which eza` ]] && alias exa=eza
alias lsa="exa -lagH --group-directories-first --icons"
alias l="exa -lagH --group-directories-first --icons"
alias ll="exa -lgH --group-directories-first --icons"
alias la="exa -lAgH --group-directories-first --icons"
alias ldir="exa -lgDH --git --icons"

alias settlement-base="cd ~/Wallex/wallex/packages/wallex-settlement-base"
alias nst="cd ~/Wallex/wallex/packages/wallex-settlement-base"
alias nwc="cd ~/Wallex/wallex/packages/wallex-web"
alias ncf="cd ~/.config/nvim"

# aider (AI coding assistant with Ollama)
alias ai='aider --model ollama_chat/qwen2.5-coder-32b-instruct-q4_k_m'
alias ai-light='aider --model ollama_chat/qwen3.5:9b'
alias ai-reason='aider --model ollama_chat/qwen3.5:35b'
