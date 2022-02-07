#!/bin/bash



# start hadoop master container
sudo docker rm -f hadoop-master &> /dev/null
echo "start hadoop-master container..."
sudo docker run -itd \
                --net=hadoop-net \
                -p 50070:50070 \
                -p 8088:8088 \
                -p 9870:9870 \
                -p 9083:9083 \
                -p 9084:9084 \
                --name hadoop-master \
                --hostname hadoop-master \
                vahidbakhtiaryinfo/hive:2.0 &> /dev/null


# get into hadoop master container
sudo docker exec -it hadoop-master bash
