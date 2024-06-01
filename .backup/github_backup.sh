# !/bin/bash
# The script is simple. It clones the repositories to a temporary directory, then uses  restic  to backup the repositories. 
git clone --mirror git@github.com:chen-gz/stm32u5lib.git /tmp/repos/stm32u5lib.git
git clone --mirror git@github.com:chen-gz/serial_comm_tool.git /tmp/repos/serial_comm_tool.git
git clone --mirror git@github.com:chen-gz/gb.git /tmp/repos/gb.git
git clone --mirror git@github.com:chen-gz/dotfiles.git /tmp/repos/dotfiles.git
git clone --mirror git@github.com:chen-gz/SI2I.git /tmp/repos/SI2I.git
git clone --mirror git@github.com:chen-gz/Shape-Preserving-Generation-of-Food-Images-for-Automatic-Dietary-Assessment.git /tmp/repos/SPGFIADA.git
git clone --mirror git@github.com:chen-gz/nvim_conf.git /tmp/repos/nvim_conf.git
git clone --mirror git@github.com:chen-gz/proposal.git /tmp/repos/proposal.git
# uplod use restic
restic backup --tag github_repos             \
    /tmp/repos/stm32u5lib.git                \
    /tmp/repos/serial_comm_tool.git          \
    /tmp/repos/gb.git                        \
    /tmp/repos/dotfiles.git                  \
    /tmp/repos/SI2I.git                      \
    /tmp/repos/SPGFIADA.git                  \
    /tmp/repos/nvim_conf.git                 \
    /tmp/repos/proposal.git

# remove temp repos
rm -rf /tmp/repos/*
 



