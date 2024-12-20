Vorraussetzungen:
- **Jellyfin**: Ein installierter und laufender Jellyfin-Server.
- **Docker-Kenntnisse**: Grundlegendes Verständnis der Docker-Befehle und -Konzepte.

## Einrichtung

Als ersten fügst du einen neuen Live Tuner hinzu.
Dann setzt du den Typ auf M3U und die URL auf: 

```
https://raw.githubusercontent.com/Bensonheimer992/LiveTV/refs/heads/main/de.m3u
```

### Vorgefertigte EPG Dateien
```bash
https://tvf.np200.de/tv/hdplus/guide.xml
https://tvf.np200.de/tv/magenta-at/guide.xml
https://tvf.np200.de/tv/magenta-tv/guide.xml
https://tvf.np200.de/tv/horizion/guide.xml
```

Wenn du deine eigenen EPG Dateien machen willst mache mit dem Tutorial einfach weiter

Führe dann diesen Command aus:
```bash
touch /path/guide.xml
```

Und ersetze "path" mit dem Pfad wo du die Datei Speichern willst 

Jetzt führst du diesen Command aus: 
```bash
docker run 
-it 
-d 
--name epggetter 
--restart unless-stopped 
-e SITE=site 
-e MAX_CONNECTIONS=100 
-v /path/guide.xml:/app/guide.xml
bensonheimer992/iptv-epg 
```

Und ersetze "path" wieder mit dem Pfad den du oben mit touch Command angegeben hast.
Ersetze außerdem site mit einem Provider aus dieser Liste:

```
https://github.com/iptv-org/epg/blob/master/SITES.md
```

Jetzt führe diesen Command aus:
```bash
docker run 
-it 
-d 
--name nginx
--restart unless-stopped
-v /path/guide.xml:/config/www/guide.xml
-p 8080:80
nginx
```

Und ersetze "path" wieder mit dem Pfad den du oben mit touch Command angegeben hast.
