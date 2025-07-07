# backup nginx and let's encrypt
source /home/zong/.restic-env
echo "backup nginx"
restic backup /etc/nginx /etc/letsencrypt/  --tag nginx

# backup vaultwarden
echo "backup vaultwarden"
restic backup /var/lib/vaultwarden /etc/vaultwarden.env --tag vaultwarden

# # backup drone
# echo "backup drone"
# restic backup /var/lib/drone /etc/systemd/system/drone-runner-docker.service.d /etc/systemd/system/drone-runner-exec.service.d /etc/systemd/system/drone.service.d  --tag drone
# 
# # backup gitea
# echo "backup gitea"
# restic backup /etc/gitea/app.ini /var/lib/gitea --tag gitea

# backup mariadb
# refer to https://archive.fosdem.org/2022/schedule/event/mariadb_backup_restic/attachments/slides/5135/export/events/attachments/mariadb_backup_restic/slides/5135/mariabackup_restic.pdf
echo "backup mariadb"
mariadb-backup --user=root --backup --stream=xbstream 2>/tmp/mariadb-backup.log | restic backup --stdin --stdin-filename mariadb.xb --tag MariaDB

echo "backup minio"
restic backup /etc/minio/ --tag minio
