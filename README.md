# docker-nexus3-crowd

Docker image that installs [nexus3-crowd-plugin](https://github.com/pingunaut/nexus3-crowd-plugin)

At runtime, the following environment variables need to be passed to the container
- CROWD_URL
- CROWD_USER
- CROWD_PASSWORD
- CROWD_CACHE_AUTHENTICATION (true or false)
-- if true will configure plugin to cache authentication
