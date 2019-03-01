# Autotyed

This repo is a collection of configurations, html snippets and code that provide
a way to present many different applications in a single interface.

## Now

Currently the web code isn't in a state that I can upload, but I'll get it there soon.

What is currently provided is an nginx config showing how to route traffic to each application.
Eventually I'll provide directions on how to replicate my configuration.
I once ran all these apps on a single server, but recently split the security and
automation roles from the media download and display roles; it's now on two computers
and that's why you'll see two different backend IPs in the configuration. Both computers
are macOS 10.13, but many of these apps work on Linux, or Linux has similar variants.

## Bits and Pieces

I have a handful of custom startup scripts and doohickies for Radarr, Jackett, Sonarr, etc.
I also run a few pieces of custom software (found elsewhere on my github) to move data among these apps.

Documenting how all these pieces of software can be tied together is the goal of this repo.

![Screen Shot of Custom Interface](images/autotyed.png)
