FROM ghost:6-alpine

# Lege das Arbeitsverzeichnis fest
WORKDIR /var/lib/ghost

# Kopiere lokale Inhalte (Themes, Images)
COPY ./content ./content

# Kopiere die Google-Verifizierungsdatei
COPY google7d71a7a39178d2cc.html /google7d71a7a39178d2cc.html

# Setze die Standard-URL (wird später überschrieben)
ENV url=http://localhost:2368

# Exponiere den Ghost-Port
EXPOSE 2368
