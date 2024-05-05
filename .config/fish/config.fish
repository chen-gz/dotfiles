if status is-interactive
    # Commands to run in interactive sessions can go here
end

fish_add_path ~/.nix-profile/bin
export GPG_TTY=$(tty) ## for gpg and alacritty
