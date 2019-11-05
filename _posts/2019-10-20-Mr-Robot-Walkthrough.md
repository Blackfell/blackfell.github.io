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

This guide is written slightly differently from 'standard' walkthroughs, in that the answers to problems aren't as important as how the problems were solved; throughout I try to set out a problem, guide you on ways to solve it, *then* give the answer. This means that if you're working the MR Robot VM, you can work through this guide, choosing to solve problems and avoid spoilers if you wish. I hope that this is helpful to people finding their way on their first CTF, but it only works if you play fair!

# Setup and orientation

If you're on this page, you should already have a hacking lab and preferably have read [my post on the matter](/technical guidance/labs & hacking/building-a-lab/). You should know what a VM is and how to import it, as well as some basics around how the internet works, programming and the other topics covered in my lab post; if you don't know this, don't start this yet.

# Discovery & Importing

If you're following this guide through and are planning to follow my method, then **don't power on the VM yet**; if you have already, power it down and read on.

I like to discover the machine as I power it on; that way I'll know if I was successful importing the machine and I'll probably learn its IP address whilst I'm at it.

## What's the challenge?

In this case, the problem is using discovery and network sniffing tools to see whether the machine imports and if so, what it's IP address is.

## Hints

Importing the VM should work as normal in your hypervisor of choice and the Mr Robot VM seems well configured such that DHCP just... works.

Running a packet sniffer on the network you're attaching the VM to is a good idea here. Active discovery tools may work well, but can you find a tool (google if you need to), to discover hosts on the network passively?

## Solution

Before we start, I import the Mr Robot VM in my virtualisation software and before I ever power it on, I give it a host-only virtual network adapter; once that's done, I make sure my attacker is configured and prepare to turn our victim on.

My Host only network has the address range of 172.16.187.0/24. I can check my attacker network adapters and IP addresses with the ip utility.

{%
  include figure
  image_path="/assets/images/posts/mr_robot/network.jpg"
  alt="Networking info"
  caption="Running the ip utility, I can see that my attacker machine has an IP of **172.16.187.144**, I'll need that later!"
%}

I see from my network settings that *eth0* is my only adapter and has an address in my host only range, so I'll point my tools to that.

I like to capture traffic during machine import; I'm thinking of the [Address Resolution Protocol](https://en.wikipedia.org/wiki/Address_Resolution_Protocol) (ARP) when I do this, as well as DHCP, which my attacking machine may also pick up. As far as packet capturing tools go, Wireshark is popular, but I like tcpdump for this, so I'll run tcpdump, with a few switches (but keeping it fairly simple for now); I like to turn off name resolution (-nn), specify that I want to discover on my host only network device (-i eth0) and that's it, show me all!

```bash
~$ tcpdump -nn -i eth0
```

A quick google for passively discovering hosts might also take you to a [stack exchange post](https://unix.stackexchange.com/questions/415270/how-can-i-detect-devices-on-my-local-network-from-a-linux-computer), which recommends a tool called netdiscover. In addition to tcpdump, I like to use netdiscover in passive mode as the VM is imported, so that I can see it associating with my virtual network.  I run this tool with the -p switch to get passive mode:

```bash
~$ netdiscover -p -i eth0
```

Now I can go ahead and power up the Mr Robot VM; I make sure it's on the same network, hit go, and I see my tools light up!

{%
  include figure
  image_path="/assets/images/posts/mr_robot/importing.jpg"
  alt="Importing the appliance"
  caption="Importing the machine, we can see traffic in tcpdump, indicating that ARP requests are flying back and forth to a new IP of **172.16.187.145**; netdiscover picks this up too, so that looks like our target."
%}

Good news, we have a machine! It's at *172.16.187.145*.

# Recon & First Impressions

Now the machine is running, it's time to talk to it, over the network, and see what kind of things are there for us to exploit!

## What's the challenge?

We need to find out what kind of network services are running on the machine; we need to know what versions they are, what function they fulfil and whether they're vulnerable in any way.

## Hints

We have the machine IP address, so we don't need to find it on the network, but knowledge of what ports are open and what services are running behind them would be helpful. There are tools to do this manually and in an automated way; why not start with a port scan, then try and find out what versions of software might be running behind them. Any information on how these are configured would be a bonus!

## Solution

**The** network mapper and port scanner is Nmap; there are other ways of portscanning hosts, but this is the tool I like to use and one that you'll find in other CTF write-ups.

I like to run nmap as root, which means (amongst other things) it will carry out a [Syn scan](https://networkinferno.net/tcp-syn-scanning) by default; I like to turn off the probe requests and host resolution (-Pn and -n), because I know where my host is, and I like to scan all TCP ports with the -p- option. I usually output to all filetypes (-oA), as well as asking nmap to give us a reason whenever it says a port is open or filtered (--reason); as always, keep that tcpdump sniffer running, so you can see what's going on!

{%
  include figure
  image_path="/assets/images/posts/mr_robot/nmap.jpg"
  alt="Nmap TCP scan Output"
  caption="A simple nmap scan of all TCP ports "
%}

So we can see what the machine is running; there's a secure shell service (ssh) and web, but that's about it. At this point, we could further evaluate these services, so bonus points if you did this already! I like to discover the open ports first, then enumerate each open port further, as it can really reduce scan times on larger projects and it will help you further on down the line.

Why do we go further? Well open ports are just mapped to known numbers up to now, so if I run http over port 22, nmap will say we have ssh running, if it was run how I ran it at first. To get more concrete results is probably a little overkill for now, but good practice; taking the host & open ports we know, I like to add version detection (-sV) for services discovered, I like to run the default nmap scripts against them (-sC) and I like to run OS detection too (-O). If you run scripts, note you also need version detection on for best results.

{%
  include figure
  image_path="/assets/images/posts/mr_robot/nmap_scripts.jpg"
  alt="Nmap Output with scripts"
  caption=""
%}

This now tells us a little more, which may come in useful later; for now I'll wrap up this section by visiting this web page and seeing what we're dealing with.

# Finding Vulnerabilities

Now that we have a fairly good service to start looking at (web), let's take a look at the page and try and find any vulnerabilities associated with this service.

{%
  include figure
  image_path="/assets/images/posts/mr_robot/home_page.jpg"
  alt="Web Page"
  caption="Browsing to the VMs IP address will show you the web page being hosted; clearly someone's put time into putting this together."
%}

This looks great! It's an interesting page and if you're a fan of the show, take a while and enjoy!

## What's the challenge?

We need to get more information about this web page. What is on the site? how is the site configured? What powers the site?

## Hints

Websites can be manually and automatically evaluated; why not try a bit of both? At this point, a web scanner may help to find files and directories that aren't explicitly linked from the home page. Google is your friend here, but bear in mind the following questions throughout:

1. What content is on the site, what is there, but hidden?

1. What powers the site?

1. Can the site be configured and administered?

1. Are there any clues about who has set this site up?

## Solution

I like to use nikto for automated web scanning; this can be run without any fancy options for our purposes:

{%
  include figure
  image_path="/assets/images/posts/mr_robot/nikto.jpg"
  alt="Nikto Output"
  caption="Nikto run against the VM, with minimal command line options set. Highlighted are key parts of ht output identifying the WordPress engine, as well as Admin and Readme pages."
%}

Nikto returns a load of findings, importantly telling us that the site runs WordPress and has an admin panel. This is in line with the findings from dirb, another tool I tend to run against sites like this:

{%
  include figure
  image_path="/assets/images/posts/mr_robot/dirb.jpg"
  alt="Dirb Output"
  caption="Dirb, run with default options against the site hosted on the VM. Highlighted in red are key findings, including a robots.txt entry not shown by Nikto."
%}

This also references the [robots.txt file](https://en.wikipedia.org/wiki/Robots_exclusion_standard), as well as some hidden directories, pages and files. It is useful to run more than one tool against a machine if you have time, as the outputs can often be complementary.

robots.txt is intended to manage web crawlers indexing the site, but it can sometimes give us some clues.

{%
  include figure
  image_path="/assets/images/posts/mr_robot/robots.jpg"
  alt="robots.txt"
  caption="Browsing to the robots.txt file shows some interesting entries."
%}

The robots.txt file for this site contains two glaring clues, one reference to a key and one to something that looks like it might be a dictionary file; both entries are files, which are probably hosted on the server. Given the filenames, we can even simply download them using wget:

{%
  include figure
  image_path="/assets/images/posts/mr_robot/robot_files.jpg"
  alt="robots.txt files"
  caption="Pointing wget at the file paths to get copies downloaded to our working directory; the key-file and dictionary file are both interrogated using cat and head respectively."
%}

Great news, We've found flag 1! It looks like we were right about the dictionary file too; since I knew this might be a dictionary with lots of words in it, I just ran the head command to see the top few, there look to be some interesting words at the top! Perhaps we can use this file going forward.

You may choose to look further into some other findings and gather more information (there are a few other Easter eggs and ways in to be found!), but I'm ready to move on to hunting that next flag.

# Password Attacks

Now that we have done some initial vulnerability hunting and even found our first flag, it's time to move on to finding a way in. We have a strong finding in the dictionary file and admin panel; we could continue to analyse the site for vulnerabilities, but password attacks offer us a low-effort means of accessing the site, which looks promising.

## What's the challenge?

We need to guess the password by sending a login request over and over again, until we have a successful login. Try and automate this in such a way that we find the legitimate login details.

## Hints

Guessing usernames and passwords from lists can be time consuming, can you find a way to guess one at a time? You have found a dictionary, perhaps this will be useful. What tools can you find that will let you guess usernames and passwords for web logins, or WordPress installations?

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

{%
  include figure
  image_path="/assets/images/posts/mr_robot/password_info_2.jpg"
  alt="Login form picture with correct username"
  caption="Trying some obviously wrong password with a valid username shows us that similar text is shown for invalid passwords."
%}

Now we can repeat this process again, but setting the user to elliot and guessing the passwords with our dictionary again; we also have to change the invalid text to that shown below:

{%
  include figure
  image_path="/assets/images/posts/mr_robot/password_guessing.jpg"
  alt="Guessing passwords with hydra"
  caption="Guessing of passwords with Hydra using a valid logon of *elliot* logins where the invalid login text isn't seen are shown in green in the output."
%}

If we take those credentials and try them on the webpage in our browser.

{%
  include figure
  image_path="/assets/images/posts/mr_robot/admin_panel.jpg"
  alt="Logged into the admin panel"
  caption="Logging into the admin panel with our credentials."
%}

We have access to the admin panel.

# Further Exploitation

Now that we have access to the admin panel, we need to look to carry out further exploitation. Our access doesn't let us see much of the underlying system, so let's change that.

## What's the challenge?

We need to expand your access, so that you can get more control over this box and find more flags!

## Hints

WordPress is running on the VM, can you extend its functionality to let you see more about the system? Can you get some access to the machine itself via WordPress?

## Solution

There are various options available to us, but through the admin panel, one thing that jumps out to me is the plugins option.

{%
  include figure
  image_path="/assets/images/posts/mr_robot/wp_plugins.jpg"
  alt="WordPress Plugins Tab"
  caption="Opening up the WordPress plugins tab shows us all the extra functionality that's already been installed on this WP instance."
%}

These plugins are php based and when enabled the server executes this php to achieve whatever functionality is intended.WordPress has lots of available plugin functionality and you may have been able to add [plugins to browse files](https://wordpress.org/plugins/wp-file-manager/) and explore the machine, or some other valid solution; I took the easy answer and chose to upload a php shell payload to WordPress, so that I can have a more open interface to do what I want to the machine. Plugins can be edited and our PHP dropped in to execute as a part of a legitimate plugin.

{%
  include figure
  image_path="/assets/images/posts/mr_robot/wp_plugin_edit.jpg"
  alt="Configuring WP Plugins"
  caption="WordPress plugins can be edited; adding our PHP in here will get it executed by WordPress, giving us a shell. Simple!."
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
  caption="Editing the contact form plugin allows us to append our PHP code; note that our shell starts at the highlighted comment; be careful about opening and closing php tag duplication. Once you hit the 'update' button (highlighted red), you'll see a banner appear at the top (also highlighted) to let you know you've been successful."
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
  caption="Even though the plugin suffered a fatal error, it seems that the shell was able to run before this happened. A directory listing and whoami command tell us we're in the root directory as the user *'daemon'*"
%}

We have shell, but why? I think this is probably because the shell tries to daemonise itself and if successful, the daemon would have continued to run once the parent plugin crashed.


# Post exploitation

Now it's time to expand our access, it's all about enumeration, enumeration, enumeration.

## What's the challenge?

We'll we have a working shell, yay!

{%
  include figure
  image_path="/assets/images/posts/mr_robot/sim_in.jpg"
  alt="Use hacker voice to say I'm in."
  caption=""
%}

Now we need to pillage and plunder, find our flags and complete this challenge. We need to see what files we can access, see what our privileges are and whether we can escalate, or even become the root user on the machine.

## Hints

What files can you access? Are any of them helpful? Maybe some might even be flags.

Can you find any interesting software running? Are there any interesting file permissions issues? perhaps you can take control of something legitimate to become root.

Does google have anything that may help you enumerate and escalate on Linux? What about this particular version of Linux?

## Solution

There are lots of resources for Linux enumeration and privilege escalation, but G0tm1lk has some [great guidance](https://blog.g0tmi1k.com/2011/08/basic-linux-privilege-escalation/) on the matter. There is a whole load of information in there, as well as a tool you can run to automate the process (though being familiar with the manual way is best).

I recommend doing these enumeration steps in a slightly different order for CTFs, especially for easier VMs; creators of these want you to solve, so I find it helps to follow the following workflow on these:

1. look for all files in home directorates, followed by any configuration or log directory you can access. Get that information! Maybe there'll be passwords...
1. Sloppy workarounds - Are other user accounts open? Did someone leave a credential somewhere? Maybe someone has their own /bin/sh that runs as root!?
1. Other privilege management issues - is there a binary used to elevate privilege, can we hijack it? Maybe this is sudo, maybe its something custom.
1. Are there any advanced file permissions on binaries? Setuid and setguid bits on binaries allow them to run as root, if you can influence their execution, you can take over.
1. Is there any information in process listing? Sometimes credentials are passed to commands in the clear and these can be seen in process monitoring tools, equally, a tool may run as root, taking input from some file you can write to.
1. Are there any vulnerabilities associated with this version of Linux, could I use a public exploit?

This is just my running order for easier CTF boxes, you can do what you like; if I quickly exhaust this list, I usually go back to G0tM1lk's list process.

If you followed the above before getting here, you'll find that point 1 yields some interesting results, namely that in the home directory, we find flag 2 and an interesting file:

{%
  include figure
  image_path="/assets/images/posts/mr_robot/robots_home.jpg"
  alt="Browsing to robot home directory"
  caption="Browsing to the **/home/** folder shows us one user, with some interesting files in their home directory; using ls with the *-lah* flags shows us that there are, however, file permissions associated with the key file, so we can't read it. The password file is readable to us and we can cat its contents."
%}

We can access the password file, but not the key, only the user robot can do that; luckily for us, it seems that the password file is actually a password hash. This password hash can be cracked, but I need the string on my own machine to do this; I like to use NetCat to move things over network on these CTFs, so let's do that.

{%
  include figure
  image_path="/assets/images/posts/mr_robot/get_hash.jpg"
  alt="Bringing the hash file to our local machine"
  caption="Netcat is installed on the machine, so we cat cat the file, pipe the output into netcat, which will fire it over to our attacker machine, where a listener can pick it up and pipe it back into a file. Highlighted are the commands to send and receive the file above and below respectively."
%}

Now that we've brought the hash back over to our attacker machine, we can crack it; the file extension tells us that the hash is probably Raw-MD5 format, so I'll run it through John the Ripper in Kali. I'll try our fsocity.dic, then if that doesn't work, some other lists from Kali.

{%
  include figure
  image_path="/assets/images/posts/mr_robot/john.jpg"
  alt="Cracking the hash with John"
  caption="Cracking the password with John; I specify the format in each command and vary the wordlist used at each stage, progressing to larger, more complete lists. Our wordlist didn't contain a valid credential, neither did the fasttrack dictionary on Kali, but the RockYou dictionary gives us a match."
%}

Now that we have a valid password for the robot user, we can try it; the command *su* lets us become another user.

{%
  include figure
  image_path="/assets/images/posts/mr_robot/key_2.jpg"
  alt="Getting Key 2"
  caption="Using **su** to become the robot user, initially, you may get an error saying that, since you don't have a terminal session, you can't use *su*. This can be worked around using a few methods, but since Python is installed, I like to use that one; running a quick *pty.spawn()* command gets us a terminal session and we can *su* as *robot*; it's now possible to read key 2. I again use NetCat to send the key over the network to my attacker machine."
%}

OK, great, Key 2 out of the way; now we need to keep going!

{%
  include figure
  image_path="/assets/images/posts/mr_robot/rob_s.gif"
  alt="You can do it!"
  caption=""
%}

Let's continue our post-exploitation to get root on the machine. After following on the post-exploitation steps above, you may have found that for privilege escalation , step 4 yields something interesting.

{%
  include figure
  image_path="/assets/images/posts/mr_robot/nmap_suid.jpg"
  alt="Getting Key 2"
  caption="Using a find command listed in the [G0tM1lk privesc guidance](https://blog.g0tmi1k.com/2011/08/basic-linux-privilege-escalation/), to fin setuid binaries shows us that Nmap is configured in this way. A quick ls is then used to find that the file is owned (and will therefore run as) root."
%}

There is a setuid binary, meaning that it always runs as a certain user, but is an unusual choice - Nmap. Since it's configured to run as root, this offers us a promising way in.

There may be legitimate reasons for running nmap as root (there are many, including the way it can probe, scan and generally craft packets), but having it configured as setuid sticks out when running through this enumeration.

Spending a little time googling the version of Nmap (which can be found by running nmap -V), you'll find it had an interactive mode; additionally the interactive mode allows for running of shell commands! To test this out, we can simply run Nmap in this mode and execute some basic shell commands.

{%
  include figure
  image_path="/assets/images/posts/mr_robot/get_root.jpg"
  alt="Getting Key 2"
  caption="Using Nmap interactive mode to execute basic commands as root."
%}

Wow, we have You're now root! let's look for that third flag:

{%
  include figure
  image_path="/assets/images/posts/mr_robot/final_pwn.jpg"
  alt="Getting Key 3"
  caption="Sure enough, looking in the root home directory gets us the flag. Using the old netcat transfer technique, the flag is transferred to the attacker machine."
%}

And we have the root flag! Game over!

# Fin

It's over, well done! If this was your first CTF, I hope you enjoyed it as much as I did; keep on going and hack some moar!
