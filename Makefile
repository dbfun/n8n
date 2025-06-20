#################################
# Application workflow
#################################

SERVICES=postgres n8n test-n8n startup qdrant ollama init-ollama redis browserless nocodb open-webui docling

# Run all containers
.PHONY: up
up:
	@docker compose up -d ${SERVICES}

# Stop all containers
.PHONY: down
down:
	@docker compose down

#################################
# Update n8n
#################################

.PHONY: update
update:
	@docker pull docker.n8n.io/n8nio/n8n
	@docker compose up -d ${SERVICES}

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

#################################
# backup
#################################

.PHONY: backup
backup:
	@docker compose exec n8n n8n export:credentials --all --output=/home/node/backups/credentials.json
	@docker compose exec n8n n8n export:workflow --all --output=/home/node/backups/workflows.json
	@docker compose exec n8n cp /home/node/.n8n/config /home/node/backups

.PHONY: restore
restore:
	@docker compose exec n8n n8n import:credentials --input=/home/node/backups/credentials.json
	@docker compose exec n8n n8n import:workflow --input=/home/node/backups/workflows.json