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

