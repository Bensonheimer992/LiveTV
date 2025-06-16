# Basis-Image
FROM node:latest

# Installiere notwendige Pakete
RUN apt-get update && apt-get install -y git && \
    rm -rf /var/lib/apt/lists/*

# Installiere PM2 global
RUN npm install -g pm2

# Arbeitsverzeichnis und Repo
WORKDIR /app
RUN git clone https://github.com/iptv-org/epg.git .

# Abhängigkeiten
RUN npm install

COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# Umgebungsvariablen
ENV SITE="web.magentatv.de"
ENV MAX_CONNECTIONS="100"
ENV TZ="Europe/Berlin"
ENV CRON="0 5,16 * * *"
ENV LANG="de"
ENV DAYS="7"

# Startbefehl mit optionaler LANG-Variable
ENTRYPOINT ["/app/start.sh"]
