# dockerized-nginx-server

## Local Testing

- **Generate two SSL cert files (pub/priv) locally:**
    - Run the following command:
      ```bash
      sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ~/.ssl/privkey.pem -out ~/.ssl/fullchain.pem
      ```
    - After running the command, you will be prompted to enter information for your certificate:
        - **Country Name (2 letter code)**: Enter your country code (e.g., US for the United States).
        - **State or Province Name (full name)**: Enter your state or province (e.g., Pennsylvania).
        - **Locality Name (e.g., city)**: Enter your city (e.g., Harrisburg).
        - **Organization Name (e.g., company)**: Enter your organization name (e.g., My Company).
        - **Organizational Unit Name (e.g., section)**: Enter a department name (e.g., DEV).
        - **Common Name (e.g., your name or your server’s hostname)**: Enter the domain name you want the certificate to cover (e.g., example.com or localhost).
        - **Email Address**: Enter your email address (optional).

- **Update the local SSL paths in `dev/docker-compose.yml`** to match where your SSL cert files are located locally and make sure the cert files are getting mounted to `/etc/nginx/site_certs/` on the Nginx container:
    - Example:
      ```yaml
      - ~/.ssl/privkey.pem:/etc/nginx/site_certs/privkey.pem
      - ~/.ssl/fullchain.pem:/etc/nginx/site_certs/fullchain.pem
      ```

- **Register a Docker container with the reverse proxy:**
    - Update `docker-compose.yml` to include your backend service.
    - Assign `nginx-reverse-proxy` as the container's network, then use `links` to create an alias on the network for your container (`container_name:alias`).
    - Example:
      ```yaml
      services:
        nginx:
          build:
            context: ..
            dockerfile: Dockerfile
          volumes:
            - ~/.ssl/privkey.pem:/etc/nginx/site_certs/privkey.pem
            - ~/.ssl/fullchain.pem:/etc/nginx/site_certs/fullchain.pem
          ports:
            - 443:443
            - 80:80
          networks:
            - nginx-reverse-proxy
          links:
            - hello-world:hello-world.test.drew
            - hello-world2:hello-world2.test.drew

        hello-world:
          image: nginxdemos/hello
          networks:
            - nginx-reverse-proxy

        hello-world2:
          image: nginxdemos/hello
          networks:
            - nginx-reverse-proxy

      networks:
        nginx-reverse-proxy:
          driver: bridge
      ```

- **Add your alias to your hosts file:**
  - `127.0.0.1 hello-world.test.drew`
  - `127.0.0.1 hello-world2.test.drew`

- **Run Docker Compose:**
  - Change directory into `dev` and run `docker-compose up`

Now, both Nginx and your registered containers should be up and running. You should be able to visit your alias in your browser to verify that everything is working correctly.
