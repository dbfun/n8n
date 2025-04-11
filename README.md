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
WEBHOOK_URL=<YOUR-NGROK-URL>
```

Затем перезапускаем: `make up`.

[Ссылка на ману](https://docs.n8n.io/integrations/builtin/credentials/getresponse/#configure-oauth2-credentials-for-a-local-environment)

## Запуск на сервере

Через GitLab: [.gitlab-ci.yml](.gitlab-ci.yml). Требуется Traefik как реверс-прокси.

## Решение проблем

### Не запускается Postgres

`dc logs -f --tail=1000 postgres` выдает такую ошибку:

```
PANIC:  could not locate a valid checkpoint record
```

Решение.

Делаем резервную копию файлов или volume для postgres.

Добавляем `command: sleep infinity` в docker-compose файл для postgres. Заново запускаем `make up`.

Postgres-контейнер запустится, но сам postgres-сервер не будет запущен.

Во втором терминале входим в контейнер: `dc exec --user=postgres postgres bash`.

Выполняем команду: `pg_resetwal -f /var/lib/postgresql/data`.

Удаляем `sleep` из docker-compose файла, перезапускаем. Должно работать!