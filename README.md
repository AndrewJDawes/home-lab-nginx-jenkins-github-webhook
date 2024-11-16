# dockerized-nginx-server

## Testing

### Basic

```
docker build -t home-lab-nginx:dev --target base  .
docker run --network home-lab -p 80:80 -d home-lab-nginx:dev
docker run --network home-lab  --network-alias testing.local.net hashicorp/http-echo -listen=:80 -text="hello world"
sudo echo "127.0.0.1 testing.local.net" >> /etc/hosts
```

### Change the upstream protocol or port

```
docker build -t home-lab-nginx:dev --target base  .
docker run -e NGINX_UPSTREAM_PROTOCOL=https -e NGINX_UPSTREAM_PORT=9001 -p 8080:80 home-lab-nginx:dev
docker run --network home-lab  --network-alias testing.local.net hashicorp/http-echo -listen=:9001 -text="hello world"
sudo echo "127.0.0.1 testing.local.net" >> /etc/hosts
```

### Change the upstream host

```
docker build -t home-lab-nginx:dev --target base  .
docker run -e NGINX_UPSTREAM_PROTOCOL=https -e NGINX_UPSTREAM_HOST=portainer_server -e NGINX_UPSTREAM_PORT=9001 -p 8080:80 home-lab-nginx:dev
docker run --network home-lab  --network-alias portainer_server hashicorp/http-echo -listen=:9001 -text="hello world"
sudo echo "127.0.0.1 testing.local.net" >> /etc/hosts
```
