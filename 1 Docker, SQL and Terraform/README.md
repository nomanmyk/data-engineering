### Docker basic stuff
```
FROM python:3.12.8
RUN pip install pandas
WORKDIR /app
COPY pipeline.py pipeline.py
ENTRYPOINT ["bash"]
#ENTRYPOINT ["python", "pipeline.py"]
```
pip version 24.3.1 
### Pipeline
```

import sys
import pandas 

print(sys.argv)

day = sys.argv[1]

print(f'job finished successfully for day = {day}')
```
### Docker image of posgres with pgadmin

1. goto docker hub site and look for official image of post gres https://hub.docker.com/_/postgres
2. Pick alpine image as it is light weight.
3. pull the version you like docker pull <image_name>:<tag> (you can skip this step, dockers pulls image if it doesn't find it)
4. run docker 
      ```
      docker run -itd \
    -e POSTGRES_USER="root" \
    -e POSTGRES_PASSWORD="root" \
    -e POSTGRES_DB="ny_taxi" \
    -v $(pwd)/ny_taxi_postgres_data:/var/lib/postgresql/ny_taxi_postgres_data_book \
    -p 5432:5432 \
    postgres:17.2-alpine3.21
      ```
5. connect from pg admin
          docker run -it -e PGADMIN_DEFAULT_EMAIL=admin@example.com \
          -e PGADMIN_DEFAULT_PASSWORD=root \
          -p 8080:80 \
          dpage/pgadmin4
   
### Network 
    
     1. docker network create pg-network
     
     2. docker run -itd \
      -e POSTGRES_USER="root" \
      -e POSTGRES_PASSWORD="root" \
      -e POSTGRES_DB="ny_taxi" \
      -v $(pwd)/ny_taxi_postgres_data:/var/lib/postgresql/ny_taxi_postgres_data_book \
      -p 5432:5432 \
      --network=pg-network \
      --name postgres
      postgres:17.2-alpine3.21
      
      3. docker run -it -e PGADMIN_DEFAULT_EMAIL=admin@example.com \
            -e PGADMIN_DEFAULT_PASSWORD=root \
            -p 8080:80 \
            --network=pg-network
            dpage/pgadmin4  
    
### Docker networking and docker-compose 
