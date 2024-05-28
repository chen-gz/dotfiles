set fish_greeting
if status is-interactive
    # Commands to run in interactive sessions can go here
end

fish_add_path ~/opt/cuda/bin
fish_add_path ~/.nix-profile/bin
fish_add_path ~/.local/bin
fish_add_path ~/.cargo/bin/
fish_add_path /home/guangzong/.local/share/JetBrains/Toolbox/scripts
export GPG_TTY=$(tty) ## for gpg and alacritty

alias wgup='sudo systemctl start wg-quick@wg0'
alias wgdown='sudo systemctl stop wg-quick@wg0'
alias dr='devbox run'
alias ds='devbox shell'
alias py11='source ~/.local/share/python311/bin/activate.fish'
alias py12='source ~/.local/share/python312/bin/activate.fish'
