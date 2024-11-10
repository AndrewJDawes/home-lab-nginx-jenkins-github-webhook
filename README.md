# dockerized-nginx-server

## Testing

```
docker build -t home-lab-nginx:dev --target base  .
docker run --network home-lab -p 80:80 -d home-lab-nginx:dev
docker run --network home-lab  --network-alias testing.local.net hashicorp/http-echo -listen=:80 -text="hello world"
sudo echo "127.0.0.1 testing.local.net" >> /etc/hosts
```
