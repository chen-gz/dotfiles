set fish_greeting
if status is-interactive
    # Commands to run in interactive sessions can go here
end

fish_add_path ~/opt/cuda/bin
fish_add_path ~/.nix-profile/bin
fish_add_path ~/.local/bin
fish_add_path ~/.cargo/bin/
fish_add_path /home/guangzong/.local/share/JetBrains/Toolbox/scripts
fish_add_path /opt/homebrew/bin
export GPG_TTY=$(tty) ## for gpg and alacritty

alias wgup='sudo systemctl start wg-quick@wg0'
alias wgdown='sudo systemctl stop wg-quick@wg0'
alias dr='devbox run'
alias ds='devbox shell'
alias py11='source ~/.local/share/python311/bin/activate.fish'
alias py12='source ~/.local/share/python312/bin/activate.fish'
alias cdd='cd ~/Documents'



# Ensure that GPG Agent is used as the SSH agent
set -e SSH_AUTH_SOCK
set -U -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
set -x GPG_TTY (tty)

# Start or re-use a gpg-agent.

# if hostname = gpc then do following
# gpg-connect-agent updatestartuptty /bye >/dev/null

# if in linux system, then do following
if test (uname) = "Linux"
    if hostnamectl hostname | grep -q gpc
        set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
        set -x GPG_TTY (tty)
        gpg-connect-agent updatestartuptty /bye >/dev/null
    end
end
if test (uname) = "Darwin"
     set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
     set -x GPG_TTY (tty)
     gpg-connect-agent updatestartuptty /bye >/dev/null
 end



function gpgsign
    for file in $argv
        set output (string replace -r '(\.[^.]+)$' '.gpg$1' $file)
        gpg --compress-algo none --output $output --sign $file
    end
end

