add_to_path() {
    case ":${PATH}:" in
        *:"$1":*) ;;
        *) export PATH="$1:$PATH" ;;
    esac
}

add_to_path "$HOME/.local/bin"

eval "$(mise activate zsh)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh --cmd cd)"
eval "$(atuin init zsh)"

export EDITOR="$(mise which nvim)"
export VISUAL="$EDITOR"
export SUDO_EDITOR="$EDITOR"

source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^ ' autosuggest-accept

alias ls='eza --all --icons=auto --classify=auto --hyperlink=auto --group-directories-first'
alias tree='eza --tree --level=2 --icons=auto --hyperlink=auto --group-directories-first'
alias vim="nvim"
alias gs="git status"
alias gd="hunk diff"
alias gl="lazygit log"

source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
