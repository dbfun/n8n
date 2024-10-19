#################################
# Application workflow
#################################

SERVICES=postgres n8n startup

# Run all containers
.PHONY: up
up:
	@docker compose up -d ${SERVICES}

# Stop all containers
.PHONY: down
down:
	@docker compose down

#################################
# n8n CLI
#################################

.PHONY: export-credentials
export-credentials:
	@docker compose exec n8n n8n export:credentials --all --decrypted

.PHONY: list-workflow
list-workflow:
	@docker compose exec n8n n8n list:workflow

# Пример с ID: n8n export:workflow --id=1 --output=./workflow.json
.PHONY: export-workflow
export-workflow:
	@docker compose exec n8n n8n export:workflow --all
