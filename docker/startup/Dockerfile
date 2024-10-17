FROM alpine

RUN apk add --no-cache shadow

# Add a non-root user to prevent files being created with root permissions on host machine.
ARG PUID=1000
ENV PUID ${PUID}
ARG PGID=1000
ENV PGID ${PGID}

RUN groupadd -g ${PGID} startup
RUN useradd -l -u ${PUID} -g startup -m startup -G startup