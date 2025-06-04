export DEBUGINFOD_URLS="https://debuginfod.voidlinux.org/"
export PATH="$HOME/.local/npm-global/bin:$PATH"
export PWNDBG_NO_AUTOUPDATE=true

# Fix dbus stuff for void linux
if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
	eval $(dbus-launch --sh-syntax)
fi

if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    export MOZ_ENABLE_WAYLAND=1
    export GDK_BACKEND=wayland 
    export GDK_DPI_SCALE=0.7
fi

# Use powerline
USE_POWERLINE="true"

# Use custom prompt
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:git:*' formats '(%b)'
precmd() { 
    vcs_info
}
setopt promptsubst

git_branch='${vcs_info_msg_0_}'
PS1="%F{80}%n%f%F{15}@%f%F{80}%m%f%F{15}:%f%B%F{15}%~%f%b%F{15}:%F{39}${git_branch}√> %f"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# use colors
alias ls='ls --color=auto'
alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'
alias fgrep='fgrep --colour=auto'


#custom aliases here
alias vim='nvim'
alias patterncreate='/software/pattern_tools/patterncreate.sh'
alias patternoffset='/software/pattern_tools/patternoffset.sh'
alias code='flatpak run com.visualstudio.code'
alias teams='flatpak run com.github.IsmaelMartinez.teams_for_linux'

