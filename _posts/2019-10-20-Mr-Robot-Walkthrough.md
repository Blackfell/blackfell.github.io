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
title:  "Mr Robot"
date:   2019-10-20 22:00:00 +0000
header:
  overlay_image: /assets/images/posts/mr_robot/rubiks.jpg
  teaser: /assets/images/posts/mr_robot/rubiks.jpg
excerpt: "Capture The Flag Walkthrough"
categories:
  - Technical Guidance
  - Labs & Hacking
tags:
  - Lab
  - Networking
  - Linux
  - Virtualisation
toc: true
toc_sticky: false
toc_label: "What's in this post?"
toc_icon: "arrow-circle-down"

---

# Mr robot Walkthrough

This is a guide to completing a Capture The Flag exercise based on the TV series [Mr Robot](https://en.wikipedia.org/wiki/Mr._Robot); the exercise is delivered as a Virtual Machine (VM) from [Vulnhub](https://www.vulnhub.com/entry/mr-robot-1,151/) and I like to recommend it as an early virtual machine for friends and colleagues to see if they want to get into ethical hacking.

## Using this guide

This guide is written slightly differently from 'standard' walkthroughs, in that the answers to problems aren't as important as how the problems were solved; throughout I try to set out a problem, guide you on ways to solve it, *then* give the answer. This means that if you're working the MR Robot VM, you can work through this guide, choosing to solve problems and avoid spoilers if you wish. This is the best way to learn.

>'Do it!'
>
>  -Arnold Schwarzenegger

# Setup and orientation

If you're on this page, you should already have a hacking lab and preferably have read [my post on the matter](link_lab_post). You should know what a VM is and how to import it, as well as some basics around how the internet works, programming and the other topics covered in the [Now What?(link_lab_post) section of my lab post; if you don't know this, don't start this yet.

## Importing the VM

The VM import for this machine was a simple process for me; the machine seems to have DHCP well configured, to that when you import the appliance and give it a network adapter of your choosing, it picks up an IP address nicely.

## Discovery

I like to discover the machine as I import it for two reasons; one reason is that I'll know if I was successful importing, the other is that the import process can create network noise, which I stand a chance of picking up, even if my import went wrong.

I should note that once imported, you can go to the VM, try and log on, check things from there etc. But since this is a challenge to break into the machine over the network, I'll be leaving that out of the scope of this article.

### What's the problem?

In this case, the problem is using discovery and network sniffing tools to see whether the machine imports and if so, what it's IP address is.

### Hints

Running a packet sniffer on the network you're attaching the VM to is a good idea here. Active discovery tools may be OK here, but can you find a tool (google if you need to), to discover hosts on eh network passively?

## Solution

Before we start, I'm connecting this VM to my host-only virtual network, which has the address range of 192.168.235.0/24. I can check my network adapters with:

```bash
~$ ip a
```

Which gives me:

![Networking Info](/assets/images/posts/mr_robot/network.jpg)

so I'm looking to find this device on my eth0 network adapter.

As far as packet capturing tools go, Wireshark is common, but I like tcpdump for this, so I'll run tcpdump, with a few switches (but keeping it fairly simple for now); I like to turn off name resolution (-nn), specify that I want to discover on my host only network device (-i eth0) and that's it, show me all!

```bash
~$ tcpdump -nn -i eth0
```

A quick google for passively discovering hosts might take you to a [stack exchange post](https://unix.stackexchange.com/questions/415270/how-can-i-detect-devices-on-my-local-network-from-a-linux-computer), which recommends a tools called netdiscover. I like to use netdiscover in passive mode as the VM is imported, so that I can see it associating with my virtual network. I'm thinking of the Address Resolution Protocol](https://en.wikipedia.org/wiki/Address_Resolution_Protocol) (ARP) when I do this, as well as DHCP, which my attacking machine should pick up. I run this tool with the -p switch to get passive mode:

```bash
~$ netdiscover -p -i eth0
```

Now I can go ahead and import the appliance; I make sure it's on the same network and I see my tools light up!

![Importing](/assets/images/posts/mr_robot/importing.jpg)

and we have a machine!

# Recon & First Impressions

Now the machine is running, it's time to talk to it, over the network, and see what kind of things are there for us to exploit!

## What's the Problem?

We need to find out what kind of network services are running on the machine; we need to know what versions they are, what function they fulfil and whether they're vulnerable in any way.

## Hints

We have the machine IP address, so we don't need to find it on the network, but knowledge of what ports are open and what services are running behind them would be helpful. There are tools to do this manually and in an automated way; why not start with a port scan, then try and find out what versions of software might be running behind them. Any information on how these are configured would be a bonus!

## Solution

**The** network mapper and port scanner is Nmap; there are other ways of portscanning hosts, but this is the tool I like to use and one that you'll find in other CTF write-ups.

I like to run nmap as root, which means (amongst other things) it will carry out a [Syn scan](https://networkinferno.net/tcp-syn-scanning) by default; I like to turn off the probe requests and host resolution (-Pn and -n), because I know where my host is, and I like to scan all TCP ports with the -p- option. I usually output to all filetypes (-oA), as well as asking nmap to give us a reason whenever it says a port is open or filtered (--reason); as always, keep that tcpdump sniffer running, so you can see what's going on! The resultant command is:

> ```bash
>~$ nmap -Pn -n -p- -oA tcp-all-ports --reason <VM IP Here>
> <NMAP OUTPUT HERE>
>~$ ls
> <NMAP DIR HERE>
>```


![Nmap tcp scan](/assets/images/posts/mr_robot/nmap.jpg)

So we can see what the machine is running; there's a secure shell service (ssh) and web, but that's about it. At this point, we could further evaluate these services, so bonus points if you did this already! I like to discover the open ports first, then enumerate each open port further, as it can really reduce scan times on larger projects and it will help you further on down the line.

Why do we go further? Well open ports are just mapped to known numbers up to now, so if I run http over port 22, nmap will say we have ssh running, if it was run how I ran it at first. To get more concrete results is probably a little overkill for now, but good practice; taking the host & open ports we know, I like to add version detection (-sV) for services discovered, I like to run the default nmap scripts against them (-sC) and I like to run OS detection too (-O). If you run scripts, note you also need version detection on for best results. The new command then becomes:

> ```bash
>~$ nmap -Pn -n -p 22,80,443 -sV -sC -O -oA tcp-open-ports-fingerprinting --reason <VM IP Here>
> <NMAP OUTPUT HERE>
>~$ ls
> <NMAP DIR HERE>
>```

![Nmap with scripts](/assets/images/posts/mr_robot/nmap_scripts.jpg)

This now tells us a little more, which may come in useful later; for now I'll wrap up this section by visiting this web page and seeing what we're dealing with.

# Recon continued & Vulnerability Analysis

Now that we have a fairly good service to start looking at (web), let's take a look at the page and try and find any vulnerabilities associated with this service.

![web page](/assets/images/posts/mr_robot/home_page.jpg)

This looks great! It's an interesting page and if you're a fan of the show, take a while and enjoy!

## What's the problem?

We need to get more information about this web page. What is on the site? how is the site configured? What powers the site?

## Hints

Websites can be manually and automatically evaluated; why not try a bit of both? At this point, a web scanner may help to find files and directories that aren't explicitly linked from the home page. Google is your friend here, but bear in mind the following questions throughout:

1. What content is on the site, what is there, but hidden?

1. What powers the site?

1. Can the site be configured and administered?

1. Are there any clues about who has set this site up?

## Solution

I like to use nikto for automated web scanning; this can be run simply using:

 ```bash
~$ nikto -h http://<VM IP Here>
 <NIKTO OUTPUT HERE>
```

![nikto](/assets/images/posts/mr_robot/nikto.jpg)

Which returns a load of findings, importantly telling us that the site runs Wordpress and has an admin panel. This is in line with the findings from dirb, another tool I tend to run against sites like this:

![dirb](/assets/images/posts/mr_robot/dirb.jpg)

This also references the [robots.txt file](https://en.wikipedia.org/wiki/Robots_exclusion_standard), as well as some hidden directories, pages and files. robots.txt is intended to manage web crawlers indexing the site, but it can sometimes give us some clues.

![robots.txt](/assets/images/posts/mr_robot/robots.jpg)

Given the filenames, we can even just download them immediately using the tool wget:

![Robots Files](/assets/images/posts/mr_robot/robot_files.jpg)

Great news, We've found flag 1! We also look to have a dictionary file, with some interesting words at the top!Perhaps we can use this information going forward.

# Password Attacks

Now that we have an admin panel, we could continue to analyse the site for vulnerabilities, but password attacks offer us a low-effort means of accessing a site. They also have the added benefit of being run in the background while we do more analysis.

## What's the problem?

We can't crack this login offline, so we need to guess the password by sending a login request over and over again, until we have a successful login.

## Hints

Guessing usernames and passwords from lists can be time consuming, can you find a way to guess one at a time? You have found a dictionary, perhaps this will be useful.

## Solution

When accessing the panel, it can help to manually guess some credentials; I usually do admin:admin, because you never know, you may get lucky! On doing this, we get an error message saying that the username is invalid:

![user invalid figure]()

This may allow us to guess usernames, then passwords. Why does this help? Well if there were 10 possible users and 10 passwords, I could guess every combination, which would take 100 guesses, or I could guess 10 users, then ten passwords, a total of 20 guesses. Geddit?

I want to try and use the dictionary file I found to guess usernames and passwords, but first I'll check if there are any duplicates:

```bash
~$ cat fsocity.dic | wc -l
~$ cat fsocity.dic | sort -u | uniq fsocity_new.dic < &1 | wc -l  (or use tee)
~$ ls
 <files HERE>
```

I like to use Hydra to guess passwords; the syntax for guessing login forms can be a real pain, however. If you know that the text 'Invalid Username' means we failed, and want to use the dictionary to guess logins, we don't need a correct password, since we're just guessing usernames, so we can guess as follows:

```bash
~$ hydra -L ./fsocity_new.dic -p Password <VM IP> http-form-post '/wp-admin.php:&user=^USER^&password=^PASS^:Invalid Username'
 <Output HERE>
```

After a while, I found that the username elliot doesn't return the invalid username code when submitted; this is great, now I can repeat this process for guessing the passwords:

```bash
~$ hydra -l elliot -P ./fsocity_new.dic <VM IP> http-form-post '/wp-admin.php:&user=^USER^&password=^PASS^:Invalid Password'
 <Output HERE>
```

And now we have access to the admin panel.

# Exploitation

Now that we have access to the admin panel, we need to look to carry out further exploitation. Our access doesn't let us see much of the underlying system, so let's change that.

## What's the problem?

We need to expand your access, so that you can get more control over this box and find more flags!

## Hints

WordPress is running on the VM, can you extend its functionality to let you see more about the system? Can you get some access to the machine itself via WordPress?

## Solution

WordPress has lots of functionality, you may have been able to add plugins to browse files (##check##), or explore the machine; I chose to upload a shell payload to WordPress, so that I can have an open interface to do what I want to the machine.

There are various options available to us, but through the admin panel, it seems that we can upload WordPress plugins of our own. These plugins are php based, which the server will execute, so I can put my own php in to a plugin and it will run.

We could write our own php, or use some of the stuff built into Kali, but Pentestmonkey has some great resources online around [getting shells](http://pentestmonkey.net/cheat-sheet/shells/reverse-shell-cheat-sheet). I used their infamous [php reverse shell(http://pentestmonkey.net/tag/php)], customising the IP and port to call back to match my own machine:

![rev_shell_config]()

I then set up a simple listener on my own machine, using netcat. The switches here are listen (l), be verbose (v) and use this port (p), followed by the port number:

```bash
~$ nc -lvp 1234
```

This will listen on that same port I specified in the shell, such that the php will call back to the listener and let me run commands:

![rev shell diag]()

Once I have those configured, I then upload the php shell into an existing plugin, check the plugin is active and run the site:

[uploading php]()

and presto:

[shell]()

We have shell. Now it's time to find more things :)

# Post exploitation

Enumeration, enumeration, enumeration.

## What's the problem.

Now that we have a working shell, we need to utter the correct phrase:

>**'I'm in'**

Now we need to pillage and plunder, find our flags and complete this challenge. We need to see what files we can access, see what our privileges are and whether we can escalate, or even become the root user on the machine.

## Hints

What files can you access? Are any of them helpful? Maybe some might even be flags.

Can you find any interesting software running? Are there any interesting file permissions issues? perhaps you can take control of something legitimate to become root.

Does google have anything that may help you enumerate and escalate on Linux? What about this particular version of Linux?

## Solution

There are lots of resources for Linux enumeration and privilege escalation, but G0tm1lk has some [great guidance](https://blog.g0tmi1k.com/2011/08/basic-linux-privilege-escalation/) on the matter. There is a whole load of information in there, don't be disheartened; there is a tool you can run, but being familiar with the process will help you long-term.

I recommend doing these in another order, especially for easier VMs; creators of these want you to solve, so I like to follow the following stages on these:

1. look for all files in home directorates, followed by any configuration or log directory you can access. Get that information! Maybe there'll be passwords!
1. Sloppy workarounds - Are other user accounts open? Did someone leave a credential somewhere? Maybe someone has their own /bin/sh that runs as root!?
1. Other privilege management issues - is there a binary used to elevate privilege, can we hijack it? Maybe this is sudo, maybe its something custom ( note that this is point 1 again, but also not)
1. Are there any advanced file permissions on binaries? Setuid and setguid bits on binaries allow them to run as root, if you can influence their execution, you can take over.
1. Is there any information in process listing? Sometimes credentials are passed to commands in the clear and these can be seen in process monitoring tools, equally, a tool may run as root, taking input from some file you can write to.
1. Are there any vulnerabilities associated with this version of Linux, could I use a public exploit?

This is just my running order for easier CTF boxes, you can do what you like; if you followed the above before getting here, you'll find that point 1 yields some interesting results, namely that in the home directory, we find flag 2:

[finding flag2]()

Once you completed step 1, you may have found that for privilege escalation 2,3 and 4 are all kind of right. There is a setuid binary that always runs as root, but is an unusual choice - Nmap.

![nmap setuid]()

There may be legitimate reasons for running nmap as root, but it sticks out when running through this enumeration. If you google the version of Nmap, you'll find it had an interactive mode, so simply run Nmap in this mode and execute the following:

``` bash
 !sh
 #whoami
 uid=0 root
```

You're now root! let's look for that flag:

[finding root flag]()

and we have the root flag!

# Fin
