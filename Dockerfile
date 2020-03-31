FROM sonatype/nexus3:3.22.0
LABEL maintainer Dwolla Dev <dev+docker-nexus3-crowd@dwolla.com>
LABEL org.label-schema.vcs-url="https://github.com/Dwolla/docker-nexus3-crowd"

USER root
COPY startup.sh /
RUN dnf install -y git which maven && \
    git clone https://github.com/pingunaut/nexus3-crowd-plugin.git && \
    cd nexus3-crowd-plugin && \
    git checkout tags/nexus3-crowd-plugin-3.8.0 && \
    mvn install && \
    cp -ra ~/.m2/repository/com/pingunaut /opt/sonatype/nexus/system/com && \
    echo -e 'mvn\:com.pingunaut.nexus/nexus3-crowd-plugin/3.8.0 = 200' >> /opt/sonatype/nexus/etc/karaf/startup.properties && \
    dnf remove -y git maven && \
    touch /opt/sonatype/nexus/etc/crowd.properties && \
    chown nexus /opt/sonatype/nexus/etc/crowd.properties && \
    chmod u+w /opt/sonatype/nexus/etc/crowd.properties

USER nexus

CMD ["/startup.sh"]
