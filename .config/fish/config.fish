if status is-interactive
    # Commands to run in interactive sessions can go here
end

fish_add_path ~/.nix-profile/bin
export GPG_TTY=$(tty) ## for gpg and alacritty

alias wgup='sudo systemctl start wg-quick@wg0'
alias wgdown='sudo systemctl stop wg-quick@wg0'
alias nixdev='nix-shell -p yadm git gnupg'
fish_add_path /home/guangzong/.local/share/JetBrains/Toolbox/scripts
alias dr='devbox run'
alias ds='devbox shell'
