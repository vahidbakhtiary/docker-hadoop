#!/bin/bash

docker pull postgres

# start hive metastore container
sudo docker rm -f hivemetastore 
echo "start hivemetastore  container..."
sudo docker run -itd \
                --net=hadoop-net \
                -p 6432:5432  \
                -e POSTGRES_PASSWORD=123 \
                --name hivemetastore  \
                --hostname hivemetastore  \
                -v nameNode:/usr/local/hadoop/hdfs/namenode \
                postgres 
           


# get into hive metastore container
#sudo docker exec -it hivemetastore bash
docker exec -it hivemetastore psql -U postgres

# CREATE DATABASE metastore;
# CREATE USER hive WITH ENCRYPTED PASSWORD '123';
# GRANT ALL ON DATABASE metastore TO hive;