# -- Software Stack Version

SPARK_VERSION="3.3.1"
HADOOP_VERSION="3"


docker build \
  -f spark-base/Dockerfile \
  -t spark-base .



# docker build \
#   --build-arg spark_version="${SPARK_VERSION}" \
#   --build-arg hadoop_version="${HADOOP_VERSION}" \
#   -f spark-base/Dockerfile \
#   -t spark-base .

# docker build \
#   -f spark-master/Dockerfile \
#   -t spark-master .
  
#  docker build \
#   -f spark-worker/Dockerfile \
#   -t spark-worker .



 