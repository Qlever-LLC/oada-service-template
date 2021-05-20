# USING THIS TEMPLATE

Once you clone this template repo,
be sure to change the name by replacing `oada-service-template`
(e.g., `sed -i 's/oada-service-template/trellisfw\/awesome-service/g' *`).

You probably will also want to update the license stuff.

Finally, remove this section from the README.

# oada-service-template

[![License](https://img.shields.io/github/license/oada-service-template)](LICENSE)
[![Docker Pulls](https://img.shields.io/docker/pulls/oada-service-template)][dockerhub]

This is a microservice which moves (actually just makes links)
resources from a "watch list" to another list based on rules.

## Usage

Docker images for oada-service-template are available from GitHub Container Registry.

### docker-compose

Here is an example of using this service with docker-compose.

```yaml
services:
  service:
    image: oada-service-template
    restart: unless-stopped
    environment:
      NODE_TLS_REJECT_UNAUTHORIZED:
      NODE_ENV=: ${NODE_ENV:-development}
      DEBUG: ${DEBUG-*:error,*:warn,*:info}
      # Connect to host if DOMAIN not set.
      # You should really not rely on this though. Set DOMAIN.
      DOMAIN: ${DOMAIN:-host.docker.internal}
      # Unless your API server is running with development tokens enabled,
      # you will need to give the service token(s) to use.
      TOKEN: ${TOKEN:-abc123,def456}
```

### Running oada-service-template within the [OADA Reference API Server]

To add this service to the services run with an OADA v3 server,
simply add a snippet like the one in the previous section
to your `docker-compose.override.yml`.

### External Usage

To run this service separately,
simply set the domain and token(s) of the OADA API.

```shell
# Set up the environment.
# Only need to run these the first time.
echo DOMAIN=api.oada.example.com > .env # Set API domain
echo TOKEN=abc123 >> .env # Set API token(s) for the service

# Start the service
docker-compose up -d
```

[dockerhub]: https://hub.docker.com/repository/docker/oada-service-template
[oada reference api server]: https://github.com/OADA/server
