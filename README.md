# n8n

Запуск self-hosted [n8n](https://n8n.io/) с помощью `docker compose`.

## Конфигурация

Скопировать `.env.dist` в `.env` и отредактировать последний.

## Локальный запуск

Команда для запуска: `make up`.

### Локальные веб-хуки

Изначально веб-хуки локально работать не будут, так как должны быть доступны из интернета. Для этого делаем туннель:

```bash
ngrok http 5678
```

Затем прописать в `.env`:

```
export WEBHOOK_URL=<YOUR-NGROK-URL>
```

Затем перезапускаем: `make up`.

[Ссылка на ману](https://docs.n8n.io/integrations/builtin/credentials/getresponse/#configure-oauth2-credentials-for-a-local-environment)

## Запуск на сервере

Через GitLab: [.gitlab-ci.yml](.gitlab-ci.yml). Требуется Traefik как реверс-прокси.
