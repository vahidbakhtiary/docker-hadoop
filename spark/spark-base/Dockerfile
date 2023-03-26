ARG ubuntu_image_tag=20.04
FROM ubuntu:${ubuntu_image_tag}

# Define build arguments for JDK and Scala versions
ARG JDK_VERSION=11
ARG SCALA_VERSION=2.12.15

# Install required packages
RUN apt-get update -y && \
    apt-get install -y curl python3 && \
    rm -rf /var/lib/apt/lists/*

# Install OpenJDK and set environment variables
ENV JAVA_HOME=/usr/lib/jvm/java-${JDK_VERSION}-openjdk-amd64
ENV PATH=$PATH:$JAVA_HOME/bin
RUN apt-get update -y && \
    apt-get install -y openjdk-${JDK_VERSION}-jdk-headless && \
    rm -rf /var/lib/apt/lists/*

# Install Scala and set environment variables
ENV SCALA_HOME=/usr/local/scala
ENV PATH=$PATH:$SCALA_HOME/bin
RUN curl -L "https://downloads.lightbend.com/scala/${SCALA_VERSION}/scala-${SCALA_VERSION}.tgz" | tar xz && \
    mv scala-${SCALA_VERSION} ${SCALA_HOME} && \
    chown -R root:root ${SCALA_HOME}

# -- Layer: Spark

ARG spark_version=3.0.0
ARG hadoop_version=2.7
ENV SPARK_HOME=/usr/local/spark
ENV PATH=$PATH:${SPARK_HOME}/bin

RUN apt-get update -y && \
    apt-get install -y curl && \
    curl https://archive.apache.org/dist/spark/spark-${spark_version}/spark-${spark_version}-bin-hadoop${hadoop_version}.tgz -o spark.tgz && \
    tar -xf spark.tgz && \
    mv spark-${spark_version}-bin-hadoop${hadoop_version} ${SPARK_HOME} && \
    mkdir ${SPARK_HOME}/logs && \
    rm spark.tgz

ENV SPARK_MASTER_HOST spark-master
ENV SPARK_MASTER_PORT 7077
ENV PYSPARK_PYTHON python3

COPY config/hive-site.xml ${SPARK_HOME}/conf/

# -- Runtime

WORKDIR ${SPARK_HOME}
