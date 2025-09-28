FROM ghost:6-alpine

# Lege das Arbeitsverzeichnis fest
WORKDIR /var/lib/ghost

# Kopiere lokale Inhalte (Themes, Images)
COPY ./content ./content

# Setze die Standard-URL (wird später überschrieben)
ENV url=http://localhost:2368

# Exponiere den Ghost-Port
EXPOSE 2368