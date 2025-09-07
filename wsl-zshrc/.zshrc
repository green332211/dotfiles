# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# Brew environment
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
export PATH=$PATH:/usr/bin/gcc

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

export GOOGLE_CLOUD_PROJECT="totemic-cursor-464112-a2"

# ---- Eza (better ls) -----
alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"

# Neovim
alias v=nvim
alias vim=nvim

# Tmux
# alias t=tmux
alias t='tmux attach-session -t "$(tmux list-sessions -F "#{session_name}" | head -n 1)" 2>/dev/null || echo "Существующих сессий нет."'

# Clear
alias cl="clear"

# App shortcuts
alias lg=lazygit
alias ld=lazydocker

# ---- Thefuck alias ----
if command -v thefuck &> /dev/null; then
  eval $(thefuck --alias)
else
  echo "thefuck not found, please install it from https://github.com/nvbn/thefuck#installation"
fi

# ---- Zoxide (better cd) ----
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
  alias cd="z"
else
  echo "zoxide not found, please install it from https://github.com/ajeetdsouza/zoxide"
fi

# ---- FZF ----
if [ -f "/home/linuxbrew/.linuxbrew/opt/fzf/shell/key-bindings.zsh" ]; then
  source "/home/linuxbrew/.linuxbrew/opt/fzf/shell/key-bindings.zsh"
  source "/home/linuxbrew/.linuxbrew/opt/fzf/shell/completion.zsh"
else
  echo "fzf plugin: Cannot find fzf installation directory."
  echo "Please add 'export FZF_BASE=/path/to/fzf/install/dir' to your .zshrc"
fi

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_DEFAULT_OPTS='
  --height=40%
  --layout=reverse
  --border
  --inline-info
  --style=full
  --preview-window=right:60%
  --prompt="❯ "
  --pointer="➤"
  --marker="✓"
  --info=inline
'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# ---- BAT ----
export BAT_THEME=Kanagawa

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Language environment
# export LANG=en_US.UTF-8

# Compilation flags
# export ARCHFLAGS="-arch x86_64"
