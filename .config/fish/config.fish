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
alias py11='source ~/.local/share/python311/bin/activate.fish && set -x CC gcc-13'
alias py12='source ~/.local/share/python312/bin/activate.fish'
alias cdd='cd ~/Documents'



# Ensure that GPG Agent is used as the SSH agent
# set -e SSH_AUTH_SOCK
# set -U -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
# set -x GPG_TTY (tty)

# Start or re-use a gpg-agent.

# if hostname = gpc then do following
# gpg-connect-agent updatestartuptty /bye >/dev/null

# if in linux system, then do following
if test (uname) = "Linux"
	# if hostnamectl hostname | grep -q gpc
	# if hostnamectl hostname | grep -q -e gpc -e gwin; then
    if hostnamectl hostname | grep -q -e gpc -e gwin
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

fish_add_path /Library/TeX/texbin

if test -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
  source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish'
end


function fish_right_prompt
  # 检查是否在 Nix Shell 环境中
  if set -q IN_NIX_SHELL
    # 设置颜色（例如蓝色），打印 (nix)，然后恢复正常颜色
    set_color -o blue
    echo '(nix)'
    set_color normal
  end
end
