FROM ubuntu:16.04

WORKDIR /root

# set environment vars
ENV HADOOP_HOME /usr/local/hadoop
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV PATH $PATH:$JAVA_HOME/bin
ENV PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin 
ENV HDFS_NAMENODE_USER="root"
ENV HDFS_DATANODE_USER="root"
ENV HDFS_SECONDARYNAMENODE_USER="root"
ENV YARN_RESOURCEMANAGER_USER="root"
ENV YARN_NODEMANAGER_USER="root"
ENV HTTP_PROXY 138.201.145.226:7460
ENV HTTPS_PROXY 138.201.145.226:7460
 
# install packages 
# ssh without key
RUN \
  apt-get update && apt-get install -y \
  openssh-server \
  net-tools \
  ssh \
  rsync \
  vim sudo \
  openjdk-8-jdk && \
  ssh-keygen -t rsa -f ~/.ssh/id_rsa -P '' && \
  cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys


  # download and extract hadoop, set JAVA_HOME in hadoop-env.sh, update path
 ENV HADOOP_VERSION 3.3.1
 ENV HADOOP_URL https://www.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz
 

RUN wget $HADOOP_URL && \
    tar -xzvf hadoop-${HADOOP_VERSION}.tar.gz && \
    mv hadoop-${HADOOP_VERSION} /usr/local/hadoop && \
    rm hadoop-${HADOOP_VERSION}.tar.gz

COPY config/* /tmp/


RUN mv /tmp/ssh_config ~/.ssh/config && \
    mv /tmp/hadoop-env.sh /usr/local/hadoop/etc/hadoop/hadoop-env.sh && \
    mv /tmp/hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml && \ 
    mv /tmp/core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml && \
    mv /tmp/mapred-site.xml $HADOOP_HOME/etc/hadoop/mapred-site.xml && \
    mv /tmp/yarn-site.xml $HADOOP_HOME/etc/hadoop/yarn-site.xml && \
    mv /tmp/workers $HADOOP_HOME/etc/hadoop/workers && \
    mv /tmp/start-hadoop.sh ~/start-hadoop.sh && \
    mv /tmp/run-wordcount.sh ~/run-wordcount.sh &&\
    mkdir -p /usr/local/hadoop/hdfs/namenode && \ 
    mkdir -p /usr/local/hadoop/hdfs/datanode && \
    mkdir $HADOOP_HOME/logs && \  
    chmod +x ~/start-hadoop.sh && \
    chmod +x ~/run-wordcount.sh && \
    chmod +x $HADOOP_HOME/sbin/start-dfs.sh && \
    chmod +x $HADOOP_HOME/sbin/start-yarn.sh && \
    /usr/local/hadoop/bin/hdfs namenode -format



VOLUME [ "/usr/local/hadoop/hdfs/datanode", "/usr/local/hadoop/hdfs/namenode" ]
CMD [ "sh", "-c", "service ssh start; bash"]

EXPOSE 8088 9870 9864 19888 8042 8888
