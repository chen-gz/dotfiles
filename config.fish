if status is-interactive
    # Commands to run in interactive sessions can go here
end
setenv NEOVIDE_FRAME none
setenv SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/gnupg/S.gpg-agent.ssh"

fish_add_path "/home/zong/.cargo/bin"
