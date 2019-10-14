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
title:  "School's Out"
date:   2019-07-15 23:00:00 +0000
header:
  overlay_image: /assets/images/posts/start_hacking/empty_corridoor.jpg
  teaser: /assets/images/posts/start_hacking/empty_corridoor.jpg
excerpt: "Finding your path to enlightenment."
categories:
  - Technical Guidance
  - Labs & Hacking
tags:
  - Lab
  - Virtual Machines
  - Windows
  - Linux
  - Hacking
toc: true
toc_sticky: true
toc_label: "What's in this post?"
toc_icon: "arrow-circle-down"
feature_row1:
  - image_path: /assets/images/posts/start_hacking/darknet_diaries.jpg
    alt: "Darknet Diaries"
    title: "Darknet Diaries"
    excerpt: "(the one for your nan) - Narrative of famous incidents, told dramatically, even your least technical family members will keep up with [Jack Rhysider's]() great presenting style."
    url: https://darknetdiaries.com
    btn_label: "Read More"
    btn_class: "btn--inverse"
feature_row2:
  - image_path: /assets/images/posts/start_hacking/malicious_life.png
    alt: "Malicious Life"
    title: "Malicious Life"
    excerpt: "(the one for your cousin) - Narritive of famous incidents, malware and groups; a little more technical in places, but all the better for it if you can handle it."
    url: https://malicious.life/
    btn_label: "Read More"
    btn_class: "btn--inverse"
feature_row3:
  - image_path: /assets/images/posts/start_hacking/sans_isc.jpg
    alt: "SANS ISC Stormcast"
    title: "SANS ISC Stormcast"
    excerpt: "(the one to keep up in a rush) - News podcast from SANS, the host [Johannes]() is highly knowledgable and technical. This podcast doesn't fear getting technical, but it's a pocket news cast I can't do without."
    url: https://isc.sans.edu/podcast.html
    btn_label: "Read More"
    btn_class: "btn--inverse"
feature_row4:
  - image_path: /assets/images/posts/start_hacking/cyberwire.jpg
    alt: "The Cyberwire"
    title: "The Cyberwire"
    excerpt: "(the one for your boss) - Accessible cyber news, in plain English; there are jokes, accents and good ol' american cheese, but it's a great place to start to understand how businesses treat security."
    url: https://www.thecyberwire.com/podcasts/daily-podcast.html
    btn_label: "Read More"
    btn_class: "btn--inverse"

---

# So you want to learn about security?

If you're here, that means you're interested in learning about Information Security, but perhaps you haven't decided where to begin, there's a lot out there; let's cut through the noise and get you some solid, if opinionated, recomendations that I give to friends and colleagues.

## What will I tell you?

This is a guide of two parts. First up is Immersion101, my compressed brief I give friends an colleagues getting into InfoSec; the second section focus on some technical, hands on learning strategies; *this is where the fun begins*.

# Immersion 101

This section is the broad view of learning about InfoSec;  this should help you get a general, risk oriented and well informed view of the security world.

If you're new to a job, starting a course, of just plain interested, the best way is to immerse yourself; listening trecommendo podcsasts is great, following community members on social media (esp. Twitter) is great; read articles, watch videos online.

There is a golden rule - **Do projects you find interesting**; I was advised this way when I got into security and it made all the difference. Just trust me!

## Get into the community

This section is all about getting information; you'll hang out on social media, listen to news, read articles and before you know it, some of it will have sunk in.

### Catching Podcats & Pugcasts 

A great place to start is with some podcasts; these are free, don't require an account and have lots to give. Here are a few suggestions, pick those that sound most helpful to you; if you find more, send them my way!

# 1. Darknet Diaries (the one for your nan) - Narrative of famous incidents, told dramatically, even your least technical family members will keep up with [Jack Rhysider's]() great presenting style.
# 1. Malicious Life (the one for your cousin) - Narritive of famous incidents, malware and groups; a little more technical in places, but all the better for it if you can handle it.
# 1. ISC Stormcast (the one to keep up in a rush) - News podcast from SANS, the host [Johannes]() is highly knowledgable and technical. This podcast doesn't fear getting technical, but it's a pocket news cast I can't do without.
# 1. The Cyberwire (the one for your boss) - Accessible cyber news, in plain English; there are jokes, accents and good ol' american cheese, but it's a great place to start to understand how businesses treat security.

{% include feature_row id="feature_row1" type="left" %}
{% include feature_row id="feature_row2" type="right" %}
{% include feature_row id="feature_row3" type="left" %}
{% include feature_row id="feature_row4" type="right" %}


### Social lurking

Social media is fairly limited in Information Security and though it pains me to say it, InfoSec Twitter is an active and interesting place to pick up news, opinions, reports and blog posts. Why does it pain me? InfoSec Twitter can also be a less-than-friendly environment; it's worth the risk for newbies though and remember, when the fun stops, stop.

### Online training

If you're totally new to the security game, I recommend you focus of your reading and training on security basics; learn about security risk and why businesses use risk, learn about systems administration, networking and programming.

I like the following online training providers:

1. SANS [Cyber Aces](https://www.cyberaces.org/) - A Free offering from a leading training provider to introduce you to InfoSec.
1. [Cybrary](https://www.cybrary.it/) - Online free training provider populat in IT and InfoSec.
1. [Hacker101](https://www.hacker101.com/) - A Free training course associated with the Hacker1 [bug bounty](https://en.wikipedia.org/wiki/Bug_bounty_program) program.
1. [Codeacademy](https://www.codecademy.com/learn/learn-python) - free programming courses from web application programming to full on development practicies.

If nothing grabs your eye, I recommend CompTIA training courses in Security+ Network+ and A+ to total beginners as a starting place; these can be supplemented with Microsoft, Linux and Cisco sysadmin courses; all of which can be founhd for free via Cybrary (number 2.).

Whilst these are good, remember **don't get bogged down in them yet**, read on, build some things and use the training to support where you'd like to find out more on specifics.

### Reading material

Whilst you may get lots of reading material from Twitter and training courses, there are a few places that might be worth a regular look for interesting tech reading. I like to keep an eye on:

1. [Krebs on Security](https://krebsonsecurity.com) -
1. [Hacker News](https://thehackernews.com)
1. [Security Weekly](https://securityweekly.com)
1. [NewsNow](https://www.newsnow.co.uk/h/Technology/Security)

# The good bit - Hands on Learning

Ok now you have your grounding, lets get into my favourite learning strategy - hands on, project based learning. This is where I encourage people to channel as much of their learning energy as posssible; it has the added benefit of being *far* more engaging than reading books.

![We got 'em R2](/assets/images/posts/start_hacking/where_the_fun_begins.gif)

## Why lab is fab

To get started on this part of your journey, we'll build a lab; a lab gives you a playground, where you can release all your hacking tools and malware friends, and have fun without worrying (too much) about them jumping the fence and following you home. You'll be able to use your lab to attack deliberately vulnerable machines in a safe, controlled environment, so you can learn & have fun.

![sandbox meme here](/assets/images/posts/start_hacking/sandbox.jpg)

Remember, if you practice on a system without authorisation, even if without malicious intent, you are probably breaking the law (depending where you are). Be careful. Check your local laws.

## Do I really need one?

You can in principle start your learning journey with simple browser, or just a Secure Shell client, by working on online learning programs only; this option is best if you have really limited resources, or some existing IT that won't perform. I try and encourage people to build a lab, even if this is their learning plan, because I think it gives valuable experience that will support 99% of learning goals.

Aim for separation, testing tools come from all over and they may be compromised. You may decide to do other tasks in future  Separation makes it easeir to move, alter & reset your environments independent of each other. Certain technologies, like virtualisation have major useability advantages - snapshotting, coping and movement.

If you have good reasons to not use a lab, then read on the how to use it section below and take out those recommendations for online challenges only.

## What should I do with it?

You can learn in different ways, it all depends what you want to do and I **always** suggest that you follow your interests. I can't emphasise that enough, passion and interest will trump the best weighed decisions most of the time.

I recommend starting by learning tech basics, install and configure computers, learn to use them with graphical and text interfaces; after you have a basic working knowledge, you may want to try out hacking tools on various victim systems, though you might, by then, have decided to follow another passion (and fair enough to you).

You'll probably want a machine to play aroudn with; you may progress to launch attacks from an attack machine and you'll need to pick some targets to work on; both the attacker machine and the targets could be online, local to your lab, or both.

To help you understand this, let's talk about three main learning types.

### Online learning

Online learning may counjour up images of online courses & videos, but that's Immersion101, this is part deux!

![part Deux](/assets/images/posts/start_hacking/part_deux.jpg)

For this section I recommend more interactive learning environments which offer you online lab access.

Interactive Online training providers host challenges for you to work on and develop your skills; some require you to use your own attacking machine, but some may even host a whole load of your attacker functionality on them too, so you only need a browser.

The good news with online interactive learning is that you need far fewer resources; you may even get away without building a 'proper lab', though I usually discourage this (unless you really can't afford to build a lab), fo rthe reasons stated above. On the down side, you will have to be careful that you're working against the right target and that everything happens in a secure way.

Some good examples of online challenges are:

1. Over the wire's [Bandit](https://overthewire.org/wargames/bandit/) machine - A Linux command line challenge, which will test & develop your abilities to gather information from Linux machines adn work in a Linux command line environment.
1. The SANS [Holiday Hack](https://holidayhackchallenge.com/) challenges - Humourous online hack-a-thons, whose previous years are still hosted; you may need your own machine for some of the harder stuff, but you can get a long way in a browser.
1. [Hack the box](https://www.hackthebox.eu) - A online lab you remote into; bring your own attacking machines and let rip at the hosted victims.
1. [hackthissite](https://www.hackthissite.org) - A website with challenges that allow you to discover and exploit web application vulnearbilities.

All of the above are interesting places to get started; I generally recommend them in order of appearance, as depite hackthisstie being aimed at beginners, I prefer other options unless you're resource constrained.

### Local learning

Offline tlearning gives you separation from the internet, so that you can't accidentally hit the wrong target with your shiny new tools, or release malware to the wild; you also get the added bonus of being able to take your machine(s) with you and work offline if you're travelling (or on holiday!). You also tend to have fewer conneciton issues, there are fewer fees or barriers to entry and you don't need killer internet.

The downside is that offline targets take more resources and can take a little bit more time to set up.

### Tech configuration

The most basic, but often most effective, way of learning with offline techniques is building things. If you're not able to do any of the following, I recommend considering doing them as a learning task early on in your training plan:

1. Installing and configuring a Windows server and client in a secure manner; bonus points for implementing central authentication & other services. Hint - free online training can help here.
1. Installing and working in a Linux environment; get comfortable using the command line (it's not dead yet by a long shot) and satisfy yourself you can find files by name, content & permissions. Can you see what processes are running, who's logged in, can you check some basic logs, can you manage adn configure a service like ssh?
1. Basic Scripting and programming - this one marries really well with 1 & 2; try using native scripting languages like Powershell adn Bash to find files on computers. Try some basic python, maybe do an online course.

The above are examples you could usea s a start; you don't need to take them to the far end of one, but cosnider getting to a reasonable working level in each, to help you with other tasks.

### Vulnerable targets

OK the juicy offline stuff! In this category are the things I really like to see people get started on; this involves getting hold of vulnearble machine builds, putting them on a computer (usually virtually, but we'll come on to that), and breaking in to them.

There are a whole host of these out there, but I almost always send people to [Vulnhub](https://www.vulnhub.com/); Metasploitable is often recommended as a begineer task, but I'd give caution, as it's lack of workflow and artificial nature can sometimes confuse, or demotivate people.

I like to start people on a [Mr robot themed machine](https://www.vulnhub.com/entry/mr-robot-1,151/); many people are fans of the show (which helps with keeping interest) and I think it's a nice balance of realism and simplicity. As an added bonus, I have produced a [learning-oriented walkthrough]() for the machine, to turn it into a proper learning experience.

Machines aren't the only thing you could go for; you could look to do some wireless security testing in your local environment, you may decide you'd like

### Homebrew Victims

A third option (which in most cases is really jsimilar to the last) is making homebrew targets. This can give you a nice halfway house between dedicated offline targets and online services; you can use vulnerable applications, or old machines to test your skills against, without the hard requirement for running dedicated target machines,though you should, as you may crash or corrupt the device you're working with, and you may lose some of the separation benefits we've discussed so far.

OWASP offer a [vulnerable web server] (https://github.com/OWASP/Vulnerable-Web-Application) project, the [Damn Vulnerable Web Application] (http://www.dvwa.co.uk/) project offers a slightly more useable alternative and there are others avilable too.

These have the appeal of not requiring a dedicated machine, but I usually don't recommend them at first due to the extensive setup effort adn the chance that you may have misconfigurations that affect your learning.

# So go and do it!

Hopefully you have a rough idea now of where you want your learning to take you. Depending on your current experience, you may want to take a look at windows configuration, or the Linux [bandit](https://overthewire.org/wargames/bandit/) challenge, or you may be comfortable with your knowledge and ready to jump straight into some vulnerable VMs, or a virtal lab.

## Still not sure?

Ok then, you need a nudge don't you? It's ok to not be sure and I'm happy to provide some hints, here goes!

If you can install windows machines, get a server talking to a client, use Powershell to {download a file, find a file on disk and ping all hosts on your local network} then skip basic windows learning; otherwise, configure a Windows server and client, in a mini Active Directory environment. Make sure you comply with licencing requriements, even if you use [evaluation copies](https://www.microsoft.com/en-us/evalcenter/).

If you can install Linux and use the command line to {find a file, add a new user, list running processes, configure and enable ssh on port 9999 and ping evey host on your local network} then skip bandit and local linux config tasks; otherwise, install some linux in a lab environment (see next post) and/or complete the [bandit](https://overthewire.org/wargames/bandit/) overthewire challenge.

If you know what an IP address is, what a network port, MAC address and the difference between a router adn switch is, then skip a basic networking course for now (but it's super important - you'll pick more up and train as required), otherwise, try a free course like Cybrary's [CompTIA Network +] (https://www.cybrary.it/course/comptia-network-plus/) offering.

If you know the basics of how websites are programmed and you know your HTML from our Javascript, what an SQL query is and how CSS works (note, you don't need to be a master), then skil any web learning, otherwise, consider completing some web programming learning, like that offered by [codeacademy](https://www.codecademy.com/learn/paths/web-development) or [w3schools ](https://www.w3schools.com/). Just getting a rough understanding at this point will help.

Otherwise, I recommend you try the [Mr Robot Capture the Flag](https://www.vulnhub.com/entry/mr-robot-1,151/) challenge as a starter task, using my (very excellent) [walkthrough]() as a training guide.

In due time, I'd recommend you bolster your web programming knowledge with anotehr programmign or scriptiong language, though this isn't wholly essential at first (IMO). I like Python and codeacademy](https://www.codecademy.com/learn/learn-python) offer good training. This one is up to you though!

After that, you should have a feel fro where you'd like to go now; as always, contact me via social for more thoughts and advice.

# What's next?

I've told you what to do, but how do you do it? Well I believe it all starts with getting your lab together, so let's head over to the next post [building a lab]() and get our house in order to get cracking.
