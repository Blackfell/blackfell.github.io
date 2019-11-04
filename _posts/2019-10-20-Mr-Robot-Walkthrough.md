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

Before we start, I'm connecting this VM to my host-only virtual network, which has the address range of 192.168.235.0/24. I can check my network adapters with the ip utility.

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

I like to run nmap as root, which means (amongst other things) it will carry out a [Syn scan](https://networkinferno.net/tcp-syn-scanning) by default; I like to turn off the probe requests and host resolution (-Pn and -n), because I know where my host is, and I like to scan all TCP ports with the -p- option. I usually output to all filetypes (-oA), as well as asking nmap to give us a reason whenever it says a port is open or filtered (--reason); as always, keep that tcpdump sniffer running, so you can see what's going on!

![Nmap tcp scan](/assets/images/posts/mr_robot/nmap.jpg)

So we can see what the machine is running; there's a secure shell service (ssh) and web, but that's about it. At this point, we could further evaluate these services, so bonus points if you did this already! I like to discover the open ports first, then enumerate each open port further, as it can really reduce scan times on larger projects and it will help you further on down the line.

Why do we go further? Well open ports are just mapped to known numbers up to now, so if I run http over port 22, nmap will say we have ssh running, if it was run how I ran it at first. To get more concrete results is probably a little overkill for now, but good practice; taking the host & open ports we know, I like to add version detection (-sV) for services discovered, I like to run the default nmap scripts against them (-sC) and I like to run OS detection too (-O). If you run scripts, note you also need version detection on for best results.

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

I like to use nikto for automated web scanning; this can be run simply for our purposes:

![nikto](/assets/images/posts/mr_robot/nikto.jpg)

Which returns a load of findings, importantly telling us that the site runs Wordpress and has an admin panel. This is in line with the findings from dirb, another tool I tend to run against sites like this:

![dirb](/assets/images/posts/mr_robot/dirb.jpg)

This also references the [robots.txt file](https://en.wikipedia.org/wiki/Robots_exclusion_standard), as well as some hidden directories, pages and files. robots.txt is intended to manage web crawlers indexing the site, but it can sometimes give us some clues.

![robots.txt](/assets/images/posts/mr_robot/robots.jpg)

Given the filenames, we can even just download them immediately using the tool wget:

![Robots Files](/assets/images/posts/mr_robot/robot_files.jpg)

Great news, We've found flag 1! We also look to have a dictionary file, since I knew this might be a dictionary with lots of words in it, I just ran the head commadn to see the top few, there look to be some interesting words at the top! Perhaps we can use this file going forward.

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
858160
~$ cat fsocity.dic | sort -u | uniq | tee fsocity_new.dic| wc -l
11451
~$ ls
fsocity.dic   fsocity_new.dic
```

I like to use Hydra to guess passwords; the syntax for guessing login forms can be a real pain, we need to make sure we fully understand how the login form works, so that we don't get confused.

{% include figure image_path="/assets/images/posts/mr_robot/password_info.jpg" alt="Login form picture" caption="Trying some obviously wrong information shows login form behaviour on unsuccessful logon; right-clicking the form fields and using 'Inspect Element' lets us see the form source, where the login variables **log** and **pwd** can be seen." %}

From looking at an incorrect login attempt, we learn the names of the login variables *log* and *pwd*, as well as the fact that that the text 'Invalid Username' appears if the username is invalid. This is interesting as it allows us to guess usernames and passwords separately; we can guess the username only by running the following command:

```bash
~$ hydra -L ./fsocity_new.dic -p testpassword <VM IP> http-form-post '/wp-admin.php:&log=^USER^&pwd=^PASS^:Invalid username'
```

This command tells hydra to use our (new shortened) dictionary file (-L ./fsocity_new.dic), along with a (probably wrong) password of *'testpassword'* (-P Password), to try and login to the site. Note that after we tell hydra that it's a *http-form-post* attack, we specify the login path *(/wp-admin.php)*, the login variables *(&log=^USER^&pwd=^PASS^)* and the text returned on a failed login *(Invalid username)*, all separated by colons.

This wont' guess everything we need to login, it will just find any valid usernames that are in our dictionary file; it can be run as follows:

{% include figure image_path="/assets/images/posts/mr_robot/user_guessing.jpg" alt="Guessing usernames with hydra" caption="Guessing of usernames with Hydra, logins where the invalid login text isn't seen are shown in green in the output." %}


So, we've found that the username elliot doesn't return the invalid username code when submitted; this is great, elliot is our user.

{% include figure image_path="/assets/images/posts/mr_robot/password_info_2.jpg" alt="Login form picture with correct usernsme" caption="Trying some obviously wrong password with a valid username shows us that similar text is shown for invalid passwords." %}

Now we can repeat this process again, but setting the user to elliot and guessing the passwords with our dictionary again; we also have to change the invalid text to that shown below:

{% include figure image_path="/assets/images/posts/mr_robot/password_guessing.jpg" alt="Guessing passwords with hydra" caption="Guessing of passwords with Hydra using a valid logon of *elliot* logins where the invalid login text isn't seen are shown in green in the output." %}

If we take those credentials and try them on the webpage in our browser.

{% include figure image_path="/assets/images/posts/mr_robot/admin_panel.jpg" alt="Logged into the admin panel" caption="Logging into the admin panel with our credentials." %}

We have access to the admin panel.

# Exploitation

Now that we have access to the admin panel, we need to look to carry out further exploitation. Our access doesn't let us see much of the underlying system, so let's change that.

## What's the problem?

We need to expand your access, so that you can get more control over this box and find more flags!

## Hints

WordPress is running on the VM, can you extend its functionality to let you see more about the system? Can you get some access to the machine itself via WordPress?

## Solution

There are various options available to us, but through the admin panel, one thing that jumps out to me is the plugins option.

{%
  include figure
  image_path="/assets/images/posts/mr_robot/wp_plugins.jpg"
  alt="Wordpress Plugins Tab"
  caption="Opening up the WrodPRess plugins tab shos us all teh extra funtionality that's already been installed on thiw WP instance."
%}

These plugins are php based and when enabled the server executes this php to achieve whatever functionality is intended.WordPress has lots of available plugin funtionality and you may have been able to add [plugins to browse files](https://wordpress.org/plugins/wp-file-manager/) and explore the machine, or some other valid solution; I took the easy answer and chose to upload a php shell payload to WordPress, so that I can have a more open interface to do what I want to the machine. Plugins can be edited and our PHP dropped in to execute as a part of a legitimate plugin.

{%
  include figure
  image_path="/assets/images/posts/mr_robot/wp_plugin_edit.jpg"
  alt="Configuring WP Plugins"
  caption="WordPRess plugins can be edited; adding our PHP in here will get it exetued by WordPress, giving us a shell. Simple!."
%}

We could write our own php, but other people have beaten us to it and their work is great. Pentestmonkey has some great resources online around [getting shells](http://pentestmonkey.net/cheat-sheet/shells/reverse-shell-cheat-sheet) and I used their infamous [php reverse shell](http://pentestmonkey.net/tag/php), which is in Kali 2019 under **/usr/share/webshells/php/php-reverse-shell.php**. I copied this file to my local directory and opened if up in a text editor to configure the reverse shell networking settings.

{%
  include figure
  image_path="/assets/images/posts/mr_robot/rev_shell_config.jpg"
  alt="configuring reverse shell"
  caption="Opening up the reverse shell in a text editor, you can alter the IP address, port and other settings to make sure the shell works in your environment."
%}

I then set up a simple listener on my own machine, using netcat. The switches here are listen (l), be verbose (v) and use this port (p), followed by the port number:

```bash
~$ nc -lvp 1234
```

This will listen on that same port I specified in the shell, such that the php will call back to the listener and let me run commands. With everything configured, I then upload the php shell into an existing plugin, check the plugin is active and run the site:

{%
  include figure
  image_path="/assets/images/posts/mr_robot/rev_shell_upload.jpg"
  alt="Uploading reverse shell"
  caption="Editing the contact form plugin allows us to append our PHP code; note that our shell starts at the highlighted comment; be careful about opening and closing php tag duplicaiton. Once you hit the 'update' button (highlighted red), you'll see a banner appear at the top (also highlighted) to let you know you've been successful."
%}

When I activate the plugin , I get an interesting plugin error:

{%
  include figure
  image_path="/assets/images/posts/mr_robot/plugin_error.jpg"
  alt="Uploading reverse shell - plugin error"
  caption="Activating this plugin has triggered an error; the text says the plugin triggered a fatal error."
%}

Now I could go through and troubleshoot the plugin and PHP shell, trying to get them to play nice, but first I checked my netcat listener.

{%
  include figure
  image_path="/assets/images/posts/mr_robot/shell_caught.jpg"
  alt="Reverse shell caught"
  caption="Even though the plugin suffered a fatal error, it seems that the shell was able to run before this happened. A directory listing and whoami command tell us we're in teh root diretory as the user *'daemon'*"
%}

We have shell, but why? I think this is probably because the shell tries to daemonise itself and if successful, the daemon would have continued to run once the parent plugin crashed.


# Post exploitation

Now it's time to expand our acess, it's all about enumeration, enumeration, enumeration.

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
