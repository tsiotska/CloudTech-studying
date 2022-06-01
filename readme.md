To enter a container: 
docker exec -t -i container_id  /bin/sh

To test mongo connection
docker run -it mongo:5.0 mongo --username root --password 1111 --host mongodb.example.org  --authenticationDatabase users users --eval "db.adminCommand({ listDatabases: 1 })"

Changes for pipeline running