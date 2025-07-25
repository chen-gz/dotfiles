set fish_greeting

# Set PATH
fish_add_path ~/.nix-profile/bin
fish_add_path ~/.local/bin
fish_add_path ~/.cargo/bin
fish_add_path /opt/homebrew/bin

# GPG and SSH agent setup
set -x GPG_TTY (tty)
if test (uname) = "Darwin"
    set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
    gpg-connect-agent updatestartuptty /bye >/dev/null
else if test (uname) = "Linux"
    if hostnamectl hostname | grep -q -e gpc -e gwin
        set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
        gpg-connect-agent updatestartuptty /bye >/dev/null
    end
end

# Aliases
alias dr='devbox run'
alias ds='devbox shell'
alias cdd='cd ~/Documents'

# Nix daemon
if test -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
  source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish'
end

# Nix shell indicator in prompt
function fish_right_prompt
  if set -q IN_NIX_SHELL
    set_color -o blue
    echo '(nix)'
    set_color normal
  end
end