#!/bin/bash
set -e;


if [ -n "${POSTGRES_NON_ROOT_USER:-}" ] && [ -n "${POSTGRES_NON_ROOT_PASSWORD:-}" ]; then
	psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
		CREATE USER ${POSTGRES_NON_ROOT_USER} WITH PASSWORD '${POSTGRES_NON_ROOT_PASSWORD}';
		GRANT ALL PRIVILEGES ON DATABASE ${POSTGRES_DB} TO ${POSTGRES_NON_ROOT_USER};
		GRANT CREATE ON SCHEMA public TO ${POSTGRES_NON_ROOT_USER};

		CREATE DATABASE test_n8n OWNER ${POSTGRES_NON_ROOT_USER};
    GRANT ALL PRIVILEGES ON DATABASE test_n8n TO ${POSTGRES_NON_ROOT_USER};

    CREATE DATABASE project_1 OWNER ${POSTGRES_NON_ROOT_USER};
    GRANT ALL PRIVILEGES ON DATABASE project_1 TO ${POSTGRES_NON_ROOT_USER};

    CREATE DATABASE test_project_1 OWNER ${POSTGRES_NON_ROOT_USER};
    GRANT ALL PRIVILEGES ON DATABASE test_project_1 TO ${POSTGRES_NON_ROOT_USER};
	EOSQL
else
	echo "SETUP INFO: No Environment variables given!"
fi
