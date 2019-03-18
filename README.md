# Autotyed

This repo is a collection of configurations, html snippets and code that provide
a way to present many different applications in a single interface and web address.

This is mostly geared toward macOS X users. I started my server adventure on a mac
because I really like Indigo and SecuritySpy; they're mac-only. All of my trials
and tribulations leading up to a solid home-media environment have been with macs.

As the [repo wiki](../../wiki) gets built out I expect new solutions to come to fruition and
more Linux and/or Docker support provided. Please check back once in a while for updates!

**This readme is quickly going to become out of date. See the [wiki](../../wiki) for the latest info.**

# HOWTO

Part of the goal of this repo is to document how to
_Reverse Proxy_ the following application through NGINX using a single hostname:

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
- [Ubiquiti UniFI Controller](https://www.ui.com/download/unifi) - latest version not working yet
- [Grafana](https://grafana.com)

Additionally, information is provided to install and configure:
- [Nginx](https://www.nginx.com) - web server with auto-renewing SSL cert from [Let's Encrypt](https://letsencrypt.org) using [certbot](https://certbot.eff.org)
- [InfluxDB](https://www.influxdata.com) - time series database for Grafana backend
- [Glances](https://nicolargo.github.io/glances/) - stores systems metrics in InfluxDB
- [unpacker-poller](https://github.com/davidnewhall/unpacker-poller) - to extract Deluge downloads
- [unifi-poller](https://github.com/davidnewhall/unifi-poller) - optionally store UniFI controller metrics in InfluxDB

## Now

What is currently provided:

- An nginx config showing how to route traffic to each application.
- A set of images, css, and html to create a minimal web interface.
- macOS startup scripts for several applications that lack their own.
- Minimal installation scripts for macOS.
  - Run `make install` to automatically install most of the dependencies on a mac server.
  - You should read the scripts and understand what they do before running `make install`.
- A [wiki](../../wiki) where installation instructions will be refined.

**Pull requests for Linux and/or Docker are welcomed!** I run all this stuff on
dedicated Mac servers, so I have no need to venture down the Linux path. All of
this open source software was originally designed for Linux and works great
there too!

I'm still putting all these pieces together so I can rebuild my mac servers if
they die. After the installation scripts are finished, I'll work on a wiki to
document all of the installation and post-installation steps. Hopefully a howto
video will show up too!

## Bits and Pieces

I have a handful of custom startup scripts and doohickies for Radarr, Jackett, Sonarr, etc.
I also run a few pieces of custom software (found elsewhere on my github) to move data among these apps.

Documenting how all these pieces of software can be installed, auto-started, monitored
and tied together is the goal of this repo.
More to come, but some of you will figure it out with the breadcrumbs I've provided.

This is what the provided html page looks like. It's responsive and looks great on any device:
![Screen Shot of Custom Interface](https://raw.githubusercontent.com/wiki/davidnewhall/autotyed/images/autotyed.png)
