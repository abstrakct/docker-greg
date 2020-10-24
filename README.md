# Greg docker container
Simple docker container for running greg (a cli podcast downloader)

forked from DArtagan/docker-greg

Cron is used in the container to run greg every day at 06:00 (6 AM).

To be notified after a (not) successful download, set environment APPRISE_SERVICE to wherever you want to be notified. See
https://github.com/caronc/apprise for details about available services.

If environment variables DL_USER and DL_GROUP are set, each downloaded podcast episode will be chown'ed to that user/group.

Example docker-compose entry:

```
greg:
  image: vortexsurfer/greg:latest
  container_name: greg
  environment:
    - TZ=Europe/Oslo
    - APPRISE_SERVICE=discord://webhook_id/webhook_token
    - DL_USER=1000
    - DL_GROUP=1000
  volumes:
    - /path/to/config/greg:/data
    - /path/to/download/directory:/podcasts
  restart: unless-stopped
```

