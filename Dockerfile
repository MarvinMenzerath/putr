FROM node:9.11.1-alpine
LABEL maintainer="Marvin Menzerath <github@marvin-menzerath.de>"

RUN apk --no-cache upgrade && \
    apk --no-cache add curl

WORKDIR /app/putr/
COPY . /app/putr/
RUN cd /app/putr/ && \
    npm install --only=production

EXPOSE 80
VOLUME /app/putr/config/
HEALTHCHECK --timeout=5s CMD curl --fail http://localhost:80/health || exit 1
ENTRYPOINT ["/usr/local/bin/npm", "start"]