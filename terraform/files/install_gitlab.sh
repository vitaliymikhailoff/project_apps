#!/bin/bash
sudo cp /tmp/docker-compose.yml /srv/gitlab/
cd /srv/gitlab
sudo docker compose up -d
sleep 120
sudo docker exec -it gitlab-web-1 grep 'Password:' /etc/gitlab/initial_root_password

