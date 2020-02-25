# select operating system
FROM alpine

# install operating system packages 
RUN apk add unzip wget curl git bash openjdk8 gettext make coreutils procps && apk update

# add config, init and source files 
# entrypoint
ADD init /opt/docker-init
ADD conf /opt/docker-conf

# folders
RUN mkdir /opt/apache-livy \
    && mkdir /var/apache-spark-binaries/ \
    && wget https://www-eu.apache.org/dist/incubator/livy/0.6.0-incubating/apache-livy-0.6.0-incubating-bin.zip -O /tmp/livy.zip \
    && unzip /tmp/livy.zip -d /opt/ \
    && mkdir /opt/apache-livy-0.6.0-incubating-bin/logs \
    && wget https://archive.apache.org/dist/spark/spark-2.4.4/spark-2.4.4-bin-hadoop2.7.tgz -O /tmp/spark-2.4.4-bin-hadoop2.7.tgz \
    && tar -xvzf /tmp/spark-2.4.4-bin-hadoop2.7.tgz -C /opt/ \
    && git clone https://github.com/cha87de/bashutil.git

# expose ports
EXPOSE 8998

# start from init folder
WORKDIR /opt/docker-init
ENTRYPOINT ["./entrypoint"]