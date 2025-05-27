
export PATH="$HOME/.local/npm-global/bin:$PATH"

# Fix dbus stuff for void linux
if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
	eval $(dbus-launch --sh-syntax)
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

#custom aliases here
alias vim='nvim'
alias msfet='cd /opt/metasploit/tools/exploit/'
alias patterncreate='/opt/metasploit/tools/exploit/pattern_create.rb'
alias patternoffset='/opt/metasploit/tools/exploit/pattern_offset.rb'
alias code='flatpak run com.visualstudio.code'

