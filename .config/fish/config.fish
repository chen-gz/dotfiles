set fish_greeting

# Set PATH
fish_add_path ~/.local/bin
fish_add_path ~/.cargo/bin
fish_add_path /opt/homebrew/bin

# GPG and SSH agent setup
set -x GPG_TTY (tty)
if test (uname) = "Darwin"
    # gpgconf --kill gpg-agent
    set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
    gpg-connect-agent updatestartuptty /bye >/dev/null
else if test (uname) = "Linux"
    if hostnamectl hostname | grep -q -e gpc -e gwin
	gpgconf --kill gpg-agent
        set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
        gpg-connect-agent updatestartuptty /bye >/dev/null
    end
end

# Aliases
alias cdd='cd ~/Documents'
