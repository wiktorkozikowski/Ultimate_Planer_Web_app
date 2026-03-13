FROM postgres:18.3

# Any *.sql, *.sql.gz or executable *.sh scripts placed here
# are run automatically on first database initialization.
COPY migrations/ /docker-entrypoint-initdb.d/10-migrations/
COPY seeds/ /docker-entrypoint-initdb.d/20-seeds/

EXPOSE 5432
