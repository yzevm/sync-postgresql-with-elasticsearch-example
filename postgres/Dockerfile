FROM debezium/postgres:9.6

COPY ./setup.sql /home/setup.sql
COPY ./fake.sql /home/fake.sql
COPY ./init-db.sh /docker-entrypoint-initdb.d/init-db.sh
