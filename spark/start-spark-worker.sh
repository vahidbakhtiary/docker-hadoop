sudo docker rm -f spark-worker
echo "start spark-master container..."
sudo docker run -itd \
                --net=hadoop-net \
                -p 8083:8080 \
                --name spark-worker \
                --hostname spark-worker \
                spark-worker


# get into hadoop master container
#sudo docker exec -it spark-master bash