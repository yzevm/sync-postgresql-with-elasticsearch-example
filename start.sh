# create indices with mappings
curl -i -X PUT -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:9200/users -d @reqs/mappings/users.json
curl -i -X PUT -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:9200/posts -d @reqs/mappings/posts.json
curl -i -X PUT -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:9200/comments -d @reqs/mappings/comments.json

# setup connections
curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:8083/connectors/ -d @reqs/connections/es-sink-users.json
curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:8083/connectors/ -d @reqs/connections/es-sink-posts.json
curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:8083/connectors/ -d @reqs/connections/es-sink-comments.json
curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:8083/connectors/ -d @reqs/connections/source.json
