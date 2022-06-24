#!/bin/bash

docker run   -d   -p 9000:9000   -e HTTP_PORT=9000   --name zoonavigator   --restart unless-stopped   elkozmon/zoonavigator:1.1.2

Depreciated:
cd /root/kafka/tools

nano zoonavigator-docker-compose.yml
# Make sure port 8001 is opened on the instance security group

# copy the zookeeper/zoonavigator-docker-compose.yml file
# run it
docker-compose -f zoonavigator-docker-compose.yml up -d
