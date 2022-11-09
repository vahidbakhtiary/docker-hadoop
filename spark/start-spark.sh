sudo docker rm -f spark-master
echo "start spark-master container..."
sudo docker run -itd \
                --net=hadoop-net \
                -p 8080:8080 \
                -p 7077:7077 \
                --name spark-master \
                --hostname spark-master \
                spark-master


# get into hadoop master container
#sudo docker exec -it spark-master bash