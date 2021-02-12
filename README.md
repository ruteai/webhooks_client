# Cliente de tunnel local seguro para webhooks de integração com Rute.ai

A configuration set-up for a Traefik v2 reverse proxy along with Portainer and Docker Compose.

This set-up makes container management & deployment a breeze and the reverse proxy allows for running multiple applications on one Docker host. Traefik will route all the incoming traffic to the appropriate docker containers and through the open-source app Portainer you can speed up software deployments, troubleshoot problems and simplify migrations.

Detailed explanation how to use this blog post:
[Docker container management with Traefik v2 and Portainer](https://rafrasenberg.com/posts/docker-container-management-with-traefik-v2-and-portainer/)

## How to run the server?

### Create docker networks

```
docker network create proxy
docker network create local
```

### Clone repository
```
$ git clone https://github.com/snapby/docker-traefik-portainer.git ./src
$ cd src/core
$ touch ./traefik-data/acme.json
# sudo chmod 600 ./traefik-data/acme.json
# cp env-sample .env
$ docker-compose up -d
```

## How to use the client?

```
inlets client --url wss://dev001.lt.superchat.com.br --upstream=http://localhost:80 --token=<your_token>
```

# Credits
Based on this [repository](https://github.com/rafrasenberg/docker-traefik-portainer)