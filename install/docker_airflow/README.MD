===========Installation Guide for Docker Airflow============

1. Please install Docker to your system first. You can refer to this URL:

https://www.docker.com/products/docker-desktop/

2. Verify the installation process by executing this command:

docker --version

3. Execute this command from your terminal inside this directory path:

sudo docker compose -f compose.yml up -d

4. Open the Airflow Web UI through '$localhost:8080'$
5. Put your DAG inside the `dags` folder
