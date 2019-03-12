# Autotyed

This repo is a collection of configurations, html snippets and code that provide
a way to present many different applications in a single interface and web address.

# HOWTO

Part of the goal of this repo is to document how to
_Reverse Proxy_ the following application through NGINX:

- [Deluge](https://deluge-torrent.org)
- [SecuritySpy](https://www.bensoftware.com/securityspy/)
- [Indigo](https://www.indigodomo.com)
- [Sonarr](https://sonarr.tv)
- [Radarr](https://radarr.video)
- [Lidarr](https://lidarr.audio)
- [Bazarr](https://github.com/morpheus65535/bazarr)
- [Jackett](https://github.com/Jackett/Jackett)
- [NZBGet](https://nzbget.net)
- [Plex](https://www.plex.tv)
- [Tautulli](https://tautulli.com)
- [Ubiquiti UniFI Controller](https://www.ui.com/download/unifi) (latest version not working yet)
- [Grafana](https://grafana.com)

## Now

What is currently provided:

- An nginx config showing how to route traffic to each application.
- A set of images, css, and html to create a minimal web interface.

Eventually I'll provide directions on how to replicate my entire stack, including
installation, configuration and auto-starting services.
I once ran all these apps on a single server, but recently split the security and
automation roles from the media download and display roles; it's now on two computers
and that's why you'll see two different backend IPs in the nginx configuration. Both
computers are macOS 10.13, but the OSS apps also work on Linux (not Indigo or SecuritySpy).

## Bits and Pieces

I have a handful of custom startup scripts and doohickies for Radarr, Jackett, Sonarr, etc.
I also run a few pieces of custom software (found elsewhere on my github) to move data among these apps.

Documenting how all these pieces of software can be tied together is the goal of this repo.
More to come, but some of you will figure it out with the breadcrumbs I've provided.

This is what the main screen looks like:
![Screen Shot of Custom Interface](images/autotyed.png)
