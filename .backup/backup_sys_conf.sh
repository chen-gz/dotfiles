#! /bin/bash
source /home/guangzong/.restic-env
restic backup --tag sys_conf                                \
              /etc/X11/xorg.conf.d/40-libinput.conf         \
              /etc/locale.conf                              \
              /etc/hostname                                 \
              /etc/sddm.conf                                \
              /etc/wireguard/wg0.conf                       \
              /usr/share/sddm/themes/catppuccin-macchiato/  \
              /etc/environment                              \
              /etc/ssh/sshd_config                          
    
