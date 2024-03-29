FROM vahidbakhtiaryinfo/hadoop:2.0


# install packages
RUN \
  apt-get update && apt-get install -y \
  curl



# Stage 1 - Build Tez
ARG TEZ_VERSION=0.9.2
ENV TEZ_HOME=/usr/local/tez
ENV TEZ_CONF_DIR=/usr/local/tez/conf
ENV TEZ_LIB_DIR=/opt/tez

RUN wget https://dlcdn.apache.org/tez/${TEZ_VERSION}/apache-tez-${TEZ_VERSION}-bin.tar.gz && \
    tar -xzvf apache-tez-${TEZ_VERSION}-bin.tar.gz && \
    mv apache-tez-${TEZ_VERSION}-bin ${TEZ_HOME} && \
    rm apache-tez-${TEZ_VERSION}-bin.tar.gz && \
    mkdir -pv $TEZ_CONF_DIR &&\
    mkdir -pv $TEZ_LIB_DIR 

ADD config/tez-site.xml $TEZ_CONF_DIR    


# Stage 2 - Build Hive base
ENV HIVE_HOME=/usr/local/hive
ENV HIVE_CONF_DIR =$/usr/local/hive/conf/
ENV PATH=$HIVE_HOME/bin:$PATH
ARG HIVE_VERSION=3.1.2
ARG HIVE_DOWNLOAD_DIR=/tmp/hive
ARG POSTGRESQL_JDBC_VERSION=42.2.14

 

# RUN curl -fSL https://archive.apache.org/dist/hive/hive-${HIVE_VERSION}/apache-hive-${HIVE_VERSION}-bin.tar.gz -o /tmp/hive.tar.gz \
#     && mkdir -pv $HIVE_DOWNLOAD_DIR \
#     && mkdir -pv $TEZ_CONF_DIR \
#     && mkdir -pv $TEZ_LIB_DIR \
#     && tar -xvf /tmp/hive.tar.gz -C $HIVE_DOWNLOAD_DIR --strip-components=1 \
#     && mv -v $HIVE_DOWNLOAD_DIR /opt \
#     && rm -rfv /tmp/hive.tar.gz \
#     && rm -rfv $HIVE_HOME/lib/guava-*.jar \
#     && cp $HADOOP_HOME/share/hadoop/common/lib/guava-*.jar $HIVE_HOME/lib/ \
#     && rm -rfv $HIVE_HOME/lib/postgresql-*.jre*.jar 

    
RUN wget https://archive.apache.org/dist/hive/hive-${HIVE_VERSION}/apache-hive-${HIVE_VERSION}-bin.tar.gz  && \
    tar -xzvf apache-hive-${HIVE_VERSION}-bin.tar.gz && \
    mv apache-hive-${HIVE_VERSION}-bin ${HIVE_HOME} && \
    rm apache-hive-${HIVE_VERSION}-bin.tar.gz \
  && mkdir -pv $HIVE_DOWNLOAD_DIR \ 
  && chown -R root:root "${HIVE_HOME}" \
  && mkdir -p "${HIVE_HOME}/hcatalog/var/log" \
  && mkdir -p "${HIVE_HOME}/var/log" \
  && mkdir -p "${HIVE_CONF_DIR}" \
  && chmod 777 "${HIVE_HOME}/hcatalog/var/log" \
  && chmod 777 "${HIVE_HOME}/var/log" \
  && rm -rfv $HIVE_HOME/lib/guava-*.jar \
  && cp $HADOOP_HOME/share/hadoop/common/lib/guava-*.jar $HIVE_HOME/lib/ \
  && rm -rfv $HIVE_HOME/lib/postgresql-*.jre*.jar 


RUN curl -fSL https://jdbc.postgresql.org/download/postgresql-$POSTGRESQL_JDBC_VERSION.jar -o $HIVE_HOME/lib/postgresql-jdbc.jar

#COPY --from=tez-builder /tmp/tez/*.jar $TEZ_LIB_DIR/
#COPY --from=tez-builder /tmp/tez/*.jar $TEZ_LIB_DIR/


# Custom configuration goes here
ADD config/hive-site.xml $HIVE_CONF_DIR
ADD config/core-site.xml $HADOOP_HOME
ADD sh/*sh $HIVE_HOME/bin/
ADD config/metastore-site.xml $HIVE_CONF_DIR
ADD config/metastore-log4j2.properties $HIVE_CONF_DIR
ADD config/beeline-log4j2.properties $HIVE_CONF_DIR
ADD config/hive-exec-log4j2.properties $HIVE_CONF_DIR
ADD config/hive-log4j2.properties $HIVE_CONF_DIR
ADD config/llap-daemon-log4j2.properties $HIVE_CONF_DIR
ADD config/llap-cli-log4j2.properties $HIVE_CONF_DIR

COPY usr/local/hive/lib/*  /usr/local/tez/

RUN mkdir $HIVE_HOME/logs



EXPOSE 9083 10000 10002