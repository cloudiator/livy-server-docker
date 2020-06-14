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
    && wget https://www-eu.apache.org/dist/incubator/livy/0.7.0-incubating/apache-livy-0.7.0-incubating-bin.zip -O /tmp/livy.zip \
    && apk add --no-cache libc6-compat \
    && ln -s /lib/libc.musl-x86_64.so.1 /lib/ld-linux-x86-64.so.2 \
    && wget https://archive.apache.org/dist/spark/spark-2.4.3/spark-2.4.3-bin-hadoop2.7.tgz -O /tmp/spark.tgz \
    && unzip /tmp/livy.zip -d /opt/ \
    && tar -xvzf /tmp/spark.tgz -C /opt/ \
    # postgres jar
    && wget https://jdbc.postgresql.org/download/postgresql-42.2.10.jar -P /opt/spark-2.4.3-bin-hadoop2.7/jars \
    # spark-excel support
    && wget https://oss.sonatype.org/content/repositories/public/com/crealytics/spark-excel_2.11/0.13.1/spark-excel_2.11-0.13.1.jar -P /opt/spark-2.4.3-bin-hadoop2.7/jars \
    && wget https://repo1.maven.org/maven2/org/apache/commons/commons-collections4/4.1/commons-collections4-4.1.jar -P /opt/spark-2.4.3-bin-hadoop2.7/jars \
    && wget https://repo1.maven.org/maven2/org/apache/xmlbeans/xmlbeans/3.1.0/xmlbeans-3.1.0.jar -P /opt/spark-2.4.3-bin-hadoop2.7/jars \
    && wget https://repo1.maven.org/maven2/org/apache/poi/poi-ooxml-schemas/4.1.2/poi-ooxml-schemas-4.1.2.jar -P /opt/spark-2.4.3-bin-hadoop2.7/jars \
    && git clone https://github.com/cha87de/bashutil.git

# expose ports
EXPOSE 8998

# start from init folder
WORKDIR /opt/docker-init
ENTRYPOINT ["./entrypoint"]