#!/bin/bash
# create data dictionary for zookeeper
mkdir -p /data/zookeeper
chown -R root:root /data/
# declare the server's identity
echo "1" > /data/zookeeper/myid
echo "2" > /data/zookeeper/myid
echo "3" > /data/zookeeper/myid
# edit the zookeeper settings
rm /root/kafka/config/zookeeper.properties
nano /root/kafka/config/zookeeper.properties
cat /root/kafka/config/zookeeper.properties
# restart the zookeeper service
service zookeeper stop
systemctl daemon-reload
service zookeeper restart
service zookeeper start
service zookeeper status
# observe the logs - need to do this on every machine
cat /root/kafka/logs/zookeeper.out | head -100
nc -vz localhost 2181
nc -vz zookeeper1 2181
nc -vz zookeeper2 2181
nc -vz zookeeper3 2181

nc -vz zookeeper1 2888
nc -vz zookeeper2 2888
nc -vz zookeeper3 2888

nc -vz zookeeper1 3888
nc -vz zookeeper2 3888
nc -vz zookeeper3 3888

echo "ruok" | nc localhost 2181 ; echo
echo "stat" | nc localhost 2181 ; echo

bin/zookeeper-shell.sh localhost:2181
# not happy
ls /
