#! /bin/bash
source ~/.restic-env
fd . ~/Documents/ -t f  > /tmp/file_list.txt
fd . ~/Pictures/ -t f  >> /tmp/file_list.txt
restic backup --files-from /tmp/file_list.txt --tag user_folder
