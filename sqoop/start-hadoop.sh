#!/bin/bash



# start hadoop master container
sudo docker rm -f hadoop-master
echo "start hadoop-master container..."
sudo docker run -itd \
                --net=hadoop-net \
                -p 50070:50070 \
                -p 8088:8088 \
                -p 9870:9870 \
                -p 9083:9083  \
                -p 10000:10000 \
                -p 10001:10001 \
                -p 10002:10002  \
                -p 1527:1527  \
                --name hadoop-master \
                --hostname hadoop-master \
                -v nameNode:/usr/local/hadoop/hdfs/namenode \
                sqoop:1.0  


# get into hadoop master container
sudo docker exec -it hadoop-master bash
