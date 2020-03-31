# select operating system
FROM alpine

# install operating system packages

# add config, init and source files 
# entrypoint
ADD init /opt/docker-init
ADD conf /opt/docker-conf

# folders
RUN apk add unzip wget curl git bash openjdk8 gettext make coreutils procps \
    && apk update \
    && wget https://www-eu.apache.org/dist/incubator/livy/0.6.0-incubating/apache-livy-0.6.0-incubating-bin.zip -O /tmp/livy.zip \
    && wget https://archive.apache.org/dist/spark/spark-2.4.3/spark-2.4.3-bin-hadoop2.7.tgz -O /tmp/spark.tgz \
    && unzip /tmp/livy.zip -d /opt/ \
    && tar -xvzf /tmp/spark.tgz -C /opt/ \
    && wget https://jdbc.postgresql.org/download/postgresql-42.2.10.jar -P /opt/spark-2.4.3-bin-hadoop2.7/jars \
    && git clone https://github.com/cha87de/bashutil.git

# expose ports
EXPOSE 8998

# start from init folder
WORKDIR /opt/docker-init
ENTRYPOINT ["./entrypoint"]