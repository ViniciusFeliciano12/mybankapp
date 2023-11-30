FROM mysql:8.0.33

ENV MYSQL_ROOT_PASSWORD=moneymanager
ENV MYSQL_DATABASE=moneymanager_db

COPY ./scripts/ /docker-entrypoint-initdb.d/

EXPOSE 3306