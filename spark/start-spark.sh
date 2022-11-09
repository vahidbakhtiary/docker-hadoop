sudo docker rm -f spark-master
echo "start spark-master container..."
sudo docker run -itd \
                --net=hadoop-net \
                -p 9090:8080 \
                -p 7077:7077 \
                --name spark-master \
                --hostname spark-master \
                spark:1.0  


# get into hadoop master container
sudo docker exec -it spark-master bash