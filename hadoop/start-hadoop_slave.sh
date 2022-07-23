#!/bin/bash


# the default node number is 2
N=${1:-3}

# start hadoop slave container
i=1
while [ $i -lt $N ]
do
	sudo docker rm -f hadoop-slave1-$i &> /dev/null
	echo "start hadoop-slave1-$i container..."
	sudo docker run -itd  \
	 				--net=hadoop-net \
	                --name hadoop-slave1-$i \
	                --hostname hadoop-slave1-$i \
					-v dataNode$i:/usr/local/hadoop/hdfs/datanode \
	                 vahidbakhtiary/hadoop-eco:1.0 &> /dev/null
	i=$(( $i + 1 ))
done 

  

					
