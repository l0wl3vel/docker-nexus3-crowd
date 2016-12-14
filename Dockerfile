FROM sonatype/nexus3:3.1.0
MAINTAINER Dwolla Dev <dev+docker-nexus3-crowd@dwolla.com>
LABEL org.label-schema.vcs-url="https://github.com/Dwolla/docker-nexus3-crowd"

USER root

RUN yum install -y git && \
    curl -o /etc/yum.repos.d/epel-apache-maven.repo https://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo && \
    yum install -y apache-maven && \
    git clone https://github.com/pingunaut/nexus3-crowd-plugin.git && \
    cd nexus3-crowd-plugin && \
    git checkout tags/nexus3-crowd-plugin-3.2.0 && \
    mvn install && \
    cp -ra ~/.m2/repository/com/pingunaut /opt/sonatype/nexus/system/com && \
    echo -e 'mvn\:com.pingunaut.nexus/nexus3-crowd-plugin/3.2.0 = 200' >> /opt/sonatype/nexus/etc/karaf/startup.properties && \
    yum remove -y git && \
    yum remove -y apache-maven && \
    rm /etc/yum.repos.d/epel-apache-maven.repo

USER nexus

CMD echo -e "crowd.server.url=$CROWD_URL\napplication.name=$CROWD_USER\napplication.password=$CROWD_PASSWORD\ncache.authentication=$CROWD_CACHE_AUTHENTICATION" > /opt/sonatype/nexus/etc/crowd.properties && \
    bin/nexus run
