Prerequisites:
- **Jellyfin**: An installed and running Jellyfin server.
- **Docker-Kenntnisse**: Basic understanding of Docker commands and concepts.

## Setup

The first step is to add a new Live Tuner.
Then set the type to M3U and the URL to : 

```
https://iptv-org.github.io/iptv/languages/eng.m3u
```

### Ready-made EPG files
```bash
https://tvf.np200.de/tv/magenta-at/guide.xml
https://tvf.np200.de/tv/magenta-tv/guide.xml
https://tvf.np200.de/tv/horizon/guide.xml
https://tvf.np200.de/tv/tvheute/guide.xml
https://tvf.np200.de/tv/mjh/guide.xml
https://tvf.np200.de/tv/tvblue/guide.xml
```

If you want to make your own EPG files just continue with the tutorial

Then execute this command:
```bash
touch /path/guide.xml
```

And replace “path” with the path where you want to save the file 

Now execute this command: 
```bash
docker run 
-it 
-d 
--name epggetter 
--restart unless-stopped 
-e SITE=site 
-e MAX_CONNECTIONS=100
-e LANG=en
-v /path/guide.xml:/app/guide.xml
bensonheimer992/iptv-epg 
```

And replace “path” again with the path you specified above with touch Command.
Also replace site with a provider from this list:

```
https://github.com/iptv-org/epg/blob/master/SITES.md
```

Now execute this command:
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

And replace “path” with the path you specified above with touch Command.
