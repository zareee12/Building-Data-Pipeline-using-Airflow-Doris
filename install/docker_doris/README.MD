===============Installation Guide for Apache Doris==============

1. Please install Docker to your system first. You can refer to this URL:

https://www.docker.com/products/docker-desktop/

2. Verify the installation process by executing this command:

docker --version

3. Execute this command from your terminal inside this directory path:

sudo docker compose -f docker-compose.yml up -d

4. Open The Apache Doris Web UI by accessing this URL:

localhost:8030

5. Or using mysql client CLI :

mysql -u root -h [your local ip address] -P 9030
