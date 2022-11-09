sudo docker rm -f spark-worker-2
echo "start spark-master container..."
sudo docker run -itd \
                --net=hadoop-net \
                -p 8082:8082 \
                --name spark-worker-2 \
                --hostname spark-worker-2 \
                spark-worker


# get into hadoop master container
#sudo docker exec -it spark-master bash