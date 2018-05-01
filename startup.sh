#!/bin/bash

cat << __EOF__ > /opt/sonatype/nexus/etc/crowd.properties
crowd.server.url=${CROWD_URL}
application.name=${CROWD_USER}
application.password=${CROWD_PASSWORD}
cache.authentication=${CROWD_CACHE_AUTHENTICATION}
__EOF__

"${SONATYPE_DIR}/start-nexus-repository-manager.sh"
