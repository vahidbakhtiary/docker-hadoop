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


 



RUN apt-get install -y --reinstall build-essential
RUN apt-get install -y ssh 
RUN apt-get install -y rsync 
RUN apt-get install -y vim 
RUN apt-get install -y net-tools
RUN apt-get install -y openjdk-8-jdk 
RUN apt-get install -y python2.7-dev 
RUN apt-get install -y libxml2-dev 
RUN apt-get install -y libkrb5-dev 
RUN apt-get install -y libffi-dev 
RUN apt-get install -y libssl-dev 
RUN apt-get install -y libldap2-dev 
RUN apt-get install -y python-lxml 
RUN apt-get install -y libxslt1-dev 
RUN apt-get install -y libgmp3-dev 
RUN apt-get install -y libsasl2-dev 
RUN apt-get install -y libsqlite3-dev  
RUN apt-get install -y libmysqlclient-dev

RUN \
    if [ ! -e /usr/bin/python ]; then ln -s /usr/bin/python2.7 /usr/bin/python; fi


   # HUE
 ENV HUE_VERSION 3.3.1

ENV HUE_URL https://www.dropbox.com/s/auwpqygqgdvu1wj/hue-4.1.0.tgz
RUN wget $HUE_URL && \
    tar -xzvf hue-${HUE_VERSION}.tar.gz && \
    mv hue-${HUE_VERSION} /usr/local/hue && \
    rm hue-${HUE_VERSION}.tar.gz

WORKDIR /opt/hue
RUN make apps
RUN chown -R hue:hue /usr/local/hue
WORKDIR /

    
ADD hue.ini /usr/local/hue/desktop/conf

VOLUME [ "/usr/local/hadoop/hdfs/datanode", "/usr/local/hadoop/hdfs/namenode" ]
CMD [ "sh", "-c", "service ssh start; bash"]

EXPOSE 8088 9870 9864 19888 8042 8888