# Sync PostgreSQL with Elasticsearch via Debezium

### Schema

```
                   +-------------+
                   |             |
                   |  PostgreSQL |
                   |             |
                   +------+------+
                          |
                          |
                          |
          +---------------v------------------+
          |                                  |
          |           Kafka Connect          |
          |    (Debezium, ES connectors)     |
          |                                  |
          +---------------+------------------+
                          |
                          |
                          |
                          |
                  +-------v--------+
                  |                |
                  | Elasticsearch  |
                  |                |
                  +----------------+


```
We are using Docker Compose to deploy the following components:

* PostgreSQL
* Kafka
  * ZooKeeper
  * Kafka Broker
  * Kafka Connect with [Debezium](http://debezium.io/) and [Elasticsearch](https://github.com/confluentinc/kafka-connect-elasticsearch) Connectors
* Elasticsearch

### Usage

```shell
docker-compose up --build

# wait until it's setup
./start.sh
```

### Testing

Check database's content

```shell
# Check contents of the PostgreSQL database:
docker-compose exec postgres bash -c 'psql -U $POSTGRES_USER $POSTGRES_DATABASE -c "SELECT * FROM users"'

# Check contents of the Elasticsearch database:
curl http://localhost:9200/users/_search?pretty
```

Create user

```shell
docker-compose exec postgres bash -c 'psql -U $POSTGRES_USER $POSTGRES_DATABASE'
test_db=# INSERT INTO users (email) VALUES ('apple@gmail.com');

# Check contents of the Elasticsearch database:
curl http://localhost:9200/users/_search?q=id:6
```

```json
{
  ...
  "hits": {
    "total": 1,
    "max_score": 1.0,
    "hits": [
      {
        "_index": "users",
        "_type": "_doc",
        "_id": "6",
        "_score": 1.0,
        "_source": {
          "id": 6,
          "email": "apple@gmail.com"
        }
      }
    ]
  }
}
```

Update user

```shell
test_db=# UPDATE users SET email = 'tesla@gmail.com' WHERE id = 6;

# Check contents of the Elasticsearch database:
curl http://localhost:9200/users/_search?q=id:6
```

```json
{
  ...
  "hits": {
    "total": 1,
    "max_score": 1.0,
    "hits": [
      {
        "_index": "users",
        "_type": "_doc",
        "_id": "6",
        "_score": 1.0,
        "_source": {
          "id": 6,
          "email": "tesla@gmail.com"
        }
      }
    ]
  }
}
```

Delete user

```shell
test_db=# DELETE FROM users WHERE id = 6;

# Check contents of the Elasticsearch database:
curl http://localhost:9200/users/_search?q=id:6
```

```json
{
  ...
  "hits": {
    "total": 1,
    "max_score": 1.0,
    "hits": []
  }
}
```
