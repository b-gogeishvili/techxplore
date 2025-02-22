#!/bin/bash

for host in "192.168.1.68" "192.168.1.21" "192.168.3.186";
do
    ssh "$host" "sudo docker container stop app" 
    ssh "$host" "sudo docker container rm app"
    ssh "$host" "sudo docker system prune -af"
    ssh "$host" "sudo docker pull $1"
    ssh "$host" "sudo docker run -d -p 80:80 --name app $1"
done